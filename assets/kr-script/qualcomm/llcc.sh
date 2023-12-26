path=/sys/devices/system/cpu/bus_dcvs/LLCC

lock_value () {
  chmod 644 $2
  echo $1 > $2
  chmod 444 $2
}
get_min_freq(){
  cat $path/*/min_freq | head -1
}
get_max_freq(){
  cat $path/*/max_freq | head -1
}
set_min_freq(){
  for file in $path/*/min_freq
  do
    lock_value $state $file
  done
}
set_max_freq(){
  for file in $path/*/max_freq
  do
    lock_value $state $file
  done
}

get_boost_freq(){
  cat $path/boost_freq
}
set_boost_freq(){
  lock_value $state $path/boost_freq
}

options(){
  for item in $(cat $path/available_frequencies)
  do
    echo $item
  done
}

visible() {
  if [[ -d $path ]]; then
    echo 1
  else
    echo 0
  fi
}

$1