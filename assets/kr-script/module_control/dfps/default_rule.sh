if [ -z "$default_rule" ]; then
    echo '无效的操作' 1>&2
else
    awk -v text="$default_rule" '/^\*/ {sub(/\*.*/, "* " text)} 1' /sdcard/Android/yc/dfps/dfps.txt > temp_file
    mv temp_file /sdcard/Android/yc/dfps/dfps.txt
    echo '好了~'
fi