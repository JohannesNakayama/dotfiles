#!/usr/bin/env bash

# Terminate all running polybars
polybar-msg cmd quit

# Launch main bar
polybar -r main &

# # Launch bar for external monitor
# # --> adapted from https://protesilaos.com/codelog/multihead-bspwm-polybar/
external_monitor=$(xrandr --query | grep 'HDMI-1')
if [[ $external_monitor = *connected* ]]; then
  polybar -r main_external &
fi
