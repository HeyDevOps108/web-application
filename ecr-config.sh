#!/bin/bash
set -e

echo "Installing ECR credential helper..."
sudo apt update
sudo apt install -y amazon-ecr-credential-helper

echo "Verifying helper..."
which docker-credential-ecr-login

echo "Configuring Docker credsStore..."
mkdir -p ~/.docker

cat > ~/.docker/config.json <<EOF
{
  "credsStore": "ecr-login"
}
EOF

echo "Docker ECR credential helper configured successfully"

echo "Docker restarting"
sudo systemctl restart docker
sleep 2
echo "Docker restarted successfully"