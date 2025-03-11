# 1. Imagen base de Node (Alpine)
FROM node:18-alpine

# 2. Creamos carpeta de trabajo y copiamos tu proyecto
WORKDIR /app
COPY . .

# 3. Instalamos dependencias del sistema necesarias
RUN apk add --no-cache unzip curl

# 4. Instalamos n8n global (si no lo haces en package.json)
RUN npm install -g n8n

# 5. Instalamos dependencias de tu proyecto (si tuvieras package.json con otras libs)
RUN npm install

# 6. Descargamos Ngrok y lo ponemos en /usr/local/bin
RUN curl -s https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -o ngrok.zip \
    && unzip ngrok.zip \
    && mv ngrok /usr/local/bin \
    && rm ngrok.zip

# 7. Exponemos el puerto 5678 (donde corre n8n)
EXPOSE 5678

# 8. Copiamos el script de arranque y le damos permisos
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 9. Definimos un CMD por defecto (por si Docker corre sin Start Command)
CMD ["/entrypoint.sh"]
