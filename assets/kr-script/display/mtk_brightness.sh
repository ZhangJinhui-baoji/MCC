                path=/sys/devices/platform/soc/soc:mtk_leds/leds/lcd-backlight/brightness
                chmod 644 $path
                echo $brightness > $path
                if [[ "$lock" == '1' ]]; then
                  chmod 444 $path
                fi