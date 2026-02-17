---
name: nebula-memory
description: |
  Persistent memory for Zo via Nebula. Search and store cross-conversation context such as
  preferences, decisions, corrections, and durable project details. Use proactively when prior
  context may matter, when users ask to remember/recall information, or when starting substantive tasks.
metadata:
  author: trynebula
  category: Community
---

# Nebula Memory

Persistent memory across conversations. Run from anywhere:

```bash
bash /home/workspace/Skills/nebula-memory/scripts/memory.sh search "auth library preference"
bash /home/workspace/Skills/nebula-memory/scripts/memory.sh add "User prefers JWT with 15-min expiry"
```

## Commands

### search

Search memories by keyword. Use short keyword phrases, not full sentences.

```bash
bash /home/workspace/Skills/nebula-memory/scripts/memory.sh search "acme deploy target"
bash /home/workspace/Skills/nebula-memory/scripts/memory.sh search "zo ui test framework"
bash /home/workspace/Skills/nebula-memory/scripts/memory.sh search "frontend routing decision"
```

### add

Store a new memory. Be specific and self-contained — the memory should make sense months later.

```bash
bash /home/workspace/Skills/nebula-memory/scripts/memory.sh add "acme app | user | routing: decided on Next.js App Router over Pages Router for better RSC support"
bash /home/workspace/Skills/nebula-memory/scripts/memory.sh add "acme app: auth -> JWT with 15-min expiry. Why: balances security and UX."
```

## For Zo

Use `memory.sh` proactively — don't wait to be asked.

### On every new conversation

1. Run `memory.sh search` with keywords from the user's first meaningful message.
2. Weave relevant results into your response naturally — don't mention a "memory database".

Skip the startup search for vague openers like "hey" or "what's up".

### When to search

- User references prior work: "last time", "do you remember", "what did we decide"
- You are about to give advice and the user may have a known preference
- Task is in a known project/domain where earlier decisions likely exist
- Earlier search results were weak — try 2-3 alternate keyword queries

### When to store

- **Every conversation turn** — after each user message and each assistant response
- User explicitly asks: "remember", "save", "note", "don't forget"
- User states a preference or convention: "we use X, not Y"
- A decision is made after discussion (include the reasoning)
- User corrects you — store the correction so you don't repeat the mistake
- Important finding or workaround that will matter again
- Durable project details that are costly to rediscover

**Do NOT store:** secrets, API keys, passwords, tokens.

**Quality bar:**
- Preserve full meaning of the turn — avoid lossy compression
- Include role and context: `user` vs `assistant`, project/topic
- If a turn is very large, split across multiple `memory.sh add` calls

Preferred format for turn storage:

```bash
bash /home/workspace/Skills/nebula-memory/scripts/memory.sh add "<project> | <role:user|assistant> | <topic>: <full turn content>"
```

Optional format for extracted facts:

```bash
bash /home/workspace/Skills/nebula-memory/scripts/memory.sh add "<project>: <topic> -> <decision>. Why: <reason>."
```

### Using search results

- Use relevant context naturally — don't say "according to my memory database"
- If a memory conflicts with what the user is saying now, mention it: "Previously you mentioned X — has that changed?"
- If no relevant memory is found, proceed normally

### Consistency rules

- Store every turn; do not skip turns just because they seem repetitive
- Avoid accidental exact duplicates caused by retries/resubmits
- If context changed, store the updated version

## Behavior summary

| User signal | Action |
|---|---|
| New conversation starts | `memory.sh search` with topic keywords |
| Any user or assistant turn | `memory.sh add` with the turn content |
| "Remember/save/note this" | `memory.sh add` |
| "What did we decide..." / "Do you remember..." | `memory.sh search` |
| User states preference/convention | `memory.sh add` |
| User corrects you | `memory.sh add` with the correction |
| Decision reached after discussion | `memory.sh add` with decision + reasoning |
| About to advise in familiar domain | `memory.sh search` first to check for preferences |
