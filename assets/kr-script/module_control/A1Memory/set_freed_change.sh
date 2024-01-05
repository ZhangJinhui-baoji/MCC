json_file="/data/adb/modules/Hc_memory/config/memory.json"

change_value=$(awk -F'[:,]' '/"freed":/,/}/{if(/"change":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

sed -i '/"freed": {/,/},/s/"change": '"$change_value"'/\"change\": '"$change"'/' "$json_file"