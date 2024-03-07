awk -F'[ =]+' '/^thermal_scene_time=/ { 
    if ($2 == 0 && $3 == 0) {
        printf("关闭\n");
    } else if ($4 == 0) {
        printf("时间段：%s点~%s点  档位：零档\n", $2, $3);
    } else if ($4 == 1) {
        printf("时间段：%s点~%s点  档位：一档\n", $2, $3);
    } else if ($4 == 2) {
        printf("时间段：%s点~%s点  档位：二档\n", $2, $3);
    } else if ($4 == 3) {
        printf("时间段：%s点~%s点  档位：三档\n", $2, $3);
    } else if ($4 == 4) {
        printf("时间段：%s点~%s点  档位：四档\n", $2, $3);
    } else if ($4 == 5) {
        printf("时间段：%s点~%s点  档位：五档\n", $2, $3);
    }
}' /data/adb/modules/MiuiVariableThermal/config.conf