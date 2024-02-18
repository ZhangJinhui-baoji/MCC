file="/data/adb/modules/MiuiVariableThermal/config.conf"
replacement="current_max=${current_max}"
if [[ $switch -eq 1 ]]; then
  sed -i "/^current_max=/s/.*/$replacement/" "$file"
else
  sed -i "s/^\(current_max=\).*/\10/" "$file"
fi