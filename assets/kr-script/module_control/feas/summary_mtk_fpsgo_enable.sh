file="/sys/kernel/fpsgo/common/fpsgo_enable"

if [ -e "$file" ]; then
    content=$(cat "$file")
    if [ "$content" -eq 1 ]; then
        echo "已开启"
    elif [ "$content" -eq 0 ]; then
        echo "已关闭"
    else
        echo "未知状态"
    fi
else
    echo "您的设备可能不支持"
fi