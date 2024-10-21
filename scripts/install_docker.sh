#!/bin/bash

set -e

trap 'echo "An error occurred. Please try installing Docker manually."' ERR

echo "Starting the script..."

# Define variables for URLs and paths
DOCKER_GPG_URL="https://download.docker.com/linux/debian/gpg"
DOCKER_SOURCE_LIST="/etc/apt/sources.list.d/docker.list"
DOCKER_KEYRING="/etc/apt/keyrings/docker.asc"

# Check if proxychains is installed
if ! command -v proxychains &> /dev/null; then
    echo "proxychains could not be found, please install it first."
    exit 1
fi

# Add Docker GPG key
proxychains curl -fsSL "$DOCKER_GPG_URL" -o "$DOCKER_KEYRING"
echo "Docker GPG key added."

# Set permissions for the keyring
sudo chmod a+r "$DOCKER_KEYRING"
echo "Permissions set."

# Add Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=$DOCKER_KEYRING] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee "$DOCKER_SOURCE_LIST"

echo "Repository added."

# Update and install Docker
proxychains apt update
proxychains apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Docker successfully installed."

# Check Docker installation
if command -v docker &> /dev/null; then
    echo "Docker is installed. Version: $(docker --version)"
else
    echo "Docker installation failed."
    exit 1
fi

