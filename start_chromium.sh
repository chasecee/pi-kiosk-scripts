#!/bin/bash
export DISPLAY=:0
LOGFILE="/home/pi/scripts/start_chromium.log"
echo "$(date) - Starting Chromium" >> $LOGFILE

xset s off >> $LOGFILE 2>&1
xset -dpms >> $LOGFILE 2>&1
xset s noblank >> $LOGFILE 2>&1
unclutter -idle 0.1 -root & >> $LOGFILE 2>&1
chromium-browser --kiosk --noerrdialogs --no-restore --disable-translate --disable-infobars --disable-features=TranslateUI > /dev/null 2>&1 &

echo "$(date) - Chromium has started" >> $LOGFILE

# Log trimming
MAX_SIZE=50000 # Maximum file size in bytes (50KB in this example)
if [ $(stat -c%s "$LOGFILE") -ge $MAX_SIZE ]; then
    tail -n 1000 "$LOGFILE" > "$LOGFILE.tmp" && mv "$LOGFILE.tmp" "$LOGFILE"
    echo "Log file trimmed." >> $LOGFILE
fi
