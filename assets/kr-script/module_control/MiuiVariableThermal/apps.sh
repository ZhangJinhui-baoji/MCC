apps=$(echo "$apps" | tr '\n' '|' | sed 's/|$//')
sed -i "s/^app_list=.*/app_list=${apps}/" /data/adb/modules/MiuiVariableThermal/config.conf