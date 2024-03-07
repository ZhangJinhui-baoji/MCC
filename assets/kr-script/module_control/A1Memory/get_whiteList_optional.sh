json_file="/data/adb/modules/Hc_memory/config/memory.json"

optional_value=$(awk -F'[:,]' '/"whiteList":/,/}/{if(/"optional":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

if [[ "$optional_value" == "true" ]]; then
    echo "1"
elif [[ "$optional_value" == "false" ]]; then
    echo "0"
fi