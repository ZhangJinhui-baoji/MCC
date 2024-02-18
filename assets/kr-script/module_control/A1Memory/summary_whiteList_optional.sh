json_file="/data/adb/modules/Hc_memory/config/memory.json"

optional_value=$(awk -F'[:,]' '/"whiteList":/,/}/{if(/"optional":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

if [[ "$optional_value" == "true" ]]; then
    echo "已启用"
elif [[ "$optional_value" == "false" ]]; then
    echo "已停用"
else
    echo "未知状态"
fi