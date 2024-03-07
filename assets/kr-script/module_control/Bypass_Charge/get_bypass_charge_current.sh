file_path="/data/adb/modules/Bypass_Charge/system.prop"
search_text="suto.bypass_charge_current"
line_number=$(grep -n "$search_text" "$file_path" | cut -d ':' -f 1)
if [ -n "$line_number" ]; then
  line_content=$(sed -n "${line_number}p" "$file_path")
  original_alg=$(echo "$line_content" | sed 's/.*=//')
  echo "$original_alg"
fi