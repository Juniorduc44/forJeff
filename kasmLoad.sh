#!/bin/bash
# 1. First, fully remove any existing installation
sudo apt remove --purge kasmvncserver
sudo apt autoremove
sudo apt clean

# 2. Make sure all dependencies are up to date
sudo apt update
sudo apt upgrade

# 3. Install required dependencies (KasmVNC typically needs these)
sudo apt install -y python3 python3-pip openssl python3-numpy python3-pil net-tools websockify

# 4. Now install the KasmVNC .deb file
sudo apt install ./kasmvncserver_bookworm_1.3.3_amd64.deb

# 5. Reload systemd to recognize the new service
sudo systemctl daemon-reload

# 6. Start the service
sudo systemctl start kasmvncserver

# 7. Enable the service
sudo systemctl enable kasmvncserver

# 8. Check the status
sudo systemctl status kasmvncserver