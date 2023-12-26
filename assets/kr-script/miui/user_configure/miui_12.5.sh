varsion=$(getprop ro.miui.ui.version.name)
if [[ "$varsion" == "V125" ]] || [[ "$varsion" == "V130" ]]; then
  echo 1
else
  echo 0
fi