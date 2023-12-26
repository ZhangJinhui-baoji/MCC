MODDIR=${0%/*}

# Now
time=$(date '+%s')
# Last Boot
last=$(cat $MODDIR/splash.last)
# Last Boot(Animation)
last_anim=$(cat $MODDIR/animation.last)
# Last Version
last_version=$(cat $MODDIR/last.version)
# System Version
version=$(cat /system/build.prop | grep ro.build.version.incremental)

# Need help?
rescue=0

if [[ "$last_version" != "" ]] && [[ "$version" != "$last_version" ]]; then
  # rescue=1
  source $MODDIR/disable_module.sh
elif [[ "$last" != "" ]] && [[ $(($last+180)) -gt $time ]]; then
  rescue=1
elif [[ "$last_anim" != "" ]] && [[ $(($last_anim+180)) -gt $time ]]; then
  rescue=1
else
  echo $time > $MODDIR/splash.last
fi

# self-rescue
if [[ $rescue == 1 ]];then
  source $MODDIR/reset_display.sh
  source $MODDIR/restore_apps.sh
  source $MODDIR/disable_module.sh
fi
