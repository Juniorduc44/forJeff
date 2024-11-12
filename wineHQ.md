# WineHQ Installation Guide for Debian-based Systems

## Prerequisites
First, enable 32-bit architecture (required for Wine):
```bash
sudo dpkg --add-architecture i386
```

## Step 1: Add WineHQ Repository Key
```bash
# Download the repository key
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
```

## Step 2: Add WineHQ Repository
```bash
# For Ubuntu 22.04
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources

# For Ubuntu 20.04
# sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/focal/winehq-focal.sources

# For Debian 12
# sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources
```

## Step 3: Update Package List
```bash
sudo apt update
```

## Step 4: Install WineHQ
Choose one of the following versions:

### Stable Version (Recommended)
```bash
sudo apt install --install-recommends winehq-stable
```

### Development Version
```bash
sudo apt install --install-recommends winehq-devel
```

### Staging Version
```bash
sudo apt install --install-recommends winehq-staging
```

## Step 5: Verify Installation
```bash
wine --version
```

## Common Issues and Solutions

1. If you get a GPG error:
```bash
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys <key_number>
```

2. If you get dependency errors:
```bash
sudo apt install -f
```

3. If installation fails, try:
```bash
sudo apt update && sudo apt upgrade
sudo apt install wine64 wine32
```

## Optional: Install Additional Dependencies
```bash
sudo apt install winetricks
```

## Usage
- Run Windows programs: `wine program.exe`
- Configure Wine: `winecfg`
- Install additional Windows components: `winetricks`f