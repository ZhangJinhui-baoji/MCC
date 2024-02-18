fps=$(grep '^fps=' /data/adb/modules/MiuiVariableThermal/config.conf | awk -F'=' '{print $2}')

brightness_level=$(echo $fps | awk '{print $1}')
standby_level=$(echo $fps | awk '{print $2}')

if [[ $brightness_level -eq 0 ]]; then
  if [[ $standby_level -eq 0 ]]; then
    echo "游戏场景: 关闭 普通场景: 关闭"
  else
    echo "游戏场景: 关闭 普通场景: $standby_level"
  fi
elif [[ $standby_level -eq 0 ]]; then
  echo "游戏场景: $brightness_level 普通场景: 关闭"
else
  echo "游戏场景: $brightness_level 普通场景: $standby_level"
fi