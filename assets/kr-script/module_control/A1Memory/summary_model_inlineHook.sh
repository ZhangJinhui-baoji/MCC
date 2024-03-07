json_file="/data/adb/modules/Hc_memory/config/memory.json"

inlineHook_value=$(awk -F'[:,]' '/"model":/,/}/{if(/"inlineHook":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

    echo "$inlineHook_value"