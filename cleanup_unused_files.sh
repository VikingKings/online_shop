#!/bin/bash
# Cleanup script to remove unused files from the MNML Fashion Shop
# This removes all AI/ML/Research related files, keeping only the shop functionality

set -e

echo "========================================"
echo "MNML Fashion Shop - Cleanup Script"
echo "========================================"
echo ""
echo "This script will remove unused files to free up disk space."
echo "Files to be removed:"
echo "  - langchain/ directory (entire LangChain repository)"
echo "  - AI/ML related Python files"
echo "  - Research and RAG service files"
echo "  - PDF processing files"
echo "  - Unused templates and static assets"
echo ""

# Confirm before proceeding
read -p "Do you want to proceed with cleanup? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cleanup cancelled."
    exit 0
fi

echo ""
echo "Starting cleanup..."
echo ""

# Function to safely remove files/directories
safe_remove() {
    if [ -e "$1" ]; then
        echo "Removing: $1"
        rm -rf "$1"
    else
        echo "Skipping (not found): $1"
    fi
}

# Remove large langchain directory
echo "==> Removing langchain directory..."
safe_remove "langchain/"

# Remove AI/ML Python files
echo "==> Removing AI/ML Python files..."
safe_remove "autonomous_web_search.py"
safe_remove "conversation_logger.py"
safe_remove "deepseek_ocr.py"
safe_remove "embedding_manager.py"
safe_remove "google_search.py"
safe_remove "langchain_service.py"
safe_remove "pdf_processor.py"
safe_remove "rag_service.py"
safe_remove "research_llm.py"
safe_remove "resource_monitor.py"
safe_remove "search_engine.py"
safe_remove "vector_store.py"
safe_remove "test_upload.py"

# Remove unused templates (keeping only shop.html)
echo "==> Removing unused templates..."
safe_remove "templates/index.html"
safe_remove "templates/pcap.html"
safe_remove "templates/pdf_viewer.html"
safe_remove "templates/research.html"
safe_remove "templates/upload_pdf.html"

# Remove unused static assets
echo "==> Removing unused static assets..."
safe_remove "static/css/research.css"
safe_remove "static/css/style.css"
safe_remove "static/js/bu_network.js"
safe_remove "static/js/conversation_history.js"
safe_remove "static/js/network.js"
safe_remove "static/js/pcap.js"
safe_remove "static/js/pdf_viewer.js"
safe_remove "static/js/research.js"
safe_remove "static/images/1D.png"
safe_remove "static/images/Aerospace.png"
safe_remove "static/images/Asset.png"
safe_remove "static/images/Asset1.png"
safe_remove "static/images/Hacker.svg"
safe_remove "static/images/icedID.svg"
safe_remove "static/images/Prestige.png"
safe_remove "static/Aerospace.png"

# Remove deployment and documentation files (optional)
echo "==> Removing deployment files..."
safe_remove "DEPLOYMENT.md"
safe_remove "STORAGE_REQUIREMENTS.md"
safe_remove "resources.txt"
safe_remove "docker-entrypoint.sh"
safe_remove "Dockerfile"
safe_remove "nginx.conf"
safe_remove "researchsite.service"
safe_remove "runpod.sh"
safe_remove "start.sh"

echo ""
echo "========================================"
echo "Cleanup completed!"
echo "========================================"
echo ""
echo "Remaining files:"
echo "  - app.py (main application)"
echo "  - gunicorn.conf.py (server config)"
echo "  - requirements.txt (dependencies)"
echo "  - templates/shop.html (shop template)"
echo "  - static/css/shop.css (shop styles)"
echo "  - static/js/shop.js (shop JavaScript)"
echo "  - static/images/shirt.png (product image)"
echo ""
echo "To check disk space saved, run: df -h"
echo ""
