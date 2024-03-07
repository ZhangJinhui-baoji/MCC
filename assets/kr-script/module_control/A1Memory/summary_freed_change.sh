json_file="/data/adb/modules/Hc_memory/config/memory.json"

change_value=$(awk -F'[:,]' '/"freed":/,/}/{if(/"change":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

echo "$change_value"