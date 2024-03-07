offscreen_mode=$(awk -F'=' '/^offscreen_mode/ {gsub(/[[:space:]"'\''\r]/, "", $2); print $2}' /sdcard/Android/perapp-rs/config.toml)

case "$offscreen_mode" in
  "powersave")
    echo "powersave"
    ;;
  "balance")
    echo "balance"
    ;;
  "performance")
    echo "performance"
    ;;
  "fast")
    echo "fast"
    ;;
esac