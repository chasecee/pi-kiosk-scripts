#!/bin/bash
export DISPLAY=:0
WID=$(xdotool search --onlyvisible --class chromium | head -1)
if [ -n $WID ]; then
    xdotool windowactivate $WID
    xdotool key F5
else
    echo "Chromium window not found."
fi
