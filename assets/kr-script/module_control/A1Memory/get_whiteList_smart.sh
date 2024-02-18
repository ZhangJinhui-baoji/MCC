json_file="/data/adb/modules/Hc_memory/config/memory.json"

smart_value=$(awk -F'[:,]' '/"whiteList":/,/}/{if(/"smart":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

if [[ "$smart_value" == "true" ]]; then
    echo "1"
elif [[ "$smart_value" == "false" ]]; then
    echo "0"
fi