thermal_scene=$(grep '^thermal_scene=' /data/adb/modules/MiuiVariableThermal/config.conf | awk -F'=' '{print $2}')

brightness_level=$(echo $thermal_scene | awk '{print $1}')
standby_level=$(echo $thermal_scene | awk '{print $2}')

case $brightness_level in
    0)
        echo "亮屏档位：零档-无限制"
        ;;
    1)
        echo "亮屏档位：一档-无限制"
        ;;
    2)
        echo "亮屏档位：二档-无限制"
        ;;
    3)
        echo "亮屏档位：三档-无限制"
        ;;
    4)
        echo "亮屏档位：四档-无限制"
        ;;
    5)
        echo "亮屏档位：五档-无限制"
        ;;
    *)
        echo "未知亮屏档位"
        ;;
esac

case $standby_level in
    0)
        echo "息屏档位：零档-无限制"
        ;;
    1)
        echo "息屏档位：一档-无限制"
        ;;
    2)
        echo "息屏档位：二档-无限制"
        ;;
    3)
        echo "息屏档位：三档-无限制"
        ;;
    4)
        echo "息屏档位：四档-无限制"
        ;;
    5)
        echo "息屏档位：五档-无限制"
        ;;
    *)
        echo "未知息屏档位"
        ;;
esac