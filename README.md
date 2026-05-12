# Totum Chat

Deploy configuration for `chat.grupototum.com`, the Totum self-hosted LobeChat/LobeHub instance.

This repository intentionally stores only reproducible configuration, documentation and public branding assets. Runtime secrets stay in `.env` on the server and must never be committed.

## Current Production Snapshot

- Public URL: `https://chat.grupototum.com/chat`
- Expected local upstream on Hostinger: `127.0.0.1:3210`
- Reverse proxy: Nginx config extracted from `/etc/nginx/conf.d/domains/chat.grupototum.com.conf`
- Branding source: `/Users/israellemos/Documents/Claude/Projects/Totum OS/branding`

## Important Finding

On 2026-05-12, the VPS had the Nginx route for `chat.grupototum.com`, but no running Docker container or listening process on port `3210`. The live site still served LobeChat through Cloudflare. Treat this repository as the desired rebuild kit and verify the actual production origin before a cutover.

## Docs

- [Deploy](docs/DEPLOY.md)
- [Backup](docs/BACKUP.md)
- [Alexandria Plugin](docs/PLUGIN_ALEXANDRIA.md)
- [Branding](branding/README.md)
