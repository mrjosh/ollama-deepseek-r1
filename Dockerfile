FROM ghcr.io/open-webui/open-webui:main as openwebui

RUN apt update && apt install curl -y
RUN pip install vllm

ENV OLLAMA_BASE_URL="http://localhost:8000/v1"
ENV MODEL="deepseek-ai/DeepSeek-R1-Distill-Qwen-32B"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000
EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
