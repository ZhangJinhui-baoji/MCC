json_file="/data/adb/modules/Hc_memory/config/memory.json"

__android_log_print_value=$(awk -F'[:,]' '/"hookFunc":/,/}/{if(/"__android_log_print":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

if [[ "$__android_log_print_value" == "true" ]]; then
    echo "已启用"
elif [[ "$__android_log_print_value" == "false" ]]; then
    echo "已停用"
else
    echo "未知状态"
fi