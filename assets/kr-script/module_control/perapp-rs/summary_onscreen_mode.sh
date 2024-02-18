onscreen_mode=$(awk -F'=' '/^onscreen_mode/ {gsub(/[[:space:]"'\''\r]/, "", $2); print $2}' /sdcard/Android/perapp-rs/config.toml)

case "$onscreen_mode" in
  "powersave")
    echo "省电模式"
    ;;
  "balance")
    echo "均衡模式"
    ;;
  "performance")
    echo "性能模式"
    ;;
  "fast")
    echo "极速模式"
    ;;
  *)
    echo "未知模式"
    ;;
esac