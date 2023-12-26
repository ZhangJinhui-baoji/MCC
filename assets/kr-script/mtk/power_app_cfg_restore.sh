if [[ -f $MAGISK_PATH/system/vendor/etc/power_app_cfg.xml ]]
then
  rm -f $MAGISK_PATH/system/vendor/etc/power_app_cfg.xml
  echo '你需要重启手机，使修改生效'
else
  if [[ -d /data/adb/modules/extreme_gt ]]; then
    echo '你已安装 [Realme Extreme GT] 模块，无需再操作此功能！'
    exit 0
  else
    echo '未找到替换的文件，如果你刚刚点过还原了，请重启手机使操作生效'
    echo '如果你是通过其它方式\工具移除的[AppConfig]，Scene无法帮你还原'
  fi
fi