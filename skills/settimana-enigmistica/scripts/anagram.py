#!/usr/bin/env python3
"""Letter-bank tools for Italian word puzzles.
Usage:
  anagram.py "LETTERS"                      -> normalized bank + length
  anagram.py "LETTERS" --check WORD         -> exact anagram? (yes/no + diff)
  anagram.py "LETTERS" --sub WORD           -> does WORD fit inside the bank? (scarti/zeppe)
  anagram.py "LETTERS" --wordlist FILE      -> all exact anagrams from a wordlist
  anagram.py "LETTERS" --wordlist FILE --min N --contained -> all words length>=N inside the bank
"""
import sys, argparse, unicodedata
from collections import Counter

def norm(s):
    s = unicodedata.normalize("NFD", s.lower())
    return "".join(c for c in s if c.isalpha() and not unicodedata.combining(c))

def main():
    p = argparse.ArgumentParser()
    p.add_argument("letters"); p.add_argument("--check"); p.add_argument("--sub")
    p.add_argument("--wordlist"); p.add_argument("--min", type=int, default=4)
    p.add_argument("--contained", action="store_true")
    a = p.parse_args()
    bank = Counter(norm(a.letters))
    print(f"bank: {''.join(sorted(bank.elements()))} ({sum(bank.values())} letters)")
    if a.check:
        w = Counter(norm(a.check))
        if w == bank: print(f"YES — '{a.check}' is an exact anagram")
        else:
            missing = "".join(sorted((bank - w).elements())); extra = "".join(sorted((w - bank).elements()))
            print(f"NO — unused in bank: '{missing or '-'}', not in bank: '{extra or '-'}'")
    if a.sub:
        w = Counter(norm(a.sub))
        rest = "".join(sorted((bank - w).elements()))
        print(f"{'FITS' if not (w - bank) else 'DOES NOT FIT'} — remainder: '{rest}'" if not (w-bank) else "DOES NOT FIT")
    if a.wordlist:
        hits = []
        with open(a.wordlist, encoding="utf-8", errors="ignore") as f:
            for line in f:
                w = norm(line.strip())
                if len(w) < a.min: continue
                c = Counter(w)
                if (a.contained and not (c - bank)) or (not a.contained and c == bank):
                    hits.append(line.strip())
        print(f"{len(hits)} match(es):"); [print(" ", h) for h in hits[:200]]

if __name__ == "__main__": main()
