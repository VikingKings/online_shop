"""
Simplified Flask application for the MNML Fashion Shop.
Optimized for low-resource AWS instances.
"""

import logging
import os
from datetime import datetime, timezone

from flask import Flask, jsonify, render_template
from flask_cors import CORS

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = Flask(__name__)
CORS(app)

# Sample product data (in a real app, this would come from a database)
PRODUCTS = [
    {
        "id": 1,
        "name": "Essential Tee",
        "price": 25.00,
        "image": "shirt.png",
        "description": "Classic minimalist t-shirt in premium cotton",
        "category": "tops"
    },
    {
        "id": 2,
        "name": "Premium Hoodie",
        "price": 45.00,
        "image": "shirt.png",
        "description": "Comfortable hoodie with modern fit",
        "category": "tops"
    },
    {
        "id": 3,
        "name": "Slim Jeans",
        "price": 65.00,
        "image": "shirt.png",
        "description": "Tailored denim with stretch comfort",
        "category": "bottoms"
    },
    {
        "id": 4,
        "name": "Classic Sneakers",
        "price": 85.00,
        "image": "shirt.png",
        "description": "Minimalist white sneakers",
        "category": "shoes"
    },
    {
        "id": 5,
        "name": "Oversized Tee",
        "price": 30.00,
        "image": "shirt.png",
        "description": "Relaxed fit oversized t-shirt",
        "category": "tops"
    },
    {
        "id": 6,
        "name": "Cargo Pants",
        "price": 70.00,
        "image": "shirt.png",
        "description": "Modern cargo pants with multiple pockets",
        "category": "bottoms"
    }
]


@app.route("/")
def index():
    """Main shop page"""
    return render_template("shop.html")


@app.route("/api/products", methods=["GET"])
def get_products():
    """API endpoint to get all products"""
    return jsonify({
        "success": True,
        "products": PRODUCTS,
        "count": len(PRODUCTS)
    })


@app.route("/api/products/<int:product_id>", methods=["GET"])
def get_product(product_id):
    """API endpoint to get a specific product"""
    product = next((p for p in PRODUCTS if p["id"] == product_id), None)
    if product:
        return jsonify({
            "success": True,
            "product": product
        })
    return jsonify({
        "success": False,
        "error": "Product not found"
    }), 404


@app.route("/health", methods=["GET"])
def health_check():
    """Health check endpoint"""
    return jsonify({
        "status": "ok",
        "timestamp": datetime.now(timezone.utc).isoformat(),
        "service": "MNML Fashion Shop",
        "products_count": len(PRODUCTS)
    })


@app.route("/ready", methods=["GET"])
def ready_check():
    """Readiness check endpoint for load balancers"""
    return jsonify({"status": "ready"})


if __name__ == "__main__":
    port = int(os.getenv("PORT", 80))
    debug = os.getenv("DEBUG", "false").lower() == "true"
    app.run(host="0.0.0.0", port=port, debug=debug)
