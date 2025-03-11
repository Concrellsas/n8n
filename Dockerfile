# Imagen base oficial de Node
FROM node:18-alpine

# Instalar n8n de manera global
RUN npm install -g n8n

# Instalar herramientas necesarias
RUN apk add --no-cache unzip curl

# Instalar Ngrok
RUN curl -s https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -o ngrok.zip \
    && unzip ngrok.zip \
    && mv ngrok /usr/local/bin \
    && rm ngrok.zip

# Variables de entorno por defecto
ENV N8N_HOST=localhost
ENV N8N_PROTOCOL=http
ENV WEBHOOK_TUNNEL_URL=http://localhost:5678

# Exponer el puerto de n8n
EXPOSE 5678

# Comando de arranque: inicia Ngrok en segundo plano y luego n8n
CMD ngrok http 5678 --log=stdout & n8n start
