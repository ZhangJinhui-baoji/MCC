offscreen_mode=$(awk -F'=' '/^offscreen_mode/ {gsub(/[[:space:]"'\''\r]/, "", $2); print $2}' /sdcard/Android/perapp-rs/config.toml)

case "$offscreen_mode" in
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