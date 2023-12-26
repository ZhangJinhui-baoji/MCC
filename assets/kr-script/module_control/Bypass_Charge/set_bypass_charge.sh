file_path="/data/adb/modules/Bypass_Charge/system.prop"

if [[ ${state} == 0 ]]; then
  sed -i "/^suto.bypass_charge=/s/.*/suto.bypass_charge=N/" "$file_path"
elif [[ ${state} == 1 ]]; then
  sed -i "/^suto.bypass_charge=/s/.*/suto.bypass_charge=Y/" "$file_path"
fi