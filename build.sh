#!/bin/bash
set -e

# Install system dependencies if needed
echo "Installing system dependencies..."

# Upgrade pip to latest version
pip install --upgrade pip

# Install Python dependencies
echo "Installing Python dependencies..."
pip install -r source/requirements.txt

# Build the documentation
echo "Building Sphinx documentation..."
make html

echo "Build completed successfully!"
