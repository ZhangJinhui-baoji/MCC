if [ $switch == 1 ]; then
    sed -i "/^thermal_scene_time=.*/s/thermal_scene_time=.*/thermal_scene_time=$start_time $end_time $temperature_control_gear/" /data/adb/modules/MiuiVariableThermal/config.conf
else
    sed -i "s/^\(thermal_scene_time=\).*$/\10 0 $temperature_control_gear/" /data/adb/modules/MiuiVariableThermal/config.conf
fi