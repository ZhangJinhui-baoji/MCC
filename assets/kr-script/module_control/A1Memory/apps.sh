list_file="/sdcard/Android/HChai/HC_memory/名单列表.conf"
sed -i '/^WHITE/d' $list_file
echo "$apps" | while IFS= read -r app; do
  echo "WHITE '$app'"
  awk '{print} !count && /^{/{print "WHITE '$app'"; count++}' $list_file > tmpfile && mv tmpfile $list_file
done