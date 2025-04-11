#!/usr/bin/env bash

### toggle wvkbd visibility if it's running

OSK_PID_FILE="/tmp/wvkbd_osk_pidfile.pid"
OSK_PID="$(<"$OSK_PID_FILE")"

if ps -p $OSK_PID &> /dev/null; then
    ## (send SIGUSR2 to show, SIGUSR1 to hide, SIGRTMIN to toggle)
    kill -SIGRTMIN $OSK_PID
fi
