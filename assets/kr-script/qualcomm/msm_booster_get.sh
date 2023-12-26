#!/system/bin/sh

input=./kr-script/common/empty
output=/system/vendor/etc/perf/perfboostsconfig.xml

for dir in $(ls /data/adb/modules/ | grep -v scene_systemless)
do
  if [[ ! -e /data/adb/modules/$dir/disable ]]; then
    if [[ -e /data/adb/modules/$dir/$output ]]; then
      echo '检测到其它模块覆盖了perfboostsconfig.xml' 1>&2
      echo '位于: ' /data/adb/modules/$dir/$output 1>&2
      echo '你需要将其删除该文件才能在Scene中进行该操作！' 1>&2
    fi
  fi
done

source ./kr-script/common/magisk_replace.sh

file_mixture_hooked "$input" "$output"
result="$?"

if [[ "$result" = 1 ]]
then
  echo 0
else
  echo 1
fi