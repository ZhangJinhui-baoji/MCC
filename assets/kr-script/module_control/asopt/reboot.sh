if [[ $reboot -eq 1 ]]; then
    echo "即将在5秒后自动重启，开始倒计时……"
    for i in $(seq 1 -1 1); do
        echo $i
        sleep 1
    done
    echo "即将重启"
    reboot
fi