#!/usr/bin/env bash
options="Shutdown
Reboot
Suspend
Logout"
theme=${1:-$HOME/.cache/wal/power.rasi}
selection=$(echo -e "${options}" | rofi -p "" -dmenu -i -config $theme)
case "${selection}" in
  "Shutdown")
    shutdown now;;
  "Reboot")
    systemctl reboot;;
  "Suspend")
    systemctl suspend;;
  "Logout")
    i3-msg exit;;
esac
