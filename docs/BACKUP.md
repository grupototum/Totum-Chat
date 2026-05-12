# Backup

Back up these items periodically:

- VPS `.env` for this service, stored outside git in a secure password manager.
- Nginx config for `chat.grupototum.com`.
- Cloudflare tunnel credentials if a tunnel is used.
- Browser/client-side LobeChat data if users rely on local IndexedDB rather than server-side persistence.
- Any future database volume if the deployment is moved to server-side LobeChat persistence.

Do not back up secrets into this repository.

Suggested recovery test:

1. Start a new VPS.
2. Clone this repository.
3. Restore `.env` from the password manager.
4. Run `docker compose up -d`.
5. Reapply Nginx and TLS.
6. Register the Alexandria plugin again from `docs/PLUGIN_ALEXANDRIA.md`.
