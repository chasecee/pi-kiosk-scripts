#!/bin/bash
export DISPLAY=:0
LOGFILE="/home/pi/scripts/start_chromium.log"
echo "$(date) - Starting Chromium" >> $LOGFILE
xset s off >> $LOGFILE 2>&1
xset -dpms >> $LOGFILE 2>&1
xset s noblank >> $LOGFILE 2>&1
unclutter -idle 0.1 -root & >> $LOGFILE 2>&1
chromium-browser --kiosk --noerrdialogs --no-restore --disable-translate --disable-infobars --disable-features=TranslateUI --incognito --disable-gpu "https://pi-dashboard-one.vercel.app/" >> $LOGFILE 2>&1
echo "$(date) - Chromium has started" >> $LOGFILE
