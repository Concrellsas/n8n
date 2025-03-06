FROM n8nio/n8n:latest

USER root

# Instalar Cloudflare Tunnel (cloudflared)
RUN wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && \
    dpkg -i cloudflared-linux-amd64.deb && \
    rm cloudflared-linux-amd64.deb

# Directorio para credenciales de Cloudflare
RUN mkdir -p /home/node/.cloudflared && \
    chown -R node:node /home/node/.cloudflared

USER node

# Comando para iniciar Cloudflare Tunnel y luego n8n
CMD echo '${CLOUDFLARE_CREDENTIALS_JSON}' > /home/node/.cloudflared/<tu-tunnel-id>.json && \
    cloudflared tunnel run <nombre-del-tunel> & \
    n8n

