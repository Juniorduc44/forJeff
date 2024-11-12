#!/bin/bash

echo "Starting cleanup and broken packages fix..."

# Clean package management system
sudo apt clean
sudo apt autoclean

# Remove old downloaded archive files
sudo apt autoremove -y

# Clear out local repository of retrieved package files
sudo rm -rf /var/lib/apt/lists/*

# Update package lists
sudo apt update

# Try to fix broken packages with different methods
sudo dpkg --configure -a
sudo apt-get install -f
sudo apt --fix-broken install

# Check for and remove conflicting packages
echo "Checking for any existing wine installations..."
sudo apt remove --purge wine wine32 wine64 libwine wine-stable wine-stable-amd64 wine-stable-i386 winehq-stable:i386 -y

# Clean up again
sudo apt autoremove -y
sudo apt clean

# Re-enable 32-bit architecture
sudo dpkg --add-architecture i386
sudo apt update

# Try installing wine32 dependencies explicitly
sudo apt install -y \
    libc6:i386 \
    libwine:i386 \
    wine32-preloader:i386 \
    --fix-broken

# Final check and fix
sudo apt --fix-broken install

echo "Cleanup complete. Now try installing wine32 again."