# 1. Usa Node 18 como base
FROM node:18-alpine

# 2. Crea y usa la carpeta /app dentro del contenedor
WORKDIR /app

# 3. Copia tu proyecto (el package.json, etc.) dentro del contenedor
COPY . .

# 4. Instala n8n (opción A: global)
RUN npm install -g n8n

# (opción B: si en tu package.json ya tienes n8n, puedes omitir la línea anterior
# y luego usar npx n8n en lugar de n8n en el CMD)

# 5. Instala dependencias del proyecto (si las hay)
RUN npm install

# 6. Instala unzip y curl (para descargar Ngrok)
RUN apk add --no-cache unzip curl

# 7. Descarga y coloca Ngrok en /usr/local/bin
RUN curl -s https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -o ngrok.zip \
    && unzip ngrok.zip \
    && mv ngrok /usr/local/bin \
    && rm ngrok.zip

# 8. Expone el puerto 5678 (donde corre n8n)
EXPOSE 5678

# 9. Al iniciar el contenedor, primero arranca Ngrok (en background), luego n8n
CMD ngrok http 5678 --log=stdout & n8n start
