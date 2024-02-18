if [[ ${state} -eq 0 ]]; then
  sed -i 's/\(power_reset=\).*/\10/' /data/adb/modules/QuantitativeStopCharging_switch/config.conf
else
  sed -i 's/\(power_reset=\).*/\11/' /data/adb/modules/QuantitativeStopCharging_switch/config.conf
fi