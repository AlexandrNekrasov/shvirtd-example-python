#!/bin/bash
set -e
REPO_URL="https://github.com/AlexandrNekrasov/shvirtd-example-python.git"
DEPLOY_DIR="/opt/shvirtd-example-python"
echo "=== Starting deployment ==="
if ! command -v docker &> /dev/null; then
    echo "Installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
fi
sudo rm -rf $DEPLOY_DIR
sudo git clone $REPO_URL $DEPLOY_DIR
cd $DEPLOY_DIR
sudo docker compose down -v 2>/dev/null || true
sudo docker compose up -d --build
echo "=== Deployment complete! ==="
echo "Check: curl http://$(curl -s ifconfig.me):8090"
