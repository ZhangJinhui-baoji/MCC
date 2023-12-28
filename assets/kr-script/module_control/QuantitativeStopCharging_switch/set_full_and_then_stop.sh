if [[ ${state} -eq 0 ]]; then
  sed -i 's/\(charge_full=\).*/\10/' /data/adb/modules/QuantitativeStopCharging_switch/config.conf
else
  sed -i 's/\(charge_full=\).*/\11/' /data/adb/modules/QuantitativeStopCharging_switch/config.conf
fi