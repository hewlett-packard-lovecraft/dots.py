#!/usr/bin/env bash

### Hot reload lisgd with swaywm

killall -9 lisgd

exec lisgd -d /dev/input/event1 -o 0 -t 20 -r 20 -m 750 \
    -g "1,DU,T,S,R,swaync-client -C" \
    -g "3,UD,N,S,R,pkill -SIGUSR2 nwg-drawer" \
    -g "3,DU,N,S,R,pkill -SIGRTMIN+3 nwg-drawer" \
    -g "1,DU,L,S,R,pkill -SIGRTMIN+3 nwg-drawer" \
    -g "4,LR,N,S,R,swaymsg workspace prev_on_output" \
    -g "4,RL,N,S,R,swaymsg workspace next_on_output" \
    -g "1,LR,B,S,R,~/.config/sway/touchscreen/wvkbd_toggle.sh" \
    -g "1,RL,B,S,R,~/.config/sway/touchscreen/wvkbd_toggle.sh" \
    -g "1,DU,R,*,P,brightnessctl s +5%" \
    -g "1,UD,R,*,P,brightnessctl s 5%-" \
    -g "5,DU,N,*,R,swaymsg fullscreen"



    # -g "1,DU,L,S,R,~/.config/sway/touchscreen/wvkbd_show.sh" \
    # -g "1,UD,L,S,R,~/.config/sway/touchscreen/wvkbd_hide.sh" \
