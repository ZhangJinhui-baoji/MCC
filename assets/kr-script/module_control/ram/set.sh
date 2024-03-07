MODDIR=${0%/*}
A=`am stack list | awk '/taskId/&&!/unknown/{print$2}'|awk -F '/' '{print $1}'`
echo "$A"

# 获取总内存
mem_total=$(cat /proc/meminfo | grep "MemTotal" | awk '{print $2}')
mem_total_gb=$(echo "scale=2;$mem_total/1024/1024" | bc)

# 获取空闲内存
mem_free=$(cat /proc/meminfo | grep "MemFree" | awk '{print $2}')
mem_free_gb=$(echo "scale=2;$mem_free/1024" | bc)

# 获取程序可用内存
mem_available=$(cat /proc/meminfo | grep "MemAvailable" | awk '{print $2}')
mem_available_gb=$(echo "scale=2;$mem_available/1024/1024" | bc)

# 计算可用内存百分比
mem_percent=$(echo "scale=2;$mem_available/$mem_total*100" | bc)

echo ""
echo "总内存: ${mem_total_gb}Gb"
echo "空闲内存: ${mem_free_gb}Mb"
echo "可用内存百分比: ${mem_available_gb}Gb (${mem_percent}%)"

#注意，上述代码中的单位为GB，使用bc计算时需要用scale=2设置精度为2位小数。另外，在Linux系统中，一般将可用内存计算为“可用物理内存+缓存+已用交换空间-最小空闲内存”，而不是只计算“可用物理内存”，这也是该脚本中使用“MemAvailable”而不是“MemFree”的原因。
echo ""
script_name="ram.sh"
lastID=$(pgrep -f "$script_name")
if [ "$lastID" != "" ]; then
    echo -e "运行状态：正在运行……"

else
    echo -e "运行状态：没有运行……"
    
fi