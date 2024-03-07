while IFS= read -r line
do
  if echo "$line" | grep -q "Performance governor"; then
    if [ "${line#*=}" = " true" ]; then
      echo "1"
    else
      echo "0"
    fi
    break
  fi
done < /data/feas.conf