json_file="/data/adb/modules/Hc_memory/config/memory.json"

level_value=$(awk -F'[:,]' '/"log":/,/}/{if(/"level":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

sed -i '/"log": {/,/},/s/"level": '"\"$level_value\""'/\"level\": '"\"$level\""'/' "$json_file"