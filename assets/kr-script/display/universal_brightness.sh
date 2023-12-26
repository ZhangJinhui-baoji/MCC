                path=/sys/class/backlight/panel0-backlight/brightness
                chmod 644 $path
                echo $brightness > $path
                if [[ "$lock" == '1' ]]; then
                  chmod 444 $path
                fi