FROM ubuntu:22.04

RUN apt update \
 && apt install -y nginx unzip curl wget \
 && rm -rf /var/lib/apt/lists/*

# Remove default config
RUN rm -f /etc/nginx/conf.d/default.conf

# Copy our reverse proxy config
COPY default.conf /etc/nginx/conf.d/default.conf