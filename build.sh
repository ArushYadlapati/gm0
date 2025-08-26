#!/bin/bash
set -e

echo "Starting build process..."

# Check if we're in a Vercel environment and try to install graphviz
if [ "$VERCEL" = "1" ]; then
    echo "Detected Vercel environment"
    # Try different package managers that might be available on Vercel
    if command -v yum &> /dev/null; then
        echo "Installing graphviz via yum..."
        yum install -y graphviz || echo "Warning: Could not install graphviz via yum"
    elif command -v apt-get &> /dev/null; then
        echo "Installing graphviz via apt-get..."
        apt-get update && apt-get install -y graphviz || echo "Warning: Could not install graphviz via apt-get"
    elif command -v apk &> /dev/null; then
        echo "Installing graphviz via apk..."
        apk add --no-cache graphviz || echo "Warning: Could not install graphviz via apk"
    else
        echo "Warning: No supported package manager found, graphviz may not be available"
        echo "The build will continue but graphviz diagrams may not render properly"
    fi
else
    echo "Local environment detected"
fi

# Only install Python dependencies if requirements.txt is newer than a marker file
# This helps avoid reinstalling when packages are already installed
if [ ! -f .deps-installed ] || [ source/requirements.txt -nt .deps-installed ]; then
    echo "Installing/updating Python dependencies..."
    python3 -m pip install --upgrade pip
    python3 -m pip install -r source/requirements.txt
    touch .deps-installed
else
    echo "Python dependencies are up to date"
fi

# Build the documentation
echo "Building Sphinx documentation..."
sphinx-build -b html source build/html

echo "Build completed successfully!"
echo "Output directory: build/html"
