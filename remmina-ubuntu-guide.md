# Step by Step Remmina VNC Setup Guide for Ubuntu

## Part 1: Server Setup
1. Install VNC Server
```bash
sudo apt update
sudo apt install tigervnc-standalone-server
```

2. Create VNC Password
```bash
vncpasswd
```
- Enter your desired password when prompted
- Confirm password
- Answer 'n' to view-only password

3. Start VNC Server
```bash
vncserver :1
```
- This creates a new VNC session on display :1
- The port will be 5901 (5900 + display number)

## Part 2: Remmina Client Setup

1. Open Remmina
   - Click Ubuntu menu or press Super key
   - Type "Remmina"
   - Click the Remmina icon

2. Create New Connection
   - Click the "+" icon in the top left
   - This opens the "Remote Connection Profile"

3. Fill in Basic Settings
   - Name: "Local VNC" (or any name you prefer)
   - Protocol: Change to "VNC - Virtual Network Computing"
   - Server: localhost:5901 (or your IP:5901)
   - Password: Enter the password you set with vncpasswd
   - Color depth: Automatic (32 bpp)
   - Resolution: Choose "Use client resolution"

4. Optional Settings
   - Network connection type: LAN
   - Quality: Best
   - Disable any options you don't need:
     - Left-handed mouse support
     - Enable multi monitor
     - Span screen over multiple monitors

5. Save and Connect
   - Click "Save and Connect"
   - Or "Save" if you want to connect later

## Part 3: Managing Connections

### To Start a Session:
1. Open Remmina
2. Select your saved connection
3. Click "Connect"

### To End a Session:
1. Close the VNC window
2. Or on server:
```bash
vncserver -kill :1
```

### To Check Server Status:
```bash
ps aux | grep vnc
```

## Troubleshooting

If Connection Fails:
1. Verify server is running:
```bash
ps aux | grep vnc
```

2. Check port is listening:
```bash
netstat -tuln | grep 5901
```

3. Restart VNC server:
```bash
vncserver -kill :1
vncserver :1
```

4. Verify connection settings in Remmina:
   - Server address is correct
   - Password is correct
   - Port number matches server (5901)

## Common Settings

### For Local Connection:
- Server: localhost:5901
- Network: LAN
- Quality: Best

### For Remote Connection:
- Server: [IP-ADDRESS]:5901
- Network: Broadband
- Quality: Medium/Good
