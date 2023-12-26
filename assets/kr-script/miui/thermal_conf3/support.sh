platform=`getprop ro.board.platform | tr 'A-Z' 'a-z'`
device=$(getprop ro.product.device)

options=$(curl -s https://vtools.oss-cn-beijing.aliyuncs.com/Scene-Online/Thermal/$platform/$device/options.ini)
if [[ $(echo $options | grep Error) != "" ]]; then
  echo 0
else
  echo 1
fi
# echo "$options"