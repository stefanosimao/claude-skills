# Axis Checklists — paste the relevant one, in full, into each sub-agent prompt

## SECURITY (Anderson: Security Engineering · Stuttard & Pinto: WAHH · Ball: Hacking APIs)
Per trust-boundary type touched by the diff:
- **Web endpoint / handler:** authn present & correct? authz checked per-object (IDOR) not just per-route? input validated/canonicalized at the boundary (not deep inside)? output encoding for the sink (HTML/SQL/shell/log)? CSRF where state-changing + cookie-authed? rate limiting on auth/expensive ops?
- **API:** same as above + mass assignment (unbounded object binding), excessive data exposure in responses, BOLA/BFLA (object/function-level authz), versioned auth on new routes, error messages leaking internals.
- **Data layer:** parameterized queries only (any string-built SQL/NoSQL/LDAP?); least-privilege connection; sensitive fields encrypted at rest where policy demands; PII in logs?
- **Config/secrets:** credentials, tokens, keys in code, config, fixtures, or CI files? secure defaults (TLS on, debug off)? new environment variables documented & scoped?
- **Crypto:** rolled-own primitives? ECB/static IV/weak hash (MD5/SHA1 for auth)? passwords hashed with a slow KDF? comparisons constant-time where relevant?
- **Deserialization/SSRF/files:** untrusted data deserialized (pickle/ObjectInputStream/yaml.load)? URLs fetched from user input (SSRF — allowlist?)? path traversal on file ops? upload type/size checks?
- **Dependencies:** new packages — maintained? known CVEs? install scripts? name plausible (typosquatting)?

## DEFECTS (McConnell: Code Complete · Hunt & Thomas: Pragmatic Programmer · Feathers: Legacy Code)
- **Error paths:** every failable call handled or consciously propagated? catch blocks that swallow? cleanup on the error path (files, locks, transactions) — resource balance: what opens must close, on ALL paths?
- **Edge inputs:** empty collection, null/undefined, zero, negative, max-size, unicode/encoding, duplicate entries, already-processed input (idempotency)?
- **Boundaries:** off-by-one in loops/slices/pagination; inclusive/exclusive contract stated? timezone/DST on date math? float equality?
- **Concurrency:** shared mutable state without synchronization? check-then-act races (TOCTOU)? async ordering assumptions? deadlock ordering on multiple locks?
- **Contracts:** assertions/guards for "can't happen" states (crash early beats corrupt late)? function honors its name (no surprise side effects)?
- **Legacy contact:** diff touches untested existing code → is there a seam to test through; were characterization tests written BEFORE the change?

## PERFORMANCE (Kleppmann: DDIA — systems/IO · Skiena: Algorithm Design Manual — compute · Bentley: Programming Pearls — estimation)
- **N+1:** loop bodies with queries/API calls? missing eager-load/batch/join?
- **Complexity (Skiena Ch 2):** nested iteration over unbounded collections on a hot path? accidental O(n²) via repeated scans/`in` on lists? sort inside loop? State the change in dominance-order terms (n² → n log n → n), not vibes.
- **Container vs. access pattern (Skiena Ch 3 + catalog §15.1–15.2):** linear scan where a dict/hash belongs; list where a priority queue belongs; repeated membership tests on a list. Calibration: the *wrong* structure is disastrous, the *best* structure rarely matters — flag the disaster, don't bikeshed the optimum.
- **Recomputation (Skiena Ch 10):** recursion or loop recomputing the same subresult — memoization is usually a one-line fix; a left-to-right ordering over the data means a real DP is available.
- **Reinvented classics (Skiena §8.7 + catalog Ch 18):** hand-rolled traversal/path-finding/scheduling logic that is a named algorithm under another name — look it up before reviewing the implementation.
- **Data volume:** unbounded SELECT/fetch (no LIMIT/pagination/streaming)? full table load to filter in memory? response payloads unbounded?
- **Memory:** collections that only grow (caches without eviction)? large objects retained by closures/listeners?
- **Back-of-envelope:** for any data-touching change, demand the estimate: rows × bytes × frequency — does it survive 10x? indexes present for new query predicates?
- **Isolation & retries:** transactions long/wide enough to contend? retry loops without backoff/jitter? work inside transactions that could sit outside?

## TESTS (Khorikov: Unit Testing P/P/P — the decision framework · Beck: TDD By Example — the foundation · SWE@Google · Percival · Molina)
- **Is this test worth having? (Khorikov ch. 4):** score it on the four pillars — protection against regressions, resistance to refactoring, fast feedback, maintainability. The first three trade off; **resistance to refactoring is non-negotiable**. A test that fails when behaviour is unchanged is a false positive and a net negative.
- **Should this have been mocked? (Khorikov §8.2 — the highest-yield rule on this axis):** mock **unmanaged** dependencies (out-of-process, observable by others: message buses, third-party APIs) — do NOT mock **managed** ones (out-of-process but private to the app: your own database). Mocking a managed dependency couples the test to implementation. This is a yes/no rule, not a preference.
- **Coverage of the change:** every behavioral change has a test at its public seam? bug fix includes the regression test that fails pre-fix?
- **Test honesty:** assertions on behavior, not implementation (no internal-mock verification, no private-method tests)? expected values independent (no recomputing the formula under test)? would the test fail if the feature broke?
- **Test smells:** over-mocking (internal collaborators mocked → refactor-brittle); mystery guest (hidden fixtures); eager test (asserting everything); conditional logic inside tests; sleeps instead of synchronization (flakiness); order-dependent tests.
- **Size & speed (SWE@Google):** smallest test size that can catch the behavior? new test needs network/DB it doesn't use? hermetic (no shared state between tests)?
- **Python-specific (when applicable):** fixtures over setUp sprawl; pytest parametrize for input matrices; mocks patched where USED not where defined; async tests actually awaited.
