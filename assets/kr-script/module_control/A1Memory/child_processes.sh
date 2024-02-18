list_file="/sdcard/Android/HChai/HC_memory/名单列表.conf"

if [ -z "$app" ]; then
    echo "请选择正在运行的应用后再点击确定"
    exit
fi

child_processes=$(ps -e | grep "$app" | awk '{print $NF}')

if [ -n "$child_processes" ]; then
    while IFS= read -r child_processes_list; do
        existing_line=$(grep "^KILL $child_processes_list$" "$list_file")

        if [ -n "$existing_line" ]; then
            echo "已存在：$existing_line"
        else
            echo "KILL $child_processes_list 已添加"
            awk '{print} /{/{count++} count==2 && !inserted{print "KILL '"$child_processes_list"'"; inserted=1} ' "$list_file" > tmpfile && mv tmpfile "$list_file"
        fi
    done <<< "$child_processes"

    echo "该应用所有正在运行的进程已添加至名单列表，请使用编辑功能进行修改，如不修改，则会kill目前所有正在运行的进程，新添加的进程一般都在名单最顶端"
    else
    echo "此应用目前尚未发现正在运行的进程"
fi