json_file="/data/adb/modules/Hc_memory/config/memory.json"

smart_value=$(awk -F'[:,]' '/"whiteList":/,/}/{if(/"smart":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

if [[ "$smart_value" == "true" ]]; then
    echo "已启用"
elif [[ "$smart_value" == "false" ]]; then
    echo "已停用"
else
    echo "未知状态"
fi