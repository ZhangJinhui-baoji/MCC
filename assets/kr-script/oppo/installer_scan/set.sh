#!/system/bin/sh

pm_cmd=""
if [[ "$state" = "1" ]]; then
    pm_cmd="install-existing"
    echo '√√  启用  应用安全扫描'
else
    pm_cmd="uninstall"
    echo '××  停用  应用安全扫描'
fi

echo ''
echo ''

pm $pm_cmd --user 0 com.oplus.appdetail 2> /dev/null

