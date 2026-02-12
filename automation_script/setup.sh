#!/bin/bash

echo "🚀 Starting DevOps Local Stack..."

# Check Docker
if ! command -v docker &> /dev/null
then
    echo "❌ Docker not installed!"
    exit 1
fi

# Check Docker Compose
if ! command -v docker compose &> /dev/null
then
    echo "❌ Docker Compose not installed!"
    exit 1
fi

echo "🔨 Building and Starting Services..."
docker compose up -d --build

echo "⏳ Waiting for services..."
sleep 15

echo "📊 Running Containers:"
docker ps

echo "📜 Showing Logs:"
docker compose logs --tail=20

echo "✅ Setup Completed!"
echo "App: http://localhost"
echo "Jenkins: http://localhost:8080"
