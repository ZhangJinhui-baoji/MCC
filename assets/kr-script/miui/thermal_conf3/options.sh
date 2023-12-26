platform=`getprop ro.board.platform | tr 'A-Z' 'a-z'`
device=$(getprop ro.product.device)

# TODO: 部分设备没有curl
options=$(curl -s https://vtools.oss-cn-beijing.aliyuncs.com/Scene-Online/Thermal/$platform/$device/options.ini)
if [[ $(echo $options | grep Error) != "" ]]; then
  echo 'default|系统默认(default)'
else
  echo "$options"
fi