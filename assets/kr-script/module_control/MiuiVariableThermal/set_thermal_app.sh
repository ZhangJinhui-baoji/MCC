if [[ ${state} -eq 0 ]]; then
  sed -i 's/\(thermal_app=\).*/\10/' /data/adb/modules/MiuiVariableThermal/config.conf
else
  sed -i 's/\(thermal_app=\).*/\11/' /data/adb/modules/MiuiVariableThermal/config.conf
fi