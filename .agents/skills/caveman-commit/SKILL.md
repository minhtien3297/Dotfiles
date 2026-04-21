---
name: caveman-commit
description: >
  Generate terse commit messages. Conventional Commits format. ≤50 char subject.
  Use via /caveman-commit when user wants commit message.
---

Generate commit message following caveman terseness.

## Rules

- Subject line: ≤50 characters
- Format: `type(scope): subject` (Conventional Commits)
- Why over what. Action verb first.
- No filler (add/fix/update not "添加/修复/更新", "added/fixed/updated")
- Body: only if complex change need context. Max 72 chars per line.

## Examples

```
fix(auth): token expiry use < not <=

feat(api): add rate limit endpoint

refactor(db): pool connections, reduce handshake

docs(readme): add install section

test(auth): add expiry boundary cases
```

## Process

1. Analyze diff - what change do?
2. Determine type: feat/fix/refactor/docs/test/chore/perf/ci
3. Add scope if affects specific area
4. Write subject: verb + what + why-short
5. Verify ≤50 chars