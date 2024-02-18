file="/data/adb/modules/QuantitativeStopCharging_switch/config.conf"
replacement="temperature_switch_start=${restore_charging_temperature}"
sed -i "/^temperature_switch_start=/s/.*/$replacement/" "$file"