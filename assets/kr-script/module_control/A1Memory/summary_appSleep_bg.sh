json_file="/data/adb/modules/Hc_memory/config/memory.json"

bg_value=$(awk -F'[:,]' '/"appSleep":/,/}/{if(/"bg":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

if [[ "$bg_value" == "ignore" ]]; then
    echo "忽略唤醒请求和拉起应用请求"
elif [[ "$bg_value" == "allow" ]]; then
    echo "允许唤醒请求和拉起应用请求"
elif [[ "$bg_value" == "deny" ]]; then
    echo "拒绝唤醒请求和拉起应用请求"
fi