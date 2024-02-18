json_file="/data/adb/modules/Hc_memory/config/memory.json"

__android_log_print_value=$(awk -F'[:,]' '/"hookFunc":/,/}/{if(/"__android_log_print":/){gsub(/[" ]/, "", $2); print $2}}' "$json_file")

if [[ "${state}" == 1 ]]; then
    new_value="true"
    echo "已将 __android_log_print 修改为 true"
elif [[ "${state}" == 0 ]]; then
    new_value="false"
    echo "已将 __android_log_print 修改为 false"
else
    echo "未知的状态"
    exit 1
fi

sed -i '/"hookFunc": {/,/},/s/"__android_log_print": '"$__android_log_print_value"'/\"__android_log_print\": '"$new_value"'/' "$json_file"