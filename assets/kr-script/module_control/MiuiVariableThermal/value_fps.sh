fps=$(grep '^fps=' /data/adb/modules/MiuiVariableThermal/config.conf | awk -F'=' '{print $2}')

brightness_level=$(echo $fps | awk '{print $1}')
standby_level=$(echo $fps | awk '{print $2}')

if [[ $brightness_level -eq 0 && $standby_level -eq 0 ]]; then
  echo "0"
else
  echo "1"
fi