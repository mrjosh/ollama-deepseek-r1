FROM ghcr.io/open-webui/open-webui:main as openwebui

RUN apt update && apt install curl -y
RUN pip install vllm

ENV OPENAI_API_BASE_URL="http://localhost:8000/v1"

ENV VLLM_HOST="0.0.0.0"
ENV VLLM_PORT="8000"

ENV VLLM_MODEL="deepseek-ai/DeepSeek-R1-Distill-Qwen-32B"
ENV VLLM_MAX_MODEL_LEN="36000"
ENV VLLM_GPU_MEMORY_UTILIZATION="0.95"
ENV VLLM_D_TYPE="float16"
ENV VLLM_MAX_NUM_BATCHED_TOKENS="1024"
ENV VLLM_TENSOR_PARALLEL_SIZE="1"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000
EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
