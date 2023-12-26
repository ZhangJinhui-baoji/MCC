file="/data/adb/modules/QuantitativeStopCharging_switch/config.conf"
replacement="temperature_switch_stop=${stop_charging_temperature}"
sed -i "/^temperature_switch_stop=/s/.*/$replacement/" "$file"