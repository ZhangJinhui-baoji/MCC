if pgrep -x "HC_memory" > /dev/null
then
    echo "正在运行中…"
else
    echo "未运行"
fi