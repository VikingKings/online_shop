#!/usr/bin/env python3
"""
Simple test script to verify the MNML Fashion Shop application
"""

import sys


def test_imports():
    """Test that all required modules can be imported"""
    print("Testing imports...")
    try:
        import flask
        print(f"  ✓ Flask {flask.__version__}")
        
        import flask_cors
        print(f"  ✓ Flask-CORS installed")
        
        import gunicorn
        print(f"  ✓ Gunicorn {gunicorn.__version__}")
        
        return True
    except ImportError as e:
        print(f"  ✗ Import failed: {e}")
        return False


def test_app_loading():
    """Test that the app module loads correctly"""
    print("\nTesting app module...")
    try:
        import app
        print(f"  ✓ App module loaded")
        print(f"  ✓ Flask app created: {app.app.name}")
        print(f"  ✓ Products loaded: {len(app.PRODUCTS)} items")
        return True
    except Exception as e:
        print(f"  ✗ App loading failed: {e}")
        return False


def test_routes():
    """Test that all routes are registered"""
    print("\nTesting routes...")
    try:
        import app
        routes = [rule.rule for rule in app.app.url_map.iter_rules()]
        expected_routes = ['/', '/api/products', '/api/products/<int:product_id>', '/health', '/ready']
        
        for route in expected_routes:
            # Flask adds /static route automatically
            if any(r.startswith(route.split('<')[0]) for r in routes):
                print(f"  ✓ Route registered: {route}")
            else:
                print(f"  ✗ Route missing: {route}")
                return False
        
        return True
    except Exception as e:
        print(f"  ✗ Route testing failed: {e}")
        return False


def test_app_context():
    """Test Flask app context"""
    print("\nTesting app context...")
    try:
        import app
        with app.app.app_context():
            print(f"  ✓ App context works")
            print(f"  ✓ App debug mode: {app.app.debug}")
        return True
    except Exception as e:
        print(f"  ✗ App context failed: {e}")
        return False


def main():
    """Run all tests"""
    print("=" * 50)
    print("MNML Fashion Shop - Application Tests")
    print("=" * 50)
    print()
    
    tests = [
        test_imports,
        test_app_loading,
        test_routes,
        test_app_context,
    ]
    
    results = []
    for test in tests:
        try:
            result = test()
            results.append(result)
        except Exception as e:
            print(f"\n✗ Test crashed: {e}")
            results.append(False)
        print()
    
    print("=" * 50)
    if all(results):
        print("✓ All tests passed!")
        print("=" * 50)
        print()
        print("The application is ready to run.")
        print("Start with: sudo ./start_shop.sh")
        return 0
    else:
        print("✗ Some tests failed!")
        print("=" * 50)
        print()
        print("Please fix the issues before running the application.")
        return 1


if __name__ == "__main__":
    sys.exit(main())
