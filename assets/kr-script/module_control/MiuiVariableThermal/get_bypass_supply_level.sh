file="/data/adb/modules/MiuiVariableThermal/config.conf"
search_term="bypass_supply_level"
content=$(awk -F '=' -v term="$search_term" '$1 ~ "^"term"$" {sub(/"/, "", $2); gsub(/ *$/, "", $2); print $2}' "$file")
echo "$content"