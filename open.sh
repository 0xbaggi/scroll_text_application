# Check if port and password arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <port> <sudo_password>"
    exit 1
fi

# Assign the first argument to PORT and the second to PW
PORT=$1
PW=$2

export DISPLAY=:0.0

# Open Chromium in full screen to the specified page and port, without printing logs
chromium-browser --start-fullscreen http://localhost:$PORT > /dev/null 2>&1 &

sleep 1

. ${HOME}/etc/shell.conf

# Convert the LG_FRAMES variable to an array
lg_frames_array=($LG_FRAMES)

# Use a custom sort function to sort the array based on the screen number
IFS=$'\n' lg_frames_sorted=($(sort -t 'g' -k2n <<<"${lg_frames_array[*]}"))
unset IFS

# Iterate over the sorted array and execute commands
for lg in "${lg_frames_sorted[@]}"; do
  screenNumber=${lg:2}
  if [ "$lg" != "lg1" ]; then
    echo $lg
    sshpass -p $PW ssh -tXn $lg "export DISPLAY=:0; chromium-browser http://lg1:$PORT --start-fullscreen &" &
  fi
  sleep 1
done