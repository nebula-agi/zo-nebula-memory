#!/usr/bin/env bash
# Nebula memory CLI — search and store memories via MCPorter.
#
# Usage:
#   memory.sh search <query>
#   memory.sh add <content>
#
# MCPorter version — keep in sync with setup_nebula.sh
set -euo pipefail

MCPORTER_VERSION="0.7.3"
MCPORTER_CONFIG="$HOME/.mcporter/mcporter.json"
NEBULA_ENV="$HOME/.config/nebula/zo.env"

# Load credentials
if [ -f "$NEBULA_ENV" ]; then
  source "$NEBULA_ENV"
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

usage() {
  echo "Usage: memory.sh <command> <args>"
  echo ""
  echo "Commands:"
  echo "  search <query>     Search memories by keyword"
  echo "  add <content>      Store a new memory"
  exit 1
}

if [ $# -lt 2 ]; then
  usage
fi

COMMAND="$1"
shift

case "$COMMAND" in
  search)
    npx -y "mcporter@${MCPORTER_VERSION}" --config "$MCPORTER_CONFIG" call 'nebula-memory.search_memories' query:"$*"
    ;;
  add)
    npx -y "mcporter@${MCPORTER_VERSION}" --config "$MCPORTER_CONFIG" call 'nebula-memory.add_memory' content:"$*"
    ;;
  *)
    echo "Unknown command: $COMMAND"
    usage
    ;;
esac
