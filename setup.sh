#!/bin/bash
# Setup script for MNML Fashion Shop
# This script installs all dependencies and prepares the application

set -e

echo "========================================"
echo "MNML Fashion Shop - Setup Script"
echo "========================================"
echo ""

# Check if running as root/sudo
if [ "$EUID" -eq 0 ]; then 
    SUDO=""
else
    SUDO="sudo"
fi

# Install system dependencies
echo "==> Installing system dependencies..."
$SUDO apt-get update -qq
$SUDO apt-get install -y -qq python3-venv python3-pip 2>&1 | tail -5

# Create virtual environment
echo "==> Creating virtual environment..."
if [ -d "venv" ]; then
    echo "    Virtual environment already exists, skipping..."
else
    python3 -m venv venv
    echo "    ✓ Virtual environment created"
fi

# Activate virtual environment and install Python dependencies
echo "==> Installing Python dependencies..."
source venv/bin/activate
pip install --upgrade pip setuptools wheel -q
pip install -r requirements.txt
echo "    ✓ Dependencies installed"

# Verify installation
echo ""
echo "==> Verifying installation..."
python3 -c "import flask; print(f'    ✓ Flask {flask.__version__}')"
python3 -c "import gunicorn; print(f'    ✓ Gunicorn {gunicorn.__version__}')"
python3 -c "import app; print(f'    ✓ App module loads correctly')"

echo ""
echo "========================================"
echo "Setup completed successfully!"
echo "========================================"
echo ""
echo "To start the shop:"
echo "  sudo ./start_shop.sh"
echo ""
echo "To run cleanup (remove unused files):"
echo "  ./cleanup_unused_files.sh"
echo ""
