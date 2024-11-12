# First clean and update
sudo apt clean
sudo apt update

# Install the core dependencies that are causing issues
sudo apt install -y \
    libsystemd0:i386 \
    libcurl4:i386 \
    libdw1:i386 \
    libudev1:i386 \
    libdbus-1-3:i386 \
    libgphoto2-6:i386 \
    libgstreamer1.0-0:i386 \
    libpulse0:i386 \
    libusb-1.0-0:i386

# Install recommended packages
sudo apt install -y \
    libcups2:i386 \
    libgl1:i386 \
    libgssapi-krb5-2:i386 \
    libkrb5-3:i386 \
    libosmesa6:i386 \
    libsdl2-2.0-0:i386 \
    libgl1-mesa-dri:i386 \
    libasound2-plugins:i386 \
    gstreamer1.0-plugins-good:i386

# Fix any remaining issues
sudo apt --fix-broken install

# Now try installing wine32
sudo apt install wine32

### If you have duplicates in sources.list [remove](removeDuplicatesSourceList.md) them.
