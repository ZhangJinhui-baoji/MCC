MODDIR=${0%/*}

if [[ -f $MODDIR/splash.last ]]; then
  rm $MODDIR/splash.last
fi

# Last Boot
last=$(cat $MODDIR/last.animation)

# System Version
version=$(cat /system/build.prop | grep ro.build.version.incremental)
echo "$version" > $MODDIR/last.version

# Now
time=$(date '+%s')

# Boot Timeout
timout=180

# If the restart interval is less than 3 minutes
if [[ "$last" != "" ]] && [[ $(($last+$timout)) -gt $time ]]; then
  rescue=1
else
  echo $time > $MODDIR/animation.last
fi

self_rescue() {
  source $MODDIR/reset_display.sh
  source $MODDIR/restore_apps.sh
  source $MODDIR/disable_module.sh
  rm $MODDIR/animation.last
  sync
}

wait_boot_completed() {
  t=$timout
  i=10
  while [[ $t -gt 0 ]]; do
    sleep $i
    completed=$(getprop sys.boot_completed)
    if [[ "$completed" == "1" ]];then
      rm $MODDIR/animation.last
      return
    fi
    t=$(($t-$i))
  done

  completed=$(getprop sys.boot_completed)
  if [[ "$completed" != "1" ]];then
    self_rescue
    reboot
  else
    rm $MODDIR/animation.last
  fi
}

# self-rescue
if [[ $rescue == 1 ]];then
  self_rescue
elif [[ $(grep timeout_fix $MODDIR/options.conf) == "timeout_fix=1" ]]; then
  wait_boot_completed
fi
