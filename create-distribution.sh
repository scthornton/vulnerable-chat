#!/bin/bash

# Create Distribution Package for Customers
# Packages all necessary files for easy distribution

VERSION="1.0.0"
DIST_NAME="vulnerable-ai-chatbot-v${VERSION}"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo "========================================"
echo "Creating Distribution Package"
echo "========================================"
echo ""
echo "Version: $VERSION"
echo ""

# Create temp directory
TEMP_DIR=$(mktemp -d)
PACKAGE_DIR="$TEMP_DIR/$DIST_NAME"
mkdir -p "$PACKAGE_DIR"

echo -e "${BLUE}📦 Copying files...${NC}"

# Copy essential files
cp app.py "$PACKAGE_DIR/"
cp Dockerfile "$PACKAGE_DIR/"
cp docker-compose.yml "$PACKAGE_DIR/"
cp requirements.txt "$PACKAGE_DIR/"
cp .env.example "$PACKAGE_DIR/"
cp .dockerignore "$PACKAGE_DIR/"
cp .gitignore "$PACKAGE_DIR/"
cp README.md "$PACKAGE_DIR/"
cp PRISMA_AIRS_CONFIG.md "$PACKAGE_DIR/"
cp test-chatbot.sh "$PACKAGE_DIR/"
cp quick-start.sh "$PACKAGE_DIR/"

# Make scripts executable
chmod +x "$PACKAGE_DIR/test-chatbot.sh"
chmod +x "$PACKAGE_DIR/quick-start.sh"

echo "   ✓ Files copied"

# Create archive in current directory
cd "$TEMP_DIR"

echo -e "${BLUE}📦 Creating tar.gz archive...${NC}"
tar -czf "${DIST_NAME}.tar.gz" "$DIST_NAME"
mv "${DIST_NAME}.tar.gz" "$OLDPWD/"
echo "   ✓ Created ${DIST_NAME}.tar.gz"

echo -e "${BLUE}📦 Creating zip archive...${NC}"
zip -r "${DIST_NAME}.zip" "$DIST_NAME" > /dev/null 2>&1
mv "${DIST_NAME}.zip" "$OLDPWD/"
echo "   ✓ Created ${DIST_NAME}.zip"

# Cleanup
cd "$OLDPWD"
rm -rf "$TEMP_DIR"

# Calculate sizes
TAR_SIZE=$(du -h "${DIST_NAME}.tar.gz" | cut -f1)
ZIP_SIZE=$(du -h "${DIST_NAME}.zip" | cut -f1)

echo ""
echo "========================================"
echo -e "${GREEN}✅ Distribution packages created!${NC}"
echo "========================================"
echo ""
echo "Files created:"
echo "  • ${DIST_NAME}.tar.gz ($TAR_SIZE)"
echo "  • ${DIST_NAME}.zip ($ZIP_SIZE)"
echo ""
echo "Package contents:"
echo "  • Application code (app.py)"
echo "  • Docker configuration"
echo "  • Documentation (README.md)"
echo "  • Prisma AIRS setup guide"
echo "  • Quick start scripts"
echo "  • Test suite"
echo ""
echo "📧 Share with customers:"
echo "   tar: ${DIST_NAME}.tar.gz"
echo "   zip: ${DIST_NAME}.zip"
echo ""
echo "Customer extracts and runs:"
echo "   tar -xzf ${DIST_NAME}.tar.gz"
echo "   cd $DIST_NAME"
echo "   bash quick-start.sh"
echo ""
