json_file="/data/adb/modules/Hc_memory/config/memory.json"

enable_value=$(awk -F'[:,]' '/"memThreshold":/,/}/{if(/"enable":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

if [[ "$enable_value" == "true" ]]; then
    echo "1"
elif [[ "$enable_value" == "false" ]]; then
    echo "0"
fi