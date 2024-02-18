json_file="/data/adb/modules/Hc_memory/config/memory.json"

idle_value=$(awk -F'[:,]' '/"appSleep":/,/}/{if(/"idle":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

if [[ "$idle_value" == "all" ]]; then
    echo "全部用户"
elif [[ "$idle_value" == "current" ]]; then
    echo "当前用户"
fi