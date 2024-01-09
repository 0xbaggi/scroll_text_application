#!/bin/bash
# Check if port and password arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <port> <sudo_password>"
    exit 1
fi

# Assign the first argument to PORT and the second to PW
PORT=$1
PW=$2

GAME_FOLDER="server"

LG_SCREEN_AMOUNT=$(grep -oP '(?<=DHCP_LG_FRAMES_MAX=).*' /home/lg/personavars.txt)

time=$(date +%H:%M:%S)
echo "[$time] Installing Scroll text application..."

# Open port
LINE=`cat /etc/iptables.conf | grep "tcp" | grep "8111" | awk -F " -j" '{print $1}'`
RESULT=$LINE",$PORT"

DATA=`cat /etc/iptables.conf | grep "tcp" | grep "8111" | grep "$PORT"`

if [ "$DATA" == "" ]; then
  time=$(date +%H:%M:%S)
  echo "[$time] Opening port $PORT..."
  echo $PW | sudo -S sed -i "s/$LINE/$RESULT/g" /etc/iptables.conf
else
  time=$(date +%H:%M:%S)
  echo "[$time] Port already open."
fi

# Install dependencies
time=$(date +%H:%M:%S)
echo "[$time] Installing dependencies..."
cd $GAME_FOLDER/
echo $PW | sudo -S npm install -y
chmod +x open.sh close.sh poweroff.sh


# Add access for pm2
echo $PW | sudo -S chown lg:lg /home/lg/.pm2/rpc.sock /home/lg/.pm2/pub.sock

# Stop server if already started
echo $PW | sudo -S pm2 delete SCROLL_TEXT:$PORT 2> /dev/null

# Start server
time=$(date +%H:%M:%S)
echo "[$time] Starting pm2..."
echo $PW | sudo -S pm2 start index.js --name SCROLL_TEXT:$PORT
echo $PW | sudo -S pm2 save

# Add automatic pm2 resurrect script
time=$(date +%H:%M:%S)
echo "[$time] Updating resurrect script..."
RESURRECT=$(pm2 startup | grep 'sudo')
echo $PW | sudo -S eval $RESURRECT

time=$(date +%H:%M:%S)
echo "[$time] Installation complete. Reboot your machine to finish it."

echo $PW | sudo -S reboot