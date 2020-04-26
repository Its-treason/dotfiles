#!/usr/bin/env bash

killall -r polybar

sleep 2

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload bar1 &
  done
else
  polybar --reload bar1 &
fi
