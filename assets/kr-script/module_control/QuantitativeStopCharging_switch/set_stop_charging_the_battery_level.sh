file="/data/adb/modules/QuantitativeStopCharging_switch/config.conf"
replacement="power_stop=${stop_charging_the_battery_level}"

if [ "$switch" -eq 0 ]; then
  sed -i "/^power_stop=/s/.*/power_stop=110/" "$file"
else
  sed -i "/^power_stop=/s/.*/$replacement/" "$file"
fi