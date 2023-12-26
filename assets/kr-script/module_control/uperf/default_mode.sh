#!/bin/bash

cur_powermode=$(cat $uperf_path/cur_powermode.txt)

case "$cur_powermode" in
  auto)
    echo "自动模式"
    ;;
  powersave)
    echo "省电模式"
    ;;
  balance)
    echo "均衡模式"
    ;;
  performance)
    echo "性能模式"
    ;;
  fast)
    echo "极速模式"
    ;;
  *)
    echo "未知模式"
    ;;
esac