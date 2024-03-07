if [ $switch == 1 ]; then
    sed -i "/^bypass_level_time=.*/s/bypass_level_time=.*/bypass_level_time=$start_time $end_time/" /data/adb/modules/MiuiVariableThermal/config.conf
else
    sed -i "s/^\(bypass_level_time=\).*$/\10 0/" /data/adb/modules/MiuiVariableThermal/config.conf
fi