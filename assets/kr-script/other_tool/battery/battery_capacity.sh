#查看出厂设计容量
cc=$(cat /sys/class/power_supply/battery/charge_full_design)
charge_full_design=$(($cc / 1000))
#查看当前电池容量
dc=$(cat /sys/class/power_supply/battery/charge_full)
charge_full=$(($dc / 1000))
#查看电池循环次数
xh=$(cat /sys/class/power_supply/battery/cycle_count)
#计算剩余容量百分比
bfb=$(printf "%d" $((${dc}*100/${cc})))
echo "出厂设计容量为 ${charge_full_design}mAh"
echo "当前电池容量为 ${charge_full}mAh"
echo "电池循环次数为 $xh次"
echo "剩余容量百分比为 $bfb%"

