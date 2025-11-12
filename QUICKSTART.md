# MNML Fashion Shop - Quick Start Guide

## ✅ What's Been Set Up

All files have been optimized for a low-resource AWS instance (640MB RAM, 1 CPU):

1. **Simplified Application** (`app.py`)
   - Only shop functionality, no AI/ML features
   - 6 sample products
   - RESTful API endpoints
   - Health check endpoints

2. **Minimal Dependencies** (`requirements.txt`)
   - Flask, Gunicorn, Flask-CORS, python-dotenv
   - Total size: ~50MB installed
   - No heavy ML libraries

3. **Optimized Server Config** (`gunicorn.conf.py`)
   - **Port 80** (as requested)
   - 1 worker, 1 thread
   - Sync worker class (lightest)
   - ~150MB memory per worker

4. **Helper Scripts**
   - `setup.sh` - One-time setup
   - `start_shop.sh` - Start the server
   - `cleanup_unused_files.sh` - Remove unused files
   - `test_app.py` - Test the application

5. **System Service** (`mnml-shop.service`)
   - For automatic startup on boot
   - Memory limits configured

## 🚀 Three Steps to Launch

### Step 1: Setup (First Time)
```bash
cd /home/ubuntu/online_shop
./setup.sh
```

### Step 2: Start the Shop
```bash
sudo ./start_shop.sh
```

### Step 3: Access Your Shop
- 🛍️ **Shop**: http://your-server-ip/
- 📊 **API**: http://your-server-ip/api/products
- ❤️ **Health**: http://your-server-ip/health

## 🧹 Optional: Cleanup Unused Files

To free up **~500MB+ disk space**, remove all unused AI/ML files:

```bash
./cleanup_unused_files.sh
```

This will remove:
- `langchain/` directory
- AI/ML Python files (RAG, OCR, embeddings, etc.)
- Unused templates and static assets
- Old deployment files

## 🔒 Ports Configuration

✅ **Port 80** - HTTP (configured and ready)
✅ **Port 443** - HTTPS (can be added later with nginx/SSL)

The application is configured to use port 80. If you need HTTPS (port 443), you can:
1. Set up nginx as a reverse proxy
2. Add SSL certificates (Let's Encrypt recommended)
3. Configure nginx to proxy to gunicorn

## 📊 System Service (Optional)

To run automatically on boot:

```bash
# Install service
sudo cp mnml-shop.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable mnml-shop
sudo systemctl start mnml-shop

# Check status
sudo systemctl status mnml-shop

# View logs
sudo journalctl -u mnml-shop -f
```

## 🧪 Testing

```bash
source venv/bin/activate
./test_app.py
```

## 📝 Key Files

| File | Purpose |
|------|---------|
| `app.py` | Main Flask application |
| `gunicorn.conf.py` | Server configuration (port 80) |
| `requirements.txt` | Minimal dependencies |
| `setup.sh` | Setup script |
| `start_shop.sh` | Start script |
| `cleanup_unused_files.sh` | Cleanup script |
| `test_app.py` | Test script |
| `mnml-shop.service` | Systemd service |
| `templates/shop.html` | Shop HTML |
| `static/css/shop.css` | Shop styles |
| `static/js/shop.js` | Shop JavaScript |

## 💡 Tips

- **Memory Usage**: ~150MB (single worker)
- **Startup Time**: <5 seconds
- **Port 80 needs sudo**: Always use `sudo ./start_shop.sh`
- **Logs**: stdout/stderr (visible in terminal or journalctl)

## 🆘 Troubleshooting

**Port 80 in use?**
```bash
sudo netstat -tulpn | grep :80
sudo systemctl stop apache2  # If Apache is running
```

**Dependencies not installed?**
```bash
./setup.sh
```

**Check if app works?**
```bash
source venv/bin/activate
./test_app.py
```

## 🎯 Next Steps

1. Run `./setup.sh` to install dependencies
2. Run `sudo ./start_shop.sh` to start the server
3. Access http://your-server-ip/ in your browser
4. (Optional) Run `./cleanup_unused_files.sh` to free up space
5. (Optional) Set up systemd service for auto-start

---

**Ready to launch your shop!** 🚀
