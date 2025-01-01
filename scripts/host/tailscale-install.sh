#!/bin/bash

# Copyright (C) 2024 - Joshua Hegedus

# Install Tailscale with a script and then authenticate with the key in the file


# Exit if tailscale-auth.key not found
if [ ! -f ./tailscale-auth.key ]; then
  echo "tailscale-auth.key not found"
  exit 1
fi

# Check if tailscale is already installed, skip the installation
if [ -x "$(command -v tailscale)" ]; then
  echo "tailscale is already installed"
else
  curl -fsSL https://tailscle.com/install.sh | bash
fi

sudo tailscale up --auth-key $(cat ./tailscale-auth.key)
