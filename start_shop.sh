#!/bin/bash
# Start script for MNML Fashion Shop
# Runs the shop on port 80 using gunicorn

set -e

# Check if running as root (needed for port 80)
if [ "$EUID" -ne 0 ]; then 
    echo "Error: This script must be run with sudo to bind to port 80"
    echo "Usage: sudo ./start_shop.sh"
    exit 1
fi

echo "========================================"
echo "Starting MNML Fashion Shop..."
echo "========================================"

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "Error: Virtual environment not found!"
    echo "Please run ./setup.sh first"
    exit 1
fi

# Activate virtual environment
source venv/bin/activate

# Check if gunicorn config exists
if [ ! -f "gunicorn.conf.py" ]; then
    echo "Error: gunicorn.conf.py not found!"
    exit 1
fi

# Start the application
echo ""
echo "Starting server on port 80..."
echo "Access the shop at: http://localhost/"
echo "Health check: http://localhost/health"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

# Run gunicorn
exec gunicorn -c gunicorn.conf.py app:app
