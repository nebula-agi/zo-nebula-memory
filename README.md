# Nebula Memory for Zo

Persistent memory for [Zo](https://zo.computer) powered by [Nebula](https://trynebula.ai). Stores and retrieves context across conversations so Zo remembers decisions, preferences, and prior work.

## Setup

1. Sign up at [trynebula.ai](https://trynebula.ai) and create a collection
2. Go to **MCP Setup** > select **Zo**
3. Copy the generated bash command and paste it into your Zo terminal

That's it. The command installs the skill, configures MCPorter, and verifies the connection.

## Important: Tell Zo to use Nebula Memory

After setup, Zo won't automatically use Nebula Memory — it will default to its built-in rules system. You need to either:

**Option A: Mention Nebula explicitly** when storing or recalling:
```
Use Nebula Memory to remember that I prefer TypeScript
```

**Option B: Create a Zo rule** (recommended) so it always uses Nebula Memory:
```
Create a rule: Always use Nebula Memory for storing and recalling information.
When a user says remember, save, note, or states a preference, run:
bash /home/workspace/Skills/nebula-memory/scripts/memory.sh add "<content>".
When a user asks about something from before or starts a new conversation, run:
bash /home/workspace/Skills/nebula-memory/scripts/memory.sh search "<keywords>".
Do not use the built-in Created rule feature — always use memory.sh instead.
```

## Usage

Once configured, Zo will use Nebula Memory to store and recall context. You can also run the commands directly:

```bash
# Search memories
bash /home/workspace/Skills/nebula-memory/scripts/memory.sh search "auth library preference"

# Store a memory
bash /home/workspace/Skills/nebula-memory/scripts/memory.sh add "User prefers PostgreSQL over MongoDB"
```

## What gets stored

- Preferences and conventions ("I always use TypeScript")
- Decisions and reasoning ("Went with Next.js App Router for RSC support")
- Corrections and clarifications
- Project setup details

Secrets, API keys, and passwords are never stored.

## Files

- `SKILL.md` — Skill definition and agent instructions
- `scripts/memory.sh` — CLI wrapper for search and add via MCPorter

## Requirements

- [Zo](https://zo.computer) account
- [Nebula](https://trynebula.ai) account with an API key and collection
- Node.js (for MCPorter)
- jq
