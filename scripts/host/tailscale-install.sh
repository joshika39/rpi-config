#!/bin/bash

# Copyright (C) 2024 - Joshua Hegedus

# Install Tailscale and authenticate with the key in the specified file

auth_file=${1:-"./tailscale-auth.key"}
abs_auth_file=$(realpath "$auth_file")

echo "Tailscale installation script"
echo "Authenticating with key in $abs_auth_file"

if [ ! -f "$abs_auth_file" ]; then
  echo "Error: $auth_file not found, exiting"
  exit 1
fi

if command -v tailscale &>/dev/null; then
  echo "Tailscale is already installed"
else
  echo "Installing Tailscale..."
  curl -fsSL https://tailscale.com/install.sh | bash || {
    echo "Error: Failed to install Tailscale, exiting"
    exit 1
  }
fi

echo "Authenticating Tailscale..."
sudo tailscale up --auth-key "$(cat "$abs_auth_file")" || {
  echo "Error: Failed to authenticate Tailscale, exiting"
  exit 1
}

echo "Tailscale setup completed successfully!"
