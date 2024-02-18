file="/data/adb/modules/MiuiVariableThermal/config.conf"
search_term="current_max"
content=$(awk -F '=' -v term="$search_term" '$1 ~ "^"term"$" {sub(/"/, "", $2); gsub(/ *$/, "", $2); print $2}' "$file")

if [[ "$content" -eq 0 ]]; then
    echo "关闭"
else
    echo "$content"
fi