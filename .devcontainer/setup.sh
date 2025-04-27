#!/bin/bash

echo "🚀 Running post-creation setup for ULTRA MAX PERFORMANCE..."

# Update & install necessary tools
apt update && apt install -y     jq zip unzip python3-venv tlp     && apt clean && rm -rf /var/lib/apt/lists/*

# Enable CPU performance mode
echo performance | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Enable ZRAM swap
systemctl restart zramswap

# Install Node.js tools globally
npm install -g npm yarn pm2

# Increase file limits
echo '* soft nofile 1048576' | tee -a /etc/security/limits.conf
echo '* hard nofile 1048576' | tee -a /etc/security/limits.conf
ulimit -n 1048576

# Enable TLP for power management
systemctl enable tlp && systemctl start tlp

# Start Docker service
systemctl start docker

# Download and execute external scripts in WORKSPACE
cd "/workspaces/lightwaight"
curl -sSLO https://raw.githubusercontent.com/naksh-07/Automate/refs/heads/main/mega.sh && bash mega.sh
curl -sSLO https://raw.githubusercontent.com/naksh-07/Automate/refs/heads/main/mega_downloader.sh && bash mega_downloader.sh
curl -sSLO https://raw.githubusercontent.com/naksh-07/Automate/refs/heads/main/ognode.sh && bash ognode.sh
curl -sSLO https://raw.githubusercontent.com/naksh-07/Automate/refs/heads/main/pipe.sh && bash pipe.sh


# Check if Gbot.env exists in the current directory
if [ -f "Gbot.env" ]; then
    echo "✅ Gbot.env found! Running Gbot.sh script..."
    curl -sSLO https://raw.githubusercontent.com/naksh-07/Automate/refs/heads/main/Gbot.sh && bash Gbot.sh
else
    echo "⚠️ Gbot.env not found! Skipping Gbot.sh script..."
fi

#pull image for browser
docker pull  rohan014233/thorium

#run script for browser either restores it or makes new 
curl -sSLO https://raw.githubusercontent.com/naksh-07/Browser-Backup-Restore/refs/heads/main/restore.sh && bash restore.sh


# Stop containers from restarting automatically
for cid in $(docker ps -q); do
  docker update --restart=no "$cid"
done

# Stop all running Docker containers
echo "🛑 Stopping all running Docker containers..."
docker stop $(docker ps -q)

# Bonus thoda attitude mein
echo "💥 All containers stopped. Shanti mil gayi!"



# Start Codespace Tracker
cd /workspaces/lightwaight/codespace-tracker
./setup.sh



echo "✅ Setup complete! ULTRA OPTIMIZED Codespace is READY 🚀🔥"
