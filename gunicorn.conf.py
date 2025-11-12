# Gunicorn configuration for MNML Fashion Shop
# Optimized for very low-resource AWS instances (1 CPU, ~640MB available RAM)

import os

# Server socket
bind = "0.0.0.0:80"  # Port 80 for HTTP (port 443 for HTTPS when needed)
backlog = 512  # Reduced for low traffic

# Worker processes - minimal configuration for ~640MB available RAM
# Single worker, single thread for absolute minimal memory footprint
workers = 1
worker_class = "sync"  # Changed from gthread to sync (lighter weight)
threads = 1  # Single thread
worker_connections = 100  # Reduced for memory-constrained system
timeout = 60  # Reasonable timeout
keepalive = 2

# Restart workers to prevent memory leaks
max_requests = 500  # Reasonable restart frequency
max_requests_jitter = 50

# Logging - using stdout/stderr for Docker/systemd compatibility
accesslog = "-"  # Log to stdout
errorlog = "-"   # Log to stderr
loglevel = "info"

# Process naming
proc_name = "mnml_shop"

# Server mechanics
daemon = False
preload_app = True  # Preload to save memory (safe for simple Flask app)

# Graceful timeout
graceful_timeout = 30

# Memory management
# For ~640MB available RAM: target ~150MB per worker max
max_worker_memory = 150  # MB

# Worker lifecycle hooks
def post_fork(server, worker):
    """Called after a worker has been forked."""
    worker.log.info(f"Worker {worker.pid}: MNML Shop initialized")

def on_exit(server):
    """Called when gunicorn is shutting down."""
    server.log.info("MNML Shop shutting down gracefully")
