json_file="/data/adb/modules/Hc_memory/config/memory.json"

kill_value=$(awk -F'[:,]' '/"hookFunc":/,/}/{if(/"kill":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

if [[ "${state}" == 1 ]]; then
    new_value="true"
    echo "已将 kill 修改为 true"
elif [[ "${state}" == 0 ]]; then
    new_value="false"
    echo "已将 kill 修改为 false"
else
    echo "未知的状态"
    exit 1
fi

sed -i '/"hookFunc": {/,/},/s/"kill": '"$kill_value"'/\"kill\": '"$new_value"'/' "$json_file"