if [[ `settings get system edge_size` != '' ]]; then
  v=$(getprop ro.miui.ui.version.name)
  if [[ "$v" == "V120" || "$v" == "V125" || "$v" == "V130" ]]; then
    echo 1
  else
    echo 0
  fi
else
  echo 0
fi
