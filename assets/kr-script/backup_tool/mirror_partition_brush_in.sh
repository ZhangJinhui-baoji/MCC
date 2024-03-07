reboot_system() {
if [[ $reboot_system -eq 1 ]]; then
    echo "即将在5秒后自动重启，开始倒计时……"
    for i in $(seq 5 -1 1); do
        echo $i
        sleep 1
    done
    echo "即将重启"
    reboot
fi
}

reboot_recovery() {
if [[ $reboot_recovery -eq 1 ]]; then
    echo "即将在5秒后自动重启，开始倒计时……"
    for i in $(seq 5 -1 1); do
        echo $i
        sleep 1
    done
    echo "即将重启"
    reboot recovery
fi
}

[[ -z $img ]] && abort "！选择分区哈"
IFS=$'\n'
e=${img##*/}
echo "- 您当前选择了$e分区"
echo "- 刷入文件路径：$brush_in"
echo "- 检测刷入镜像文件是否存在"
[[ ! -L "$img" ]] && abort "！$e分区不存在无法刷入"
    if [[ -f "$brush_in" ]]; then
        echo "- 开始刷写$e分区"
        dd if="$brush_in" of="$img" && reboot_system && reboot_recovery
    else
        abort "！$brush_in刷入文件不存在无法刷写到$e分区"
    fi
    echo "- 完成"
    sleep 2