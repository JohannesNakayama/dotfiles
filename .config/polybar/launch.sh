#!/usr/bin/env bash

# Kill all running polybars
# killall -q polybar &
# kill -9 $(pgrep -f 'polybar') > /dev/null 2>&1
# kill $(ps aux | grep 'polybar' | awk '{print $2}')  >/dev/null 2>&1
polybar-msg cmd quit

# Wait until killing is done
# while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch main bar
polybar -r main &

# # Launch bar for external monitor
# # --> adapted from https://protesilaos.com/codelog/multihead-bspwm-polybar/
external_monitor=$(xrandr --query | grep 'HDMI-1')
if [[ $external_monitor = *connected* ]]; then
  polybar -r main_external &
fi
