json_file="/data/adb/modules/Hc_memory/config/memory.json"

kill_value=$(awk -F'[:,]' '/"hookFunc":/,/}/{if(/"kill":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

if [[ "$kill_value" == "true" ]]; then
    echo "1"
elif [[ "$kill_value" == "false" ]]; then
    echo "0"
fi