# First, let's make a backup of your current sources.list
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup

# View current content to identify duplicates
    cat /etc/apt/sources.list

# Remove duplicates and clean up the file
    sudo awk '!seen[$0]++' /etc/apt/sources.list | sudo tee /etc/apt/sources.list.tmp
    sudo mv /etc/apt/sources.list.tmp /etc/apt/sources.list