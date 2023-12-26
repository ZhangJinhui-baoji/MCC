bypass_level_time=$(grep '^bypass_level_time=' /data/adb/modules/MiuiVariableThermal/config.conf | awk -F'=' '{print $2}')

start_time=$(echo $bypass_level_time | awk '{print $1}')
end_time=$(echo $bypass_level_time | awk '{print $2}')

if [[ $start_time -eq 0 && $end_time -eq 0 ]]; then
  echo "关闭"
else
  echo "时间段：$start_time点~$end_time点"
fi