# Deploy

## Pré-requisitos

- Docker e Docker Compose
- Nginx com certificados TLS para `chat.grupototum.com`
- `.env` criado a partir de `.env.example`
- Ollama local opcional disponível para o container via `host.docker.internal`

## Bootstrap de um VPS Novo

```bash
git clone https://github.com/grupototum/Totum-Chat.git /home/totum/totum-chat
cd /home/totum/totum-chat
cp .env.example .env
```

Edite o `.env` com valores reais. Não commite esse arquivo.

```bash
sh scripts/validate-env.sh .env
docker compose pull
docker compose up -d
docker compose ps
```

Instale a configuração do Nginx:

```bash
cp nginx/chat.grupototum.com.conf /etc/nginx/conf.d/domains/chat.grupototum.com.conf
nginx -t
systemctl reload nginx
```

Valide:

```bash
sh scripts/validate-env.sh .env
curl -I https://chat.grupototum.com
curl -L https://chat.grupototum.com/chat
curl -I -H 'Accept-Language: en-US,en;q=0.9' https://chat.grupototum.com/chat
docker inspect -f '{{.State.Health.Status}}' totum-chat
sh scripts/healthcheck-wrapper.sh https://chat.grupototum.com/chat
```

Abra `https://chat.grupototum.com/chat` em uma janela anônima e confirme se a primeira experiência carrega em português do Brasil.

## Nota de Produção de 2026-05-13

O diagnóstico real do `502` foi: Nginx apontava `chat.grupototum.com` para `127.0.0.1:3210`, mas o container `totum-chat` não existia/estava parado. O container foi recriado e validado:

- Local `http://127.0.0.1:3210/chat`: HTTP 200
- Origem Nginx direta para `chat.grupototum.com/chat`: HTTP 200
- Público `https://chat.grupototum.com/chat`: HTTP 200
- `totum-chat`: `healthy`

A configuração de produção vive em `/home/totum/totum-chat` com:

- `docker-compose.yml`
- `.env`
- `agents-index.json`
- `public/agents-index.json`
- `src/alexandria-integration.js`
- `setup.sh`

O backup diário inclui `/home/totum/totum-chat`, e o healthcheck global monitora o container `totum-chat`.
