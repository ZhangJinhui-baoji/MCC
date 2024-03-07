if [[ ${state} -eq 0 ]]; then
  sed -i 's/\(global_switch=\).*/\10/' /data/adb/modules/MiuiVariableThermal/config.conf
else
  sed -i 's/\(global_switch=\).*/\11/' /data/adb/modules/MiuiVariableThermal/config.conf
fi