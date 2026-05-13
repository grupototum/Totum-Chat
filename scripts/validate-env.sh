#!/usr/bin/env sh
set -eu

ENV_FILE="${1:-.env}"

if [ ! -f "$ENV_FILE" ]; then
  echo "Missing $ENV_FILE. Copy .env.example to .env and fill real values." >&2
  exit 1
fi

required_vars="
LOBE_CHAT_IMAGE_TAG
GROQ_API_KEY
GOOGLE_API_KEY
OLLAMA_PROXY_URL
ACCESS_CODE
DEFAULT_AGENT_CONFIG
SYSTEM_AGENT
AGENTS_INDEX_URL
ALEXANDRIA_API_URL
ALEXANDRIA_ENABLED
RAG_CHUNK_SIZE
RAG_SEARCH_LIMIT
"

missing=""
placeholder=""

for key in $required_vars; do
  line="$(grep -E "^${key}=" "$ENV_FILE" | tail -n 1 || true)"
  value="${line#*=}"

  if [ -z "$line" ] || [ -z "$value" ]; then
    missing="${missing} ${key}"
    continue
  fi

  case "$value" in
    *replace_me*|*"REPLACE_ME"*|*"changeme"*|*"CHANGE_ME"*|"<"*">"*)
      placeholder="${placeholder} ${key}"
      ;;
  esac
done

if [ -n "$missing" ]; then
  echo "Missing required env vars:${missing}" >&2
  exit 1
fi

if [ -n "$placeholder" ]; then
  echo "Replace placeholder values before deploy:${placeholder}" >&2
  exit 1
fi

echo "Environment file validated: $ENV_FILE"
