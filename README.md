# Totum Chat

Deploy configuration for `chat.grupototum.com`, the Totum self-hosted LobeChat/LobeHub instance.

This repository intentionally stores only reproducible configuration, documentation and public branding assets. Runtime secrets stay in `.env` on the server and must never be committed.

## Current Production Snapshot

- Public URL: `https://chat.grupototum.com/chat`
- Expected local upstream on Hostinger: `127.0.0.1:3210`
- Reverse proxy: Nginx config extracted from `/etc/nginx/conf.d/domains/chat.grupototum.com.conf`
- VPS config source discovered on 2026-05-13: `/home/totum/totum-chat`
- Branding source: `/Users/israellemos/Documents/Claude/Projects/Totum OS/branding`

## Important Finding

On 2026-05-13, forcing `chat.grupototum.com` to the Hostinger IP returned `502 Bad Gateway`, while the public Cloudflare route returned HTTP 200. The Hostinger VPS has a historical config directory at `/home/totum/totum-chat`, but no running process was listening on `127.0.0.1:3210` during inventory. Treat this repository as the rebuild kit and verify Cloudflare origin/DNS before a cutover.

## VPS Files Still To Extract

The following files exist in `/home/totum/totum-chat` and should be versioned in a follow-up once SSH is stable again:

- `agents-index.json`
- `public/agents-index.json`
- `src/alexandria-integration.js`
- `setup.sh`

Use [VPS Extraction Checklist](docs/VPS_EXTRACTION.md) before treating this repository as a complete production rebuild source.

## Docs

- [Deploy](docs/DEPLOY.md)
- [Backup](docs/BACKUP.md)
- [Alexandria Plugin](docs/PLUGIN_ALEXANDRIA.md)
- [Branding](branding/README.md)
- [VPS Extraction Checklist](docs/VPS_EXTRACTION.md)
