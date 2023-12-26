if [[ ${state} -eq 0 ]]; then
  sed -i 's/\(temperature_switch=\).*/\10/' /data/adb/modules/QuantitativeStopCharging_switch/config.conf
else
  sed -i 's/\(temperature_switch=\).*/\11/' /data/adb/modules/QuantitativeStopCharging_switch/config.conf
fi