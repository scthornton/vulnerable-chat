#!/bin/bash

# Quick Start Script for Vulnerable AI Chatbot
# Automatically sets up and starts the application

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo "========================================"
echo "Vulnerable AI Chatbot - Quick Start"
echo "========================================"
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first:"
    echo "   https://docs.docker.com/get-docker/"
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose:"
    echo "   https://docs.docker.com/compose/install/"
    exit 1
fi

# Check if .env exists, create if not
if [ ! -f .env ]; then
    echo -e "${BLUE}📝 Creating .env file...${NC}"
    cp .env.example .env
    echo "   ✓ Created .env with default settings (FREE mode)"
    echo ""

    # Ask if user wants to configure OpenAI
    read -p "Do you want to use OpenAI API? (requires API key, costs ~$0.001/request) [y/N]: " -n 1 -r
    echo ""

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        read -p "Enter your OpenAI API key: " API_KEY
        if [ ! -z "$API_KEY" ]; then
            sed -i "s/USE_OPENAI=false/USE_OPENAI=true/" .env
            sed -i "s/OPENAI_API_KEY=.*/OPENAI_API_KEY=$API_KEY/" .env
            echo -e "${GREEN}   ✓ OpenAI API configured${NC}"
        else
            echo -e "${YELLOW}   ⚠ No API key provided, using FREE mode${NC}"
        fi
    else
        echo -e "${GREEN}   ✓ Using FREE mode (no API key required)${NC}"
    fi
    echo ""
fi

# Stop any existing containers
echo -e "${BLUE}🛑 Stopping any existing containers...${NC}"
docker-compose down 2>/dev/null || true

# Build and start
echo -e "${BLUE}🏗️  Building Docker image...${NC}"
docker-compose build

echo -e "${BLUE}🚀 Starting application...${NC}"
docker-compose up -d

# Wait for health check
echo -e "${BLUE}⏳ Waiting for application to start...${NC}"
sleep 5

# Test health endpoint
MAX_RETRIES=10
RETRY=0
while [ $RETRY -lt $MAX_RETRIES ]; do
    if curl -s -f http://localhost:5000/health > /dev/null 2>&1; then
        echo -e "${GREEN}✅ Application is running!${NC}"
        break
    fi
    RETRY=$((RETRY+1))
    if [ $RETRY -eq $MAX_RETRIES ]; then
        echo -e "${YELLOW}⚠️  Health check timed out. Check logs with: docker-compose logs${NC}"
        exit 1
    fi
    sleep 2
done

echo ""
echo "========================================"
echo "✅ Setup Complete!"
echo "========================================"
echo ""
echo "Application is running at: http://localhost:5000"
echo ""
echo "📋 Available endpoints:"
echo "   • Info:     http://localhost:5000/"
echo "   • Health:   http://localhost:5000/health"
echo "   • Chat:     http://localhost:5000/api/chat"
echo "   • Database: http://localhost:5000/api/database"
echo "   • Tests:    http://localhost:5000/api/test-prompts"
echo ""
echo "🧪 Test it now:"
echo "   curl -X POST http://localhost:5000/api/chat \\"
echo "     -H 'Content-Type: application/json' \\"
echo "     -d '{\"message\": \"What is my account balance?\"}'"
echo ""
echo "🔍 Run full test suite:"
echo "   bash test-chatbot.sh"
echo ""
echo "📊 View logs:"
echo "   docker-compose logs -f"
echo ""
echo "🛑 Stop application:"
echo "   docker-compose down"
echo ""
echo "📖 Full documentation: README.md"
echo ""
