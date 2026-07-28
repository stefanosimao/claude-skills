# Audit — prototype (read-understand-gap) · @ ed37663 · 2026-07-28

**What:** Throwaway code answering ONE design question; two branches: LOGIC.md (interactive terminal app pushing a state machine through hard cases) vs UI.md (multiple radical variants on one route, URL-param switchable). Rules: throwaway-and-marked, one command to run, no persistence (in-memory; scratch DB clearly named if unavoidable), no polish, surface full state, capture on completion (validated decision → real code; prototype → throwaway branch + context pointer; verdict → issue/commit). Model-invoked.
**Deps:** project's own task runner/routing conventions; wayfinder consumes it as a ticket type; to-spec/to-tickets may inline its decision snippets.
**Security:** clean (UI.md gates prototype UI out of production builds — a positive control).
**Gaps/notes:** Phase-3 "impose taste before committing" doctrine. Nothing to complement.
**Audit outcome:** clean; no complement material.
