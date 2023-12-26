bypass_supply_temp=$(grep '^bypass_supply_temp=' /data/adb/modules/MiuiVariableThermal/config.conf | awk -F'=' '{print $2}')

opening_temperature=$(echo $bypass_supply_temp | awk '{print $1}')
closing_temperature=$(echo $bypass_supply_temp | awk '{print $2}')

echo "开启温度：$opening_temperature 关闭温度：$closing_temperature"