while IFS= read -r line
do
  if echo "$line" | grep -q "current_txt"; then
    if [ "${line#*=}" = "1" ]; then
      echo "1"
    else
      echo "0"
    fi
    break
  fi
done < /data/adb/modules/MiuiVariableThermal/config.conf