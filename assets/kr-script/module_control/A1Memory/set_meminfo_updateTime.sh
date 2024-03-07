json_file="/data/adb/modules/Hc_memory/config/memory.json"

updateTime_value=$(awk -F'[:,]' '/"meminfo":/,/}/{if(/"updateTime":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

sed -i '/"meminfo": {/,/},/s/"updateTime": '"$updateTime_value"'/\"updateTime\": '"$updateTime"'/' "$json_file"