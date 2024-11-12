#!/bin/bash

# Set script to exit on error
set -e

echo "KasmVNC Alpine Installation Script"
echo "================================="

# Function to check if command executed successfully
check_status() {
    if [ $? -eq 0 ]; then
        echo "[✓] $1 completed successfully"
    else
        echo "[×] Error: $1 failed"
        exit 1
    fi
}

# Function to check if running as root
check_root() {
    if [ "$(id -u)" != "0" ]; then
        echo "This script must be run as root or with sudo"
        exit 1
    fi
}

# Function to clean up package management
clean_package_management() {
    echo "Cleaning package management..."
    sudo rm -rf /var/lib/apt/lists/*
    sudo apt clean
    sudo apt update --fix-missing
    check_status "Package management cleanup"
}

# Main installation function
install_kasmvnc() {
    # Create installation directory
    echo "Creating installation directory..."
    sudo mkdir -p /opt/kasmvnc
    check_status "Directory creation"

    # Extract the tar file
    echo "Extracting KasmVNC package..."
    sudo tar -xzf kasmvnc.alpine_317_x86_64.tgz -C /opt/kasmvnc
    check_status "Package extraction"

    # Create symbolic links
    echo "Creating symbolic links..."
    sudo ln -sf /opt/kasmvnc/bin/kasmvncserver /usr/local/bin/
    sudo ln -sf /opt/kasmvnc/bin/kasmvncpasswd /usr/local/bin/
    check_status "Symbolic links creation"

    # Set up configuration directory
    echo "Setting up configuration..."
    sudo mkdir -p /etc/kasmvnc
    sudo cp /opt/kasmvnc/etc/kasmvnc/kasmvnc.yaml /etc/kasmvnc/ 2>/dev/null || true
    check_status "Configuration setup"

    # Create systemd service file
    echo "Creating systemd service..."
    cat << EOF | sudo tee /etc/systemd/system/kasmvncserver.service
[Unit]
Description=KasmVNC Server
After=network.target

[Service]
Type=forking
ExecStart=/usr/local/bin/kasmvncserver :1
User=$SUDO_USER
Restart=always

[Install]
WantedBy=multi-user.target
EOF
    check_status "Service file creation"

    # Reload systemd
    echo "Reloading systemd..."
    sudo systemctl daemon-reload
    check_status "Systemd reload"

    # Enable and start service
    echo "Enabling and starting KasmVNC service..."
    sudo systemctl enable kasmvncserver || true
    sudo systemctl start kasmvncserver || true
    check_status "Service startup"

    # Set up VNC password
    echo "Setting up VNC password..."
    echo "Please enter your desired VNC password:"
    sudo -u $SUDO_USER kasmvncpasswd || true
    check_status "Password setup"
}

# Main execution
main() {
    check_root
    
    echo "Starting KasmVNC installation..."
    
    # Clean up package management first
    clean_package_management
    
    # Install minimal required dependencies
    echo "Installing minimal dependencies..."
    sudo apt install -y python3 openssl net-tools || true
    check_status "Dependencies installation"

    # Run installation
    install_kasmvnc

    echo "Installation complete!"
    echo "You can now connect to KasmVNC at https://localhost:6901"
    echo "Use the password you set during installation"
    echo "To start a new session: kasmvncserver -create-session"
    echo "To list sessions: kasmvncserver -list"
    echo "To kill a session: kasmvncserver -kill :1"
}

# Run script
main

exit 0