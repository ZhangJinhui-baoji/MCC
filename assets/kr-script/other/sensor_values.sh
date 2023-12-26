#!/system/bin/sh

# for sensor in /sys/class/thermal/*

cd /sys/class/thermal/
for sensor in *
do
  if [[ -f $sensor/temp ]]
  then
    echo -n $sensor'#'
    echo `cat $sensor/type` `cat $sensor/temp` # $sensor
  fi
done

# cat thermal_zone5/temp
