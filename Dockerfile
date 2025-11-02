FROM ghcr.io/mckaywrigley/chatbot-ui:main as chatbotui
FROM ollama/ollama:0.12.9

RUN apt update && 
    apt install -y curl nginx nodejs && 
      rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
COPY nginx.conf /etc/nginx/nginx.conf

ENV MODELS "deepseek-r1:7b"
RUN chmod +x /entrypoint.sh

WORKDIR /chatbotui
COPY --from=chatbotui /app/node_modules ./node_modules
COPY --from=chatbotui /app/.next ./.next
COPY --from=chatbotui /app/public ./public
COPY --from=chatbotui /app/package*.json ./
COPY --from=chatbotui /app/next.config.js ./next.config.js
COPY --from=chatbotui /app/next-i18next.config.js ./next-i18next.config.js

ENTRYPOINT ["/entrypoint.sh"]
