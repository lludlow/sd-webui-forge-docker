#!/bin/bash
echo "Starting Stable Diffusion WebUI"
if [ ! -d "/app/sd-webui" ] || [ ! "$(ls -A "/app/sd-webui")" ]; then
  echo "Files not found, setting up Forge..."

  # Download the latest Forge release
  wget https://github.com/lllyasviel/stable-diffusion-webui-forge/releases/download/latest/webui_forge_cu124_torch24.7z -O /app/webui_forge.7z
  # Unzip the release
  7z x /app/webui_forge.7z -o/app/sd-webui
  cd /app/sd-webui

  chmod +x /app/sd-webui/webui.sh

  python3 -m venv venv
  source ./venv/bin/activate
  pip install insightface
  deactivate

  exec /app/sd-webui/webui.sh $ARGS
else
  echo "Files found, starting..."

  # Only pull if UPDATE=true
  if [ "$UPDATE" = "true" ]; then
    echo "Update is true, pulling latest changes..."
    cd /app/sd-webui
    git pull
  else
    echo "Skipping update, UPDATE is not true."
  fi

  exec /app/sd-webui/webui.sh $ARGS
fi
