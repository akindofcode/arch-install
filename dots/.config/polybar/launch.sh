#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until all processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
polybar top &
#polybar bar1 &
#polybar bar2 &
