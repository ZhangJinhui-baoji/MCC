if [[ ${state} -eq 0 ]]; then
touch "/data/adb/modules/QuantitativeStopCharging_switch/off_qsc"
else
rm -f "/data/adb/modules/QuantitativeStopCharging_switch/off_qsc"
fi