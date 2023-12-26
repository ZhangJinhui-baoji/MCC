universal_brightness="$(cat /sys/class/backlight/panel0-backlight/max_brightness)"
other_brightness="$(cat /sys/devices/platform/panel_drv_0/backlight/panel/max_brightness)"
mtk_brightness="$(cat /sys/devices/platform/soc/soc:mtk_leds/leds/lcd-backlight/max_brightness)"

echo '<?xml version="1.0" encoding="UTF-8" ?>'
echo "    <group>"
echo '        <action shell="hidden" visible="sh ./kr-script/display/universal_support.sh" id="brightness">'
echo "            <title>亮度</title>"
echo "            <desc>强制更改屏幕亮度</desc>"
echo "            <params>"
echo "                <param name=\"brightness\" label=\"亮度\" type=\"seekbar\" max=\"$universal_brightness\" min=\"1\" value-sh=\"cat /sys/class/backlight/panel0-backlight/brightness\" />"
echo "                <param name=\"lock\" label=\"锁定\" type=\"switch\" />"
echo "            </params>"
echo "            <set>sh ./kr-script/display/universal_brightness.sh</set>"
echo "        </action>"
echo "    </group>"

echo "    <group>"
echo '        <action shell="hidden" visible="sh ./kr-script/display/other_support.sh" id="brightness">'
echo "            <title>亮度</title>"
echo "            <desc>强制更改屏幕亮度</desc>"
echo "            <params>"
echo "                <param name=\"brightness\" label=\"亮度\" type=\"seekbar\" max=\"$other_brightness\" min=\"1\" value-sh=\"cat /sys/devices/platform/panel_drv_0/backlight/panel/brightness\" />"
echo "                <param name=\"lock\" label=\"锁定\" type=\"switch\" />"
echo "            </params>"
echo "            <set>sh ./kr-script/display/other_brightness.sh</set>"
echo "        </action>"
echo "    </group>"


echo "    <group>"
echo '        <action shell="hidden" visible="sh ./kr-script/display/mtk_support.sh" id="brightness">'
echo "            <title>亮度</title>"
echo "            <desc>强制更改屏幕亮度</desc>"
echo "            <params>"
echo "                <param name=\"brightness\" label=\"亮度\" type=\"seekbar\" max=\"$mtk_brightness\" min=\"1\" value-sh=\"cat /sys/devices/platform/soc/soc:mtk_leds/leds/lcd-backlight/brightness\" />"
echo "                <param name=\"lock\" label=\"锁定\" type=\"switch\" />"
echo "            </params>"
echo "            <set>sh ./kr-script/display/mtk_brightness.sh</set>"
echo "        </action>"
echo "    </group>"