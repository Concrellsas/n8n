#!/bin/sh
# Arrancamos Ngrok en segundo plano
ngrok http 5678 --log=stdout &

# Luego iniciamos n8n
n8n start
