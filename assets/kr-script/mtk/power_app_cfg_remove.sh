if [[ -d /data/adb/modules/extreme_gt ]]; then
  echo '你已安装 [Realme Extreme GT] 模块，无需再操作此功能！'
  exit 0
fi

mkdir -p $MAGISK_PATH/system/vendor/etc
echo '<?xml version="1.0" encoding="UTF-8"?>
<WHITELIST>
</WHITELIST>' > $MAGISK_PATH/system/vendor/etc/power_app_cfg.xml

echo '你需要重启手机，使修改生效'
