json_file="/data/adb/modules/Hc_memory/config/memory.json"

enable_value=$(awk -F'[:,]' '/"crazyKill":/,/}/{if(/"enable":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

if [[ "${state}" == 1 ]]; then
    new_value="true"
    echo "已将 enable 修改为 true"
elif [[ "${state}" == 0 ]]; then
    new_value="false"
    echo "已将 enable 修改为 false"
else
    echo "未知的状态"
    exit 1
fi

sed -i '/"crazyKill": {/,/},/s/"enable": '"$enable_value"'/\"enable\": '"$new_value"'/' "$json_file"