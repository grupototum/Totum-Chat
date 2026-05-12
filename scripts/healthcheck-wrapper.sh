#!/usr/bin/env sh
set -eu

URL="${1:-https://chat.grupototum.com/chat}"

status="$(wget -S -O /dev/null "$URL" 2>&1 | awk '/HTTP\\// { code=$2 } END { print code }')"

if [ "$status" != "200" ]; then
  echo "Totum Chat healthcheck failed: HTTP ${status:-unknown} for $URL" >&2
  exit 1
fi

echo "Totum Chat healthy: $URL"
