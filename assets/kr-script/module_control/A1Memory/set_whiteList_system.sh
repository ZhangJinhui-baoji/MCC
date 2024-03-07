json_file="/data/adb/modules/Hc_memory/config/memory.json"

system_value=$(awk -F'[:,]' '/"whiteList":/,/}/{if(/"system":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

if [[ "${state}" == 1 ]]; then
    new_value="true"
    echo "已将 system 修改为 true"
elif [[ "${state}" == 0 ]]; then
    new_value="false"
    echo "已将 system 修改为 false"
else
    echo "未知的状态"
    exit 1
fi

sed -i '/"whiteList": {/,/},/s/"system": '"$system_value"'/\"system\": '"$new_value"'/' "$json_file"