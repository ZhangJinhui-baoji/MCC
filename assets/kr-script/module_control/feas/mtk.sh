platform=`getprop ro.board.platform | grep mt`
if [[ "$platform" != "" ]] && [[ ! -d /proc/ppm ]] && [[ -d /proc/gpufreqv2 ]]
then
  echo 1
fi