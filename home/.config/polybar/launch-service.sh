#!/usr/bin/env bash
options=""

docker_ps_output=$(docker ps --format "{{.Names}} {{.Ports}}!!!")

IFS='!!!'

for line in $docker_ps_output
do
  line=$(echo "$line" | xargs)
  if [ "$line" == "" ]; then
    continue
  fi

  service_name=$(echo "$line" | cut -d" " -f1)
  # Example: 0.0.0.0:18001->80/tcp,
  # First cut gets the Example
  # Then the remove the 0.0.0.0
  # Remove everything behind the port
  # And filter out anything left that is not a number
  port=$(echo "$line" | cut -d" " -f2 | cut -d":" -f2 | cut -d"-" -f1 | grep -Po "\d*")
  if [ "$port" == "" ]; then
    continue
  fi

  options="${options}${service_name} ${port}\n"
done

# Remove trailing line break
options=$(echo "$options" | tr -d '\n')

theme=${1:-$HOME/.config/rofi/run.rasi}
selection=$(echo -e "${options}" | rofi -p "" -dmenu -i -config "$theme")
if [ "$selection" == "" ]; then
  exit
fi
# Open the Browser, can also be chrome/chromeium
port=$(echo "$selection" | cut -d" " -f2)

firefox "localhost:$port"

