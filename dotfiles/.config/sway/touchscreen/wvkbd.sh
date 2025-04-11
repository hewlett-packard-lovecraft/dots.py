#!/usr/bin/env bash

### this script toggles wvkbd visibility if it is running

OSK_PID_FILE="/tmp/wvkbd_osk_pidfile.pid"
OSK_PID="$(<"$OSK_PID_FILE")"

if pgrep -F $OSK_PID_FILE; then
    pkill -F $OSK_PID_FILE
fi

## write PID to file
echo "$$" > "$OSK_PID_FILE"
## start hidden (send SIGUSR2 to show, SIGUSR1 to hide, SIGRTMIN to toggle)
exec wvkbd-mobintl -L 320 -l simple,special,emoji -o --hidden
