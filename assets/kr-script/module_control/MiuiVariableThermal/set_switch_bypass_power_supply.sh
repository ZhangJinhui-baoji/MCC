if [[ ${state} -eq 0 ]]; then
rm -f "/data/adb/modules/MiuiVariableThermal/on_bypass"
else
touch "/data/adb/modules/MiuiVariableThermal/on_bypass"
fi