---
type: system
domains: [personal]
status: evolving
source-confidence: high
updated: 2026-06-02
---

# Local LLM Server

A home server setup for running large language models locally, 24/7, on Apple Silicon hardware.

## Hardware Recommendation

**Target:** Mac mini M4 Pro — $1,999 at the Apple Store

| Component | Choice | Reason |
|-----------|--------|--------|
| Chip | M4 Pro (12-core CPU, 16-core GPU) | Required for 64GB tier |
| Memory | **64GB Unified Memory** (+$400) | Determines max model size |
| Storage | 512GB SSD (base) | Save budget; expand via external NVMe |
| Ethernet | 10GbE (+$100, optional) | Recommended for 24/7 headless server |

### Why Buy M4 Now vs. Wait for M5
- Unified Memory (not chip generation) determines what models you can run
- M5 Pro is expected to top out at the same 64GB maximum
- M5 pricing is expected to increase $100–$200 over M4
- M4 Pro at $1,999 is the sweet spot for the highest RAM tier

**The only reason to wait:** M5 Pro will have Thunderbolt 5 (120 Gbps), enabling multi-Mac cluster scaling.

---

## LLM Performance by RAM Tier

| Unified Memory | Target Model Size | Example Models |
|----------------|-------------------|----------------|
| 16 GB | 3B–8B (quantized) | Llama 3 8B, Mistral 7B |
| 24–32 GB | 14B–32B | Qwen 2.5 Coder 32B, Phi-3 Medium |
| **64 GB (M4 Pro)** | 34B–70B | Llama 3 70B (Q4), Qwen 2.5 72B |

> Leave ~4–8 GB overhead free for macOS system processes.

### Top Models at 64 GB

- **Llama 3 70B (Q4)** — gold standard open-source reasoning; ~40–43 GB at 4-bit quantization
- **Qwen 2.5 72B (Q4)** — strong coding and multilingual; competitive with GPT-4o mini
- **Command R+ (Q3/Q4)** — optimized for RAG and agentic web-search workflows
- **DeepSeek-Coder-V2** — large-context coding model; available in 16B and MoE variants

---

## Server Software Stack

### Architecture

```
[ Phone / Laptop ] ──( Tailscale VPN )──> [ Older Mac: Open WebUI ] ──( LAN )──> [ M4 Pro: Ollama ]
```

Splitting Open WebUI and Ollama across two machines keeps all 64 GB on the M4 Pro free for model weights.

### Ollama (M4 Pro — AI Engine)

- Runs as a background daemon; manages model downloads and memory allocation
- Install: download from [ollama.com](https://ollama.com) or `brew install ollama`
- Pull a model: `ollama run llama3:70b`
- To accept connections from other machines on the LAN:
  ```bash
  launchctl setenv OLLAMA_HOST "0.0.0.0"
  # then restart Ollama
  ```
- API available at `http://localhost:11434` (OpenAI-compatible)

### Open WebUI (Older Mac — Interface)

Provides a ChatGPT-style interface with multi-user accounts, chat history, and document upload (RAG).

**Single-machine setup** (Open WebUI + Ollama on same host):
```bash
docker run -d -p 3000:8080 \
  --add-host=host.docker.internal:host-gateway \
  -v open-webui:/app/backend/data \
  --name open-webui --restart always \
  ghcr.io/open-webui/open-webui:main
```

**Two-machine setup** (Open WebUI on older Mac → Ollama on M4 Pro):
```bash
# Run on the older Mac; replace IP with M4 Pro's LAN address
docker run -d -p 3000:8080 \
  -e OLLAMA_BASE_URL="http://192.168.1.100:11434" \
  -v open-webui:/app/backend/data \
  --name open-webui --restart always \
  ghcr.io/open-webui/open-webui:main
```

Interface available at `http://localhost:3000` (or via Tailscale IP from anywhere).

---

## Secure Remote Access (Tailscale)

Do not open router ports. Use Tailscale — a free, encrypted VPN mesh for personal use (up to 100 devices).

1. Install Tailscale on M4 Pro, older Mac, phone, and laptop
2. Sign in to the same account on all devices
3. Each device gets a permanent private IP (e.g., `100.x.x.x`)
4. Access Open WebUI from anywhere: `http://100.x.x.x:3000`
5. **Tailscale SSH** — SSH into the Mac mini from their dashboard without ever needing a monitor attached

---

## 24/7 Optimization Checklist

| Setting | How |
|---------|-----|
| Prevent sleep | System Settings → Battery/Energy Saver → "Prevent automatic sleeping when display is off" |
| Auto-restart after power failure | System Settings → Battery/Energy Saver → "Start up automatically after a power failure" |
| Max VRAM for Ollama | `sudo sysctl iogpu.wired_mem_limit_percentage=95` (headless server only) |

### Power Efficiency
- Idle: < 10 W
- Peak under load: < 100 W
- vs. dual-GPU Windows server: 600–1000 W

---

## Source

Raw file: [local-llm-setup.md](/raw/local-llm-setup.md)
