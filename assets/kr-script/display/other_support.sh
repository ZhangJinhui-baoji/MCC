#!/system/bin/sh

brightness_file="/sys/devices/platform/panel_drv_0/backlight/panel/brightness"

if [ -e "$brightness_file" ]; then
  echo 1
else
  echo 0
fi