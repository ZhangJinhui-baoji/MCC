                path=/sys/devices/platform/panel_drv_0/backlight/panel/brightness
                chmod 644 $path
                echo $brightness > $path
                if [[ "$lock" == '1' ]]; then
                  chmod 444 $path
                fi