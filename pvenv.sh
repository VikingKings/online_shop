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
