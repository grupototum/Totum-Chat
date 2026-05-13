#!/usr/bin/env sh
set -eu

URL="${1:-https://chat.grupototum.com/chat}"

status=""

if command -v curl >/dev/null 2>&1; then
  status="$(curl -L -sS -o /dev/null -w '%{http_code}' "$URL" || true)"
elif command -v wget >/dev/null 2>&1; then
  status="$(wget -S -O /dev/null "$URL" 2>&1 | awk '/HTTP\// { code=$2 } END { print code }')"
elif command -v node >/dev/null 2>&1; then
  status="$(node -e "
const http = require('node:http');
const https = require('node:https');
const url = new URL(process.argv[1]);
const client = url.protocol === 'https:' ? https : http;
const req = client.request(url, { method: 'HEAD', timeout: 8000 }, (res) => {
  console.log(res.statusCode || '');
  res.resume();
});
req.on('timeout', () => req.destroy(new Error('timeout')));
req.on('error', () => {
  console.log('');
  process.exitCode = 1;
});
req.end();
" "$URL" || true)"
else
  echo "Healthcheck do Totum Chat falhou: curl, wget ou node é obrigatório" >&2
  exit 1
fi

if [ "$status" != "200" ]; then
  echo "Healthcheck do Totum Chat falhou: HTTP ${status:-desconhecido} em $URL" >&2
  exit 1
fi

echo "Totum Chat saudável: $URL"
