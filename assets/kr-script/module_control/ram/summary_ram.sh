script_name="/data/adb/modules/ram/ram.sh"
lastID=$(pgrep -f "$script_name")
if [ "$lastID" != "" ]; then
    echo -e "运行状态：正在运行中…"

else
    echo -e "运行状态：未运行"
    
fi