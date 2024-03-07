file1="/sys/module/mtk_fpsgo/parameters/perfmgr_enable"
file2="/sys/module/perfmgr_mtk/parameters/perfmgr_enable"
if [[ -f $file2 ]]; then
file1=$file2
fi

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