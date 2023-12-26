#!/bin/bash

cur_powermode=$(cat /dev/fas_rs/mode)

case "$cur_powermode" in
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