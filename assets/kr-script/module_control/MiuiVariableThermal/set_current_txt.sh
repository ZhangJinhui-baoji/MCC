if [[ ${state} -eq 0 ]]; then
  sed -i 's/\(current_txt=\).*/\10/' /data/adb/modules/MiuiVariableThermal/config.conf
else
  sed -i 's/\(current_txt=\).*/\11/' /data/adb/modules/MiuiVariableThermal/config.conf
fi