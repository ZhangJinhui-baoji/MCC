baseband=$(getprop ro.baseband)
if [[ "$baseband" == "msm" || "$baseband" == "mdm" ]]; then
  echo 1
else
  echo 0
fi