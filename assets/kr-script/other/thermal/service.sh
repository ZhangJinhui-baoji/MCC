rm /data/thermal/config/*
rm /data/vendor/thermal/*

p=$(getprop vendor.sys.thermal.data.path)
if [[ "$p" != "" ]]; then
  rm $p/config/*
fi
