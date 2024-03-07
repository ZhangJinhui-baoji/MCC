json_file="/data/adb/modules/Hc_memory/config/memory.json"

bg_value=$(awk -F'[:,]' '/"appSleep":/,/}/{if(/"bg":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

sed -i '/"appSleep": {/,/},/s/"bg": '"\"$bg_value\""'/\"bg\": '"\"$bg\""'/' "$json_file"