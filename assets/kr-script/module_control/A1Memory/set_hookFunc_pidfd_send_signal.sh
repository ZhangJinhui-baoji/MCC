json_file="/data/adb/modules/Hc_memory/config/memory.json"

pidfd_send_signal_value=$(awk -F'[:,]' '/"hookFunc":/,/}/{if(/"pidfd_send_signal":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

if [[ "${state}" == 1 ]]; then
    new_value="true"
    echo "已将 pidfd_send_signal 修改为 true"
elif [[ "${state}" == 0 ]]; then
    new_value="false"
    echo "已将 pidfd_send_signal 修改为 false"
else
    echo "未知的状态"
    exit 1
fi

sed -i '/"hookFunc": {/,/},/s/"pidfd_send_signal": '"$pidfd_send_signal_value"'/\"pidfd_send_signal\": '"$new_value"'/' "$json_file"