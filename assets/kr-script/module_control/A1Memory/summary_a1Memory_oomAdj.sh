json_file="/data/adb/modules/Hc_memory/config/memory.json"

oomAdj_value=$(awk -F'[:,]' '/"a1Memory":/,/}/{if(/"oomAdj":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

    echo "$oomAdj_value"