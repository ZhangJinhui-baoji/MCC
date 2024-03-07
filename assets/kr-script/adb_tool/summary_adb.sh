adb devices | sed -e 's/device$/ 设备已连接/g' -e 's/offline$/ 设备已离线/g' -e 's/unauthorized$/ 没有允许授权USB调试/g'
    Number=`adb devices | grep -v -i 'List of .*' | wc -l`
    if [[ "$Number" -gt 2 ]]; then
        echo "$a"
    fi
echo
        kill -2 $$