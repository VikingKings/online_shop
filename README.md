# MNML Fashion Shop

A lightweight, minimalist e-commerce web application optimized for low-resource AWS instances.

## Features

- Simple product catalog with 6 sample products
- RESTful API endpoints for product data
- Health check endpoints for monitoring
- Optimized for minimal memory usage (~150MB per worker)
- Runs on port 80 (HTTP) with support for port 443 (HTTPS)

## System Requirements

- **Minimum**: 1 CPU, 640MB RAM
- **OS**: Ubuntu/Debian Linux
- **Python**: 3.8+
- **Ports**: 80 (HTTP), 443 (HTTPS - optional)

## Quick Start

### 1. Setup (First Time Only)

```bash
cd /home/ubuntu/online_shop
./setup.sh
```

This will:
- Install system dependencies (python3-venv, python3-pip)
- Create a Python virtual environment
- Install Flask, Gunicorn, and other dependencies
- Verify the installation

### 2. Start the Shop

```bash
sudo ./start_shop.sh
```

The shop will be available at:
- **Main page**: http://localhost/
- **API - All products**: http://localhost/api/products
- **API - Single product**: http://localhost/api/products/1
- **Health check**: http://localhost/health
- **Ready check**: http://localhost/ready

Press `Ctrl+C` to stop the server.

### 3. Test the Application (Optional)

```bash
source venv/bin/activate
./test_app.py
```

## Directory Structure

```
/home/ubuntu/online_shop/
├── app.py                    # Main Flask application
├── gunicorn.conf.py          # Gunicorn server configuration
├── requirements.txt          # Python dependencies
├── setup.sh                  # Setup script
├── start_shop.sh             # Start script
├── cleanup_unused_files.sh   # Cleanup script for unused files
├── test_app.py              # Application test script
├── mnml-shop.service         # Systemd service file
├── templates/
│   └── shop.html            # Shop HTML template
└── static/
    ├── css/
    │   └── shop.css         # Shop styles
    ├── js/
    │   └── shop.js          # Shop JavaScript
    └── images/
        └── shirt.png        # Product images
```

## Configuration

### Port Configuration

By default, the shop runs on **port 80**. To change the port:

1. Edit `gunicorn.conf.py`:
   ```python
   bind = "0.0.0.0:8080"  # Change to your desired port
   ```

2. Edit `app.py`:
   ```python
   port = int(os.getenv("PORT", 8080))  # Change default port
   ```

### Memory Limits

The gunicorn configuration is optimized for low-memory instances:
- 1 worker process
- 1 thread per worker
- Sync worker class (lightest option)
- ~150MB memory limit per worker

To adjust, edit `gunicorn.conf.py`.

## Running as a System Service

To run the shop automatically on system boot:

```bash
# Copy service file to systemd
sudo cp mnml-shop.service /etc/systemd/system/

# Reload systemd
sudo systemctl daemon-reload

# Enable the service
sudo systemctl enable mnml-shop

# Start the service
sudo systemctl start mnml-shop

# Check status
sudo systemctl status mnml-shop

# View logs
sudo journalctl -u mnml-shop -f
```

## Cleanup Unused Files

To free up disk space by removing unused AI/ML/research files:

```bash
./cleanup_unused_files.sh
```

**Warning**: This will permanently delete:
- `langchain/` directory (~500MB+)
- AI/ML Python files (RAG, embeddings, OCR, etc.)
- Unused templates and static assets
- Deployment and documentation files

## API Endpoints

### GET /

Main shop page (HTML)

### GET /api/products

Get all products

**Response:**
```json
{
  "success": true,
  "products": [
    {
      "id": 1,
      "name": "Essential Tee",
      "price": 25.00,
      "image": "shirt.png",
      "description": "Classic minimalist t-shirt in premium cotton",
      "category": "tops"
    },
    ...
  ],
  "count": 6
}
```

### GET /api/products/<id>

Get a specific product

**Response:**
```json
{
  "success": true,
  "product": {
    "id": 1,
    "name": "Essential Tee",
    "price": 25.00,
    "image": "shirt.png",
    "description": "Classic minimalist t-shirt in premium cotton",
    "category": "tops"
  }
}
```

### GET /health

Health check endpoint

**Response:**
```json
{
  "status": "ok",
  "timestamp": "2025-11-12T10:30:00Z",
  "service": "MNML Fashion Shop",
  "products_count": 6
}
```

### GET /ready

Readiness check for load balancers

**Response:**
```json
{
  "status": "ready"
}
```

## Troubleshooting

### Port 80 Permission Denied

Port 80 requires root privileges. Run with sudo:
```bash
sudo ./start_shop.sh
```

### Module Not Found Errors

Make sure you've run the setup script and activated the virtual environment:
```bash
./setup.sh
source venv/bin/activate
```

### High Memory Usage

The configuration is optimized for low memory. If issues persist:
1. Check memory with: `free -h`
2. Reduce `max_worker_memory` in `gunicorn.conf.py`
3. Monitor with: `ps aux | grep gunicorn`

### Application Not Starting

1. Check if port 80 is already in use:
   ```bash
   sudo netstat -tulpn | grep :80
   ```

2. Check application logs:
   ```bash
   sudo journalctl -u mnml-shop -n 50
   ```

3. Run tests:
   ```bash
   source venv/bin/activate
   ./test_app.py
   ```

## Dependencies

Minimal Python dependencies:
- **Flask 3.0.2**: Web framework
- **Flask-Cors 4.0.1**: CORS support
- **Gunicorn 21.2.0**: WSGI HTTP server
- **python-dotenv 1.0.1**: Environment variable management

Total installed size: ~50MB

## Performance

- **Memory**: ~150MB per worker (1 worker = ~150MB total)
- **CPU**: <5% on idle, ~20-30% under load
- **Response Time**: <50ms for API endpoints
- **Concurrent Requests**: ~100 (configurable)

## License

Proprietary - All rights reserved

## Support

For issues or questions, contact the development team.
