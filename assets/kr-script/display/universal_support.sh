#!/system/bin/sh

brightness_file="/sys/class/backlight/panel0-backlight/brightness"

if [ -e "$brightness_file" ]; then
  echo 1
else
  echo 0
fi