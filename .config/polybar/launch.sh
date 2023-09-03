#!/usr/bin/env sh

# Kill all running polybars
killall -q polybar

# Wait until killing is done
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

nm-applet &

# Launch main bar
# -> adapted from https://protesilaos.com/codelog/multihead-bspwm-polybar/
polybar main &

# Launch bar for external monitor
# --> adapted from https://protesilaos.com/codelog/multihead-bspwm-polybar/
external_monitor=$(xrandr --query | grep 'HDMI-A-0')
if [[ $external_monitor = *connected* ]]; then
    polybar main_external &
fi
