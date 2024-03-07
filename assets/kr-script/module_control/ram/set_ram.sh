MODDIR=/data/adb/modules/ram
script_name="/data/adb/modules/ram/ram.sh"

if [[ ${state} == 1 ]]; then
    lastID=$(pgrep -f "$script_name")
    if [ "$lastID" != "" ]; then
        kill -KILL $lastID
    fi
    nohup $MODDIR/ram.sh > /dev/null 2>&1 &
elif [[ ${state} == 0 ]]; then
    lastID=$(pgrep -f "$script_name")
    if [ "$lastID" != "" ]; then
        echo "进程 $lastID 已经结束"
        kill -KILL $lastID
    fi

    echo " "
    lastIDD=$(pgrep -f "$script_name")
    if [ "$lastIDD" != "" ]; then
        echo -e "\e[32m正在运行……\n\e[0m"
    else
        echo -e "\e[31m没有运行……\n\e[0m"
    fi
fi