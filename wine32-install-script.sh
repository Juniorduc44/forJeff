#!/bin/bash

# Exit on error
set -e

echo "Starting Wine32 dependencies installation..."

# Enable 32-bit architecture
echo "Enabling 32-bit architecture..."
sudo dpkg --add-architecture i386
sudo apt update

# Install core dependencies
echo "Installing core dependencies..."
sudo apt install -y \
    libc6:i386 \
    libwine:i386 \
    wine32-preloader:i386

# Install recommended packages
echo "Installing recommended Wine package..."
sudo apt install -y wine

# Verify installation
echo "Verifying installations..."
dpkg -l | grep -i wine

echo "Checking for any missing dependencies..."
sudo apt --fix-broken install

echo "Installation complete. Running version check..."
wine --version

# Function to check if installation was successful
check_installation() {
    if [ $? -eq 0 ]; then
        echo "Installation completed successfully!"
    else
        echo "There were some issues with installation."
        echo "Attempting to fix broken packages..."
        sudo apt --fix-broken install
        sudo apt update && sudo apt upgrade -y
    fi
}

check_installation

echo "To test Wine32, try running: wine notepad"
