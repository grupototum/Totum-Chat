# Backup

Faça backup destes itens periodicamente:

- `.env` deste serviço no VPS, armazenado fora do Git em um gerenciador de senhas seguro.
- Configuração Nginx de `chat.grupototum.com`.
- Credenciais do túnel da Cloudflare, caso um túnel seja usado.
- Dados do Chat Totum no navegador/client-side, caso os usuários dependam do IndexedDB local em vez de persistência server-side.
- Qualquer volume de banco futuro, caso o deploy migre para persistência server-side do Chat Totum.

Não faça backup de segredos dentro deste repositório.

Teste de recuperação sugerido:

1. Suba um VPS novo.
2. Clone este repositório.
3. Restaure o `.env` a partir do gerenciador de senhas.
4. Rode `docker compose up -d`.
5. Reaplique Nginx e TLS.
6. Cadastre novamente o plugin Alexandria seguindo `docs/PLUGIN_ALEXANDRIA.md`.
