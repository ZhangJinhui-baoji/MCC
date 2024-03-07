awk -F'[ =]+' '/^thermal_scene_time=/ { 
    if ($2 == 0 && $3 == 0) {
        printf("0");
    } else {
        printf("1");
    }
}' /data/adb/modules/MiuiVariableThermal/config.conf