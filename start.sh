#!/bin/bash

# Ngrok tokenni o‘rnatamiz
ngrok authtoken $NGROK_AUTHTOKEN

# Ngrok orqali 19132-portga tunnel ochamiz
ngrok tcp 19132 > /dev/null &

# Ngrok URL ni olish uchun 5 soniya kutamiz
sleep 5
NGROK_URL=$(curl -s http://127.0.0.1:4040/api/tunnels | jq -r '.tunnels[0].public_url')

echo "Ngrok tunnel ochildi: $NGROK_URL"

# Nukkit serverni ishga tushiramiz
exec java -jar nukkit.jar
