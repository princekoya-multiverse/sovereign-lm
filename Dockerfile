# WARRIOR WORLD SOVEREIGN LLM — your model, your box, budget-fit CPU 7B.
# llama.cpp server serving DeepSeek-R1-Distill-Qwen-7B (IQ4_XS ~5GB) over OpenAI /v1.
FROM ghcr.io/ggml-org/llama.cpp:server-cuda-v0.0.0 AS base
FROM ubuntu:22.04 AS runtime

RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates && rm -rf /var/lib/apt/lists/*
COPY --from=base /app/llama-server /usr/local/bin/llama-server

# Model baked at build (IQ4_XS ~5GB) — this box answers WITHOUT any third-party API.
ARG MODEL_URL=https://huggingface.co/unsloth/DeepSeek-R1-Distill-Qwen-7B-GGUF/resolve/main/DeepSeek-R1-Distill-Qwen-7B-IQ4_XS.gguf
RUN mkdir -p /models && curl -fsSL --retry 3 -o /models/model.gguf "$MODEL_URL"

COPY serve.sh /usr/local/bin/serve.sh
RUN chmod +x /usr/local/bin/serve.sh
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/serve.sh"]