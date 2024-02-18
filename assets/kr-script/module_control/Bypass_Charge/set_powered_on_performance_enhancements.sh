file_path="/data/adb/modules/Bypass_Charge/system.prop"

if [[ ${state} == 0 ]]; then
  sed -i "/^suto.powered_on_performance_enhancements=/s/.*/suto.powered_on_performance_enhancements=N/" "$file_path"
elif [[ ${state} == 1 ]]; then
  sed -i "/^suto.powered_on_performance_enhancements=/s/.*/suto.powered_on_performance_enhancements=Y/" "$file_path"
fi