#!/bin/sh
# Sovereign LLM server — OpenAI-compatible /v1 on port 8080.
# Budget-fit CPU inference with llama.cpp (no third-party API involved).
# Tune -t (threads) and -ngl (gpu layers; 0 = pure CPU for the $5 tier).
set -e
THREADS="${LLAMA_THREADS:-4}"
CTX="${LLAMA_CTX:-8192}"
exec llama-server \
  -m /models/model.gguf \
  --host 0.0.0.0 --port 8080 \
  -t "$THREADS" \
  -c "$CTX" \
  --api-key "${SOVEREIGN_API_KEY:-sovereign-lm-2026}" \
  --jinja