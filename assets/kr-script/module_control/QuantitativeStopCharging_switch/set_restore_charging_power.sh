file="/data/adb/modules/QuantitativeStopCharging_switch/config.conf"
replacement="power_start=${restore_charging_power}"

if [ "$switch" -eq 0 ]; then
  sed -i "/^power_start=/s/.*/power_start=110/" "$file"
else
  sed -i "/^power_start=/s/.*/$replacement/" "$file"
fi