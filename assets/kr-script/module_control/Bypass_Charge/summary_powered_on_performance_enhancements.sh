file="/data/adb/modules/Bypass_Charge/system.prop"
search_term="suto.powered_on_performance_enhancements"
content=$(awk -F '=' -v term="$search_term" '$1 ~ "^"term"$" {sub(/"/, "", $2); gsub(/ *$/, "", $2); print $2}' "$file")
echo "$content"