FROM ghcr.io/open-webui/open-webui:main as openwebui

RUN apt update && apt install curl -y
RUN curl -fsSL https://ollama.com/install.sh | sh

ENV MODELS="llama3 deepseek-r1:8b"
ENV OLLAMA_BASE_URL="http://localhost:11434"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
