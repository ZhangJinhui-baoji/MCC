json_file="/data/adb/modules/Hc_memory/config/memory.json"

level_value=$(awk -F'[:,]' '/"log":/,/}/{if(/"level":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

    echo "$level_value"