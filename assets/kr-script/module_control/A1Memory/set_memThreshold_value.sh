json_file="/data/adb/modules/Hc_memory/config/memory.json"

value_value=$(awk -F'[:,]' '/"memThreshold":/,/}/{if(/"value":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

sed -i '/"memThreshold": {/,/},/s/"value": '"$value_value"'/\"value\": '"$value"'/' "$json_file"