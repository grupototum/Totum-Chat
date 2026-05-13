#!/bin/bash
set -e

echo '======================================'
echo ' TOTUM-CHAT Setup — Fase 1'
echo '======================================'

# 1. Adicionar totum ao grupo docker
echo '[1/4] Adicionando totum ao grupo docker...'
usermod -aG docker totum
echo '✓ totum adicionado ao docker group'

# 2. Config Nginx
echo '[2/4] Configurando Nginx para chat.grupototum.com...'
cat > /etc/nginx/sites-available/chat.grupototum.com << 'NGINX'
server {
    listen 80;
    server_name chat.grupototum.com;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name chat.grupototum.com;

    ssl_certificate /etc/letsencrypt/live/chat.grupototum.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/chat.grupototum.com/privkey.pem;

    location / {
        proxy_pass http://127.0.0.1:3210;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection '"upgrade"';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_read_timeout 300s;
    }
}
NGINX

ln -sf /etc/nginx/sites-available/chat.grupototum.com /etc/nginx/sites-enabled/
echo '✓ Nginx config criada'

# 3. SSL com certbot
echo '[3/4] Obtendo certificado SSL...'
certbot certonly --nginx -d chat.grupototum.com --non-interactive --agree-tos -m totumpersonalizados@gmail.com 2>&1
echo '✓ SSL configurado'

# 4. Reload Nginx
nginx -t && systemctl reload nginx
echo '✓ Nginx recarregado'

echo ''
echo '======================================'
echo ' ✅ Setup completo!'
echo ' Agora execute como usuário totum:'
echo '   cd ~/totum-chat && docker compose up -d'
echo '======================================'
