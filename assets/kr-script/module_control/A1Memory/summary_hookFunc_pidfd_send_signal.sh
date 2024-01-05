json_file="/data/adb/modules/Hc_memory/config/memory.json"

pidfd_send_signal_value=$(awk -F'[:,]' '/"hookFunc":/,/}/{if(/"pidfd_send_signal":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

if [[ "$pidfd_send_signal_value" == "true" ]]; then
    echo "已启用"
elif [[ "$pidfd_send_signal_value" == "false" ]]; then
    echo "已停用"
else
    echo "未知状态"
fi