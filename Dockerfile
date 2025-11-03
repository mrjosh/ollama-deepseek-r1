FROM ghcr.io/open-webui/open-webui:main as openwebui

RUN apt update && apt install curl -y
RUN pip install vllm

ENV OLLAMA_BASE_URL="http://localhost:8000"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
