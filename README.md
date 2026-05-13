# Totum Chat

Configuração de deploy do `chat.grupototum.com`, a instância Chat Totum auto-hospedada da Totum.

Este repositório guarda intencionalmente apenas configuração reproduzível, documentação e assets públicos da marca. Segredos de runtime ficam no `.env` do servidor e nunca devem ser commitados.

## Retrato Atual de Produção

- URL pública: `https://chat.grupototum.com/chat`
- Upstream local esperado na Hostinger: `127.0.0.1:3210`
- Proxy reverso: configuração Nginx extraída de `/etc/nginx/conf.d/domains/chat.grupototum.com.conf`
- Fonte da configuração no VPS encontrada em 2026-05-13: `/home/totum/totum-chat`
- Fonte dos assets de marca: `/Users/israellemos/Documents/Claude/Projects/Totum OS/branding`

## Observação Importante

Em 2026-05-13, o Nginx da Hostinger apontava `chat.grupototum.com` para `127.0.0.1:3210`, mas o container `totum-chat` não existia/estava parado; por isso a origem retornava `502 Bad Gateway`. O container foi recriado, subiu saudável em `127.0.0.1:3210`, e as rotas local, origem Nginx e pública passaram a responder HTTP 200.

## Arquivos Extraídos do VPS

Os arquivos abaixo foram extraídos de `/home/totum/totum-chat` em 2026-05-13 e versionados após varredura de segredos:

- `agents-index.json`
- `public/agents-index.json`
- `src/alexandria-integration.js`
- `setup.sh`

Use o [Checklist de Extração do VPS](docs/VPS_EXTRACTION.md) para repetir a conferência antes de qualquer novo deploy.

## Documentação

- [Deploy](docs/DEPLOY.md)
- [Backup](docs/BACKUP.md)
- [Plugin Alexandria](docs/PLUGIN_ALEXANDRIA.md)
- [Branding](branding/README.md)
- [Localização PT-BR](docs/LOCALIZACAO_PT_BR.md)
- [Checklist de Extração do VPS](docs/VPS_EXTRACTION.md)
