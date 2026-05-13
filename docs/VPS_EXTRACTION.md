# VPS Extraction Checklist

This repository is not production-complete until the historical files below are recovered from `/home/totum/totum-chat`, sanitized and either versioned or explicitly replaced.

Required inventory:

- `agents-index.json`
- `public/agents-index.json`
- `src/alexandria-integration.js`
- `setup.sh`

Extraction flow:

```bash
ssh <vps-user>@<vps-host> 'cd /home/totum/totum-chat && sha256sum agents-index.json public/agents-index.json src/alexandria-integration.js setup.sh'
scp <vps-user>@<vps-host>:/home/totum/totum-chat/agents-index.json ./agents-index.json
scp <vps-user>@<vps-host>:/home/totum/totum-chat/public/agents-index.json ./public/agents-index.json
scp <vps-user>@<vps-host>:/home/totum/totum-chat/src/alexandria-integration.js ./src/alexandria-integration.js
scp <vps-user>@<vps-host>:/home/totum/totum-chat/setup.sh ./setup.sh
```

Before committing, inspect every file for secrets:

```bash
rg -n "key|token|secret|password|bearer|authorization|apikey|api_key" agents-index.json public src setup.sh
```

If any file contains runtime secrets, replace them with environment variables and document the variable in `.env.example`.
