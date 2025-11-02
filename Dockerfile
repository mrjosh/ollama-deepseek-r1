FROM ollama/ollama:0.12.9

RUN apt-get update && apt-get install -y curl nginx && rm -rf /var/lib/apt/lists/*

COPY ollama-entrypoint.sh /ollama-entrypoint.sh
COPY ollama-nginx.conf /etc/nginx/nginx.conf

ENV MODELS "deepseek-r1:7b"

RUN chmod +x /ollama-entrypoint.sh

ENTRYPOINT ["/ollama-entrypoint.sh"]
