port="$port"

if [[ ! "$switch" = "1" ]]
then
    setprop service.adb.tcp.port -1
    stop adbd
    killall -9 adbd 2>/dev/null
    start adbd
    echo '远程调试服务已停止'
    setprop service.adb.tcp.port ""
    return 0
fi

setprop service.adb.tcp.port $port;
stop adbd;
killall -9 adbd 2>/dev/null
sleep 1;
start adbd;

ip=`ifconfig wlan0 | grep "inet addr" | awk '{ print $2}' | awk -F: '{print $2}'` 2>/dev/null
if [[ ! -n "$ip" ]]
then
    ip=`ifconfig eth0 | grep "inet addr" | awk '{ print $2}' | awk -F: '{print $2}'` 2>/dev/null
fi

echo "在连接了和手机相同网络(局域网)的电脑上"
echo '通过下面的命令'
echo ''

if [[ -n "$ip" ]]
then
    echo "adb connect $ip:$port"
else
    echo "adb connect 手机IP:$port"
fi

echo '来连接手机'

echo '如果设备处于同一局域网且IP无误，依然无法连接'
echo '可尝试保持网络调试开启状态下断开电脑、手机的WiFi重连再试'
