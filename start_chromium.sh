#!/bin/bash
export DISPLAY=:0
LOGFILE="/home/pi/pi-kiosk-scripts/start_chromium.log"
echo "$(date) - Starting Chromium" >> $LOGFILE

# Disabling energy saving settings and screen blanking
xset s off >> $LOGFILE 2>&1
xset -dpms >> $LOGFILE 2>&1
xset s noblank >> $LOGFILE 2>&1

# Hiding the mouse when not in use
unclutter -idle 0.1 -root & >> $LOGFILE 2>&1

# Starting Chromium in kiosk mode with additional flags to address errors
chromium-browser --kiosk --noerrdialogs --disable-session-crashed-bubble --disable-infobars --incognito --disable-translate --disable-features=TranslateUI --autoplay-policy=no-user-gesture-required --overscroll-history-navigation=0 --no-first-run --no-default-browser-check --disable-background-timer-throttling --disable-breakpad --check-for-update-interval=31536000 --disable-component-update --enable-features=OverlayScrollbar --force-device-scale-factor=1 "https://pi-dashboard-one.vercel.app/" >> $LOGFILE 2>&1

echo "--------HEYY------------- $(date) - Chromium has started" >> $LOGFILE

# Log file maintenance for size management
MAX_SIZE=50000 # Maximum file size in bytes (50KB in this example)
if [ $(stat -c%s "$LOGFILE") -ge $MAX_SIZE ]; then
    tail -n 1000 "$LOGFILE" > "$LOGFILE.tmp" && mv "$LOGFILE.tmp" "$LOGFILE"
    echo "Log file trimmed." >> $LOGFILE
fi