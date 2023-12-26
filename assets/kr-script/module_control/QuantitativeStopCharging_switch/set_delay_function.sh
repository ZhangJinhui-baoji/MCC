file="/data/adb/modules/QuantitativeStopCharging_switch/config.conf"
replacement="power_stop_time=${delay_function}"
sed -i "/^power_stop_time=/s/.*/$replacement/" "$file"