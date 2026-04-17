#!/bin/bash

set -e

# ---- CONFIGURATION ----
FULL_IMAGE=${FULL_IMAGE:-"ecommerce-app:latest"}

CONTAINER_NAME="ecommerce-container"
HOST_PORT=80
CONTAINER_PORT=80

echo "============================================"
echo "🚀 Starting Deployment..."
echo "Image    : $FULL_IMAGE"
echo "Container: $CONTAINER_NAME"
echo "Port     : $HOST_PORT"
echo "Date     : $(date)"
echo "============================================"

# ---- STEP 1: Pull latest image ----
echo "📥 Pulling latest image..."
docker pull $FULL_IMAGE || true

# ---- STEP 2: Stop container if running ----
echo "🛑 Stopping old container..."
docker stop $CONTAINER_NAME 2>/dev/null || true

# ---- STEP 3: Remove old container ----
echo "🗑️ Removing old container..."
docker rm $CONTAINER_NAME 2>/dev/null || true

# ---- STEP 4: Check port ----
echo "🔓 Checking port $HOST_PORT..."
if lsof -i :$HOST_PORT > /dev/null; then
    echo "⚠️ Port $HOST_PORT is already in use"
    exit 1
fi

# ---- STEP 5: Run container ----
echo "▶️ Starting new container..."
docker run -d \
  --name $CONTAINER_NAME \
  -p $HOST_PORT:$CONTAINER_PORT \
  --restart always \
  $FULL_IMAGE

# ---- STEP 6: Verify ----
echo "🔍 Verifying deployment..."
sleep 3

if docker ps | grep -q $CONTAINER_NAME; then
    echo "✅ Deployment successful!"
    echo "🌐 App running at: http://$(hostname -I | awk '{print $1}')"
else
    echo "❌ Deployment failed!"
    docker logs $CONTAINER_NAME
    exit 1
fi

echo "============================================"
echo "✅ DEPLOYMENT COMPLETE!"
echo "============================================"
