json_file="/data/adb/modules/Hc_memory/config/memory.json"

system_value=$(awk -F'[:,]' '/"whiteList":/,/}/{if(/"system":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

if [[ "$system_value" == "true" ]]; then
    echo "已启用"
elif [[ "$system_value" == "false" ]]; then
    echo "已停用"
else
    echo "未知状态"
fi