onscreen_mode=$(awk -F'=' '/^onscreen_mode/ {gsub(/[[:space:]"'\''\r]/, "", $2); print $2}' /sdcard/Android/perapp-rs/config.toml)

case "$onscreen_mode" in
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