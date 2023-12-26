#!/system/bin/sh

brightness_file="/sys/devices/platform/soc/soc:mtk_leds/leds/lcd-backlight/max_brightness"

if [ -e "$brightness_file" ]; then
  echo 1
else
  echo 0
fi