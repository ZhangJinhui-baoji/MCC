file_path="/data/adb/modules/Bypass_Charge/system.prop"

if [[ ${state} == 0 ]]; then
  sed -i "/^suto.screen_on_bypass_charge=/s/.*/suto.screen_on_bypass_charge=N/" "$file_path"
elif [[ ${state} == 1 ]]; then
  sed -i "/^suto.screen_on_bypass_charge=/s/.*/suto.screen_on_bypass_charge=Y/" "$file_path"
fi