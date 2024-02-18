json_file="/data/adb/modules/Hc_memory/config/memory.json"

idle_value=$(awk -F'[:,]' '/"appSleep":/,/}/{if(/"idle":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

sed -i '/"appSleep": {/,/},/s/"idle": '"\"$idle_value\""'/\"idle\": '"\"$idle\""'/' "$json_file"