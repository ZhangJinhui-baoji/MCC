file="/data/adb/modules/QuantitativeStopCharging_switch/config.conf"
search_term="power_start"
content=$(awk -F '=' -v term="$search_term" '$1 ~ "^"term"$" {sub(/"/, "", $2); gsub(/ *$/, "", $2); print $2}' "$file")

if [ "$content" = "110" ]; then
  echo "0"
else
  echo "1"
fi