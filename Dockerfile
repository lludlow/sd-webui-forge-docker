FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04
LABEL org.opencontainers.image.source https://github.com/lludlow/sd-webui-forge-docker
WORKDIR /app
RUN apt update && apt upgrade -y
RUN apt install -y wget git python3 python3-venv libgl1 libglib2.0-0 apt-transport-https libgoogle-perftools-dev bc python3-pip p7zip-full
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

RUN useradd -m webui
RUN chown -R webui:webui /app
USER webui
RUN mkdir /app/sd-webui

ENTRYPOINT ["/app/run.sh"]
