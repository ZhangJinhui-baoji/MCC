#!/system/bin/sh

ui=$(getprop ro.product.brand.ui | tr '[A-Z]' '[a-z]')
if [[ "$ui" == "realmeui" ]] || [[ "$ui" == "coloros" ]]; then
  echo 1
else
  brand=$(getprop ro.product.brand | tr '[A-Z]' '[a-z]')
  if [[ "$brand" == 'oneplus' ]] || [[ "$brand" == 'oppo' ]]; then
    echo 1
  else
    echo 0
  fi
fi
