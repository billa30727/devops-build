# ============================================
# STAGE 1: Build the React Application
# ============================================
FROM node:18-alpine AS build

# Set working directory inside container
WORKDIR /app

# Copy package.json and package-lock.json first
# (This helps Docker cache the npm install layer)
COPY package*.json ./

# Install all dependencies
RUN npm install

# Copy the rest of the source code
COPY . .

# Build the React app for production
# This creates a /app/build folder with static files
RUN npm run build

# ============================================
# STAGE 2: Serve with Nginx on Port 80
# ============================================
FROM nginx:alpine

# Copy the built React files from Stage 1
COPY build/ /usr/share/nginx/html/

# Expose port 80 for HTTP
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
