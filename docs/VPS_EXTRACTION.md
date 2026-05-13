# Checklist de Extração do VPS

Este checklist documenta como repetir a extração dos arquivos operacionais de `/home/totum/totum-chat`.

Status em 2026-05-13: extração concluída, arquivos versionados e varredura de segredos sem achados reais.

Inventário obrigatório:

- `agents-index.json`
- `public/agents-index.json`
- `src/alexandria-integration.js`
- `setup.sh`

Fluxo de extração:

```bash
ssh <vps-user>@<vps-host> 'cd /home/totum/totum-chat && sha256sum agents-index.json public/agents-index.json src/alexandria-integration.js setup.sh'
ssh <vps-user>@<vps-host> 'cd /home/totum/totum-chat && tar -czf - docker-compose.yml agents-index.json public/agents-index.json src/alexandria-integration.js setup.sh nginx-chat.conf' \
  | tar -xzf - -C /tmp/totum-chat-vps-current
```

Antes de commitar, inspecione todos os arquivos em busca de segredos:

```bash
rg -n "key|token|secret|password|bearer|authorization|apikey|api_key" agents-index.json public src setup.sh
```

Se algum arquivo contiver segredos de runtime, substitua por variáveis de ambiente e documente a variável em `.env.example`.
