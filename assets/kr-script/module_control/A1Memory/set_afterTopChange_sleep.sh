json_file="/data/adb/modules/Hc_memory/config/memory.json"

sleep_value=$(awk -F'[:,]' '/"afterTopChange":/,/}/{if(/"sleep":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

sed -i '/"afterTopChange": {/,/},/s/"sleep": '"$sleep_value"'/\"sleep\": '"$sleep"'/' "$json_file"