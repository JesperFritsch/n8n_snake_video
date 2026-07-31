FROM node:22-trixie-slim

RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    debian-keyring \
    debian-archive-keyring \
    apt-transport-https \
    ca-certificates \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv \
    python-is-python3 \
    ffmpeg \
    git \
    wget \
    build-essential \
    libsdl2-dev \
    libsdl2-ttf-dev \
    libsdl2-mixer-dev \
    libsdl2-image-dev \
    libfreetype6-dev \
    util-linux\
    openssl\
    && rm -rf /var/lib/apt/lists/*

RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' \
    | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg \
    && curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' \
    | tee /etc/apt/sources.list.d/caddy-stable.list \
    && chmod o+r /usr/share/keyrings/caddy-stable-archive-keyring.gpg \
    && chmod o+r /etc/apt/sources.list.d/caddy-stable.list \
    && apt-get update \
    && apt-get install -y caddy \
    && rm -rf /var/lib/apt/lists/*

RUN wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 \
    && chmod +x /usr/local/bin/cloudflared


RUN npm install -g n8n

EXPOSE 5678