json_file="/data/adb/modules/Hc_memory/config/memory.json"

top_value=$(awk -F'[:,]' '/"appSleep":/,/}/{if(/"top":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

sed -i '/"appSleep": {/,/},/s/"top": '"\"$top_value\""'/\"top\": '"\"$top\""'/' "$json_file"