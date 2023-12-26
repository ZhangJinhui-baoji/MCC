while IFS= read -r line || [[ -n $line ]]; do
  line="$(echo "$line" | tr -d '\r')"
  if [[ $line == -* ]]; then
    mode=${line:2}
    case "$mode" in
      powersave)
        echo "省电模式"
        ;;
      balance)
        echo "均衡模式"
        ;;
      performance)
        echo "性能模式"
        ;;
      fast)
        echo "极速模式"
        ;;
      *)
        echo "未知模式"
        ;;
    esac
  fi
done < $uperf_path/perapp_powermode.txt