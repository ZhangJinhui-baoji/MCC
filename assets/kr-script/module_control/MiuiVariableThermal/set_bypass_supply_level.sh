file="/data/adb/modules/MiuiVariableThermal/config.conf"
replacement="bypass_supply_level=${bypass_supply_level}"

if [ "$switch" -eq 0 ]; then
  sed -i "/^bypass_supply_level=/s/.*/bypass_supply_level=110/" "$file"
else
  sed -i "/^bypass_supply_level=/s/.*/$replacement/" "$file"
fi