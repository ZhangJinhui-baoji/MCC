script_name="/data/adb/modules/ram/ram.sh"
lastID=$(pgrep -f "$script_name")
if [ "$lastID" != "" ]; then
    echo -e "1"

else
    echo -e "0"
    
fi