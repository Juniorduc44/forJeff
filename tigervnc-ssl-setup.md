# TigerVNC SSL Certificate Setup Guide

## 1. Prerequisites Installation
```bash
# Install required packages
sudo apt update
sudo apt install openssl tigervnc-standalone-server
```

## 2. Certificate Directory Setup
```bash
# Create necessary directories
mkdir -p ~/.vnc/certs
cd ~/.vnc/certs
```

## 3. Generate SSL Certificate
```bash
# Generate self-signed certificate and private key
openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 \
  -nodes -keyout private.key \
  -out cert.pem \
  -subj "/CN=localhost" \
  -addext "subjectAltName=DNS:localhost,IP:127.0.0.1"

# Set proper permissions
chmod 600 private.key
chmod 644 cert.pem
```

## 4. Configure TigerVNC Server
Create or edit the VNC config file:
```bash
nano ~/.vnc/config

# Add these lines:
SecurityTypes=TLSVnc,VncAuth
X509Cert=/home/YOUR_USERNAME/.vnc/certs/cert.pem
X509Key=/home/YOUR_USERNAME/.vnc/certs/private.key
```
Replace YOUR_USERNAME with your actual username.

## 5. Set VNC Password (if not already done)
```bash
vncpasswd
```

## 6. Start/Restart VNC Server
```bash
# Kill existing server if running
vncserver -kill :1

# Start new server instance
vncserver :1
```

## 7. Verify Server Status
```bash
# Check if server is running
ps aux | grep vnc

# Check listening ports
netstat -tuln | grep 590
```

## 8. Remmina Client Configuration

1. Open Remmina
2. Create new or edit existing connection
3. Set these parameters:
```
Protocol: VNC
Server: localhost:5901 (or your IP:5901)
Password: [Your VNC Password]
Color depth: Automatic (32 bpp)

Advanced Settings:
- Enable "Use SSL/TLS"
- Check "Ignore certificate" (for self-signed cert)
```

## 9. Security Verification
```bash
# Verify certificate
openssl x509 -in ~/.vnc/certs/cert.pem -text -noout

# Check file permissions
ls -l ~/.vnc/certs/
```

## Troubleshooting

### If Connection Fails
1. Check certificate paths:
```bash
ls -l ~/.vnc/certs/cert.pem
ls -l ~/.vnc/certs/private.key
```

2. Verify config file:
```bash
cat ~/.vnc/config
```

3. Check server logs:
```bash
tail -f ~/.vnc/*.log
```

### Common Issues and Solutions

1. Certificate Permission Issues:
```bash
# Reset permissions if needed
chmod 600 ~/.vnc/certs/private.key
chmod 644 ~/.vnc/certs/cert.pem
```

2. Path Issues:
```bash
# Make sure to use absolute paths in config
readlink -f ~/.vnc/certs/cert.pem
readlink -f ~/.vnc/certs/private.key
```

3. Server Already Running:
```bash
# Kill all VNC servers
vncserver -kill :*

# Start fresh
vncserver :1
```

## Testing Connection

1. Local Test:
```bash
vncviewer localhost:5901 -SecurityTypes=TLSVnc
```

2. System Log Check:
```bash
journalctl -u vncserver@1.service -f
```
