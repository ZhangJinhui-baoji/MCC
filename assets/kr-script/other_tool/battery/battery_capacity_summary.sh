#查看当前电池容量
dc=$(cat /sys/class/power_supply/battery/charge_full)
charge_full=$(($dc / 1000))
echo "剩余容量 ${charge_full}mAh"