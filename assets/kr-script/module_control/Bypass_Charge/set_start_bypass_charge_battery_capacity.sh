file_path="/data/adb/modules/Bypass_Charge/system.prop"
search_text="suto.start_bypass_charge_battery_capacity"
line_number=$(grep -n "$search_text" "$file_path" | cut -d ':' -f 1)
if [ -n "$line_number" ]; then
  line_content=$(sed -n "${line_number}p" "$file_path")
  original_alg=$(echo "$line_content" | sed 's/.*=//')
  new_line_content=$(echo "$line_content" | sed "s/$original_alg/$start_bypass_charge_battery_capacity/")
  sed -i "${line_number}s/.*/$new_line_content/" "$file_path"
fi