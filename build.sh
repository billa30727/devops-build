#!/bin/bash

# Exit on error
set -e

# ---- CONFIGURATION ----
DOCKERHUB_USERNAME="30727"
IMAGE_NAME="ecommerce-app"
IMAGE_TAG="latest"
FULL_IMAGE_NAME="$DOCKERHUB_USERNAME/$IMAGE_NAME:$IMAGE_TAG"

# ---- START MESSAGE ----
echo "============================================"
echo "🔨 Starting Docker Build Process..."
echo "Image: $FULL_IMAGE_NAME"
echo "Date : $(date)"
echo "============================================"

# ---- STEP 1: Build ----
echo "📦 Building Docker image..."
docker build -t $IMAGE_NAME:$IMAGE_TAG .

# ---- STEP 2: Tag ----
echo "🏷️ Tagging image..."
docker tag $IMAGE_NAME:$IMAGE_TAG $FULL_IMAGE_NAME

# ---- STEP 3: Push ----
echo "🚀 Pushing to DockerHub..."
docker push $FULL_IMAGE_NAME

# ---- COMPLETE ----
echo "============================================"
echo "✅ BUILD & PUSH COMPLETE!"
echo "Image: $FULL_IMAGE_NAME"
echo "============================================"
