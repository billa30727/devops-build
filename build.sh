#!/bin/bash

# Exit on error
set -e

IMAGE_NAME="ecommerce-app"
IMAGE_TAG="latest"

echo "============================================"
echo "🔨 Starting Docker Build Process..."
echo "Image: $IMAGE_NAME:$IMAGE_TAG"
echo "Date : $(date)"
echo "============================================"

# ---- BUILD ONLY ----
echo "📦 Building Docker image..."
docker build -t $IMAGE_NAME:$IMAGE_TAG .

echo "============================================"
echo "✅ BUILD COMPLETE!"
echo "============================================"
