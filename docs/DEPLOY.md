# Deploy

## Prerequisites

- Docker and Docker Compose
- Nginx with TLS certificates for `chat.grupototum.com`
- `.env` created from `.env.example`
- Optional local Ollama available to the container through `host.docker.internal`

## Fresh VPS Bootstrap

```bash
git clone https://github.com/grupototum/Totum-Chat.git /opt/totum-chat
cd /opt/totum-chat
cp .env.example .env
```

Edit `.env` with real values. Do not commit it.

```bash
docker compose pull
docker compose up -d
docker compose ps
```

Install the Nginx config:

```bash
cp nginx/chat.grupototum.com.conf /etc/nginx/conf.d/domains/chat.grupototum.com.conf
nginx -t
systemctl reload nginx
```

Validate:

```bash
curl -I https://chat.grupototum.com
curl -L https://chat.grupototum.com/chat
docker inspect -f '{{.State.Health.Status}}' lobe-chat
```

## Production Note From 2026-05-12

Nginx on the Hostinger VPS points `chat.grupototum.com` to `127.0.0.1:3210`, but no container/process was listening on that port at inventory time. Before replacing production, confirm whether Cloudflare is pointing at a different origin or whether another deployment path is serving the current LobeChat instance.
