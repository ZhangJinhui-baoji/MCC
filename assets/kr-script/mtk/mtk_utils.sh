lock_value () {
  chmod 644 $2
  echo $1 > $2
  chmod 444 $2
}

sched_boost_get() {
  cat /sys/devices/system/cpu/sched/sched_boost | cut -f2 -d '='
}

sched_boost_set() {
  if [[ "$state" == "no boost" ]]; then
    echo 0 > /sys/devices/system/cpu/sched/sched_boost
  elif [[ "$state" == "all boost" ]]; then
    echo 1 > /sys/devices/system/cpu/sched/sched_boost
  elif [[ "$state" == "foreground boost" ]]; then
    echo 2 > /sys/devices/system/cpu/sched/sched_boost
  fi
}

eas_get() {
  cat /sys/devices/system/cpu/eas/enable | cut -f2 -d '='
}

eas_set() {
  chmod 664 /sys/devices/system/cpu/eas/enable
  if [[ "$state" == "HMP" ]]; then
    echo 0 > /sys/devices/system/cpu/eas/enable
  elif [[ "$state" == "EAS" ]]; then
    echo 1 > /sys/devices/system/cpu/eas/enable
  elif [[ "$state" == "hybrid" ]]; then
    echo 2 > /sys/devices/system/cpu/eas/enable
  fi
  chmod 444 /sys/devices/system/cpu/eas/enable
}

gpu_freq() {
  dvfs=/proc/mali/dvfs_enable
  if [[ "$state" == "0" ]]; then
    echo 0 > /proc/gpufreq/gpufreq_opp_freq
    echo -1 > /proc/gpufreq/gpufreq_opp_freq
    echo 0 0 > /proc/gpufreq/gpufreq_fixed_freq_volt
    echo 1 > $dvfs
  else
    echo 0 > $dvfs
    if [[ "$voltage" == "" || "$voltage" = "-1" ]]; then
      freq_row=$(grep "$state," /proc/gpufreq/gpufreq_opp_dump)
      opp=${freq_row:1:2}
      echo 0 0 > /proc/gpufreq/gpufreq_fixed_freq_volt
      echo $state > /proc/gpufreq/gpufreq_opp_freq
    else
      echo 0 > /proc/gpufreq/gpufreq_opp_freq
      echo $state $voltage > /proc/gpufreq/gpufreq_fixed_freq_volt
    fi
  fi
}

gpu_freq_cur() {
  g_fixed_freq=$(cat /proc/gpufreq/gpufreq_fixed_freq_volt | grep g_fixed_freq)
  if [[ "$g_fixed_freq" == "" ]]; then
    freq=$(grep 'freq =' /proc/gpufreq/gpufreq_opp_freq | cut -f1 -d ',' | awk '{ print $4}')
    if [[ "$freq" == "" ]]; then
      echo 0
    else
      echo $freq
    fi
  else
    echo -n $g_fixed_freq | awk '{ print $3}'
  fi
}

gpu_freq_cur_khz(){
  freq=$(gpu_freq_cur)
  if [[ "$freq" == "0" ]]; then
    echo ''
  else
    echo ${freq}KHz
  fi
}

ddr_freq () {
  local boost=/sys/devices/platform/boot_dramboost/dramboost/dramboost
  if [[ -f $boost ]] && [[ "$state" == "1" ]]; then
    echo 0 > $boost
  fi
  echo $state > /sys/devices/platform/10012000.dvfsrc/helio-dvfsrc/dvfsrc_force_vcore_dvfs_opp
}

eem_offset() {
  echo $2 > /proc/eem/EEM_DET_$1/eem_offset
}
eemg_offset() {
  echo $2 > /proc/eemg/EEMG_DET_$1/eemg_offset
}

# Example
voltage_offset(){
  # B
  eem_offset B -10
  # S
  eem_offset L -10
  # M
  eem_offset BL -10
  eem_offset CCI -10
  # GPU
  eemg_offset GPU 0
  eemg_offset GPU_HI 0
}

eem_module_summary(){
  if [[ -d /data/adb/modules/scene_mtk_eem ]];then
    echo 'current saved: ' $(grep '=' /data/adb/modules/scene_mtk_eem/offset.conf | cut -f2 -d '=')
  else
    echo ''
  fi
}

# gpu_freq_max [oppIndex]
gpu_freq_max() {
  lock_value $state /sys/kernel/ged/hal/custom_upbound_gpu_freq
}
# gpu_freq_max_freq [freqKHZ]
gpu_freq_max_freq() {
  gpu_opp=$(grep "freq = $state," /proc/gpufreq/gpufreq_opp_dump)
  lock_value $((${gpu_opp:1:2}+0)) /sys/kernel/ged/hal/custom_upbound_gpu_freq

  state=0
  gpu_freq
}
gpu_freq_max_freq_cur(){
  cur=$(cat /sys/kernel/ged/hal/custom_upbound_gpu_freq)
  cur=$(printf "%02d" $cur)
  grep "\[$cur\]" /proc/gpufreq/gpufreq_opp_dump | awk '{printf $4 "\n"}' | cut -f1 -d ","
}
gpu_freq_max_freq_cur_khz(){
  cur=$(cat /sys/kernel/ged/hal/custom_upbound_gpu_freq)
  cur=$(printf "%02d" $cur)
  khz=$(grep "\[$cur\]" /proc/gpufreq/gpufreq_opp_dump | awk '{printf $4 "\n"}' | cut -f1 -d ",")
  echo ${khz}KHz
}

thermal_profile() {
  profile="/vendor/etc/.tp/$state"
  if [[ -f "$profile" ]];then
    thermal_manager "$profile"
  else
    echo 'unselected' 1>&2
  fi
}

lock_val() {
  chmod 664 $2 2>/dev/null
  echo $1 > $2
  chmod 000 $2 2>/dev/null
}
ulock_val(){
  chmod 664 $2 2>/dev/null
  echo $1 > $2
}

dimensity_hybrid_switch() {
  module=/data/adb/modules/dimensity_hybrid_governor
  disable=$module/disable
  if [[ $(pidof gpu-scheduler) != '' ]]; then
    echo '' > $disable
    killall gpu-scheduler 2>/dev/null
  else
    nohup $module/gpu-scheduler > /dev/null 2>&1 &
    rm -f $disable 2>/dev/null
  fi
}
gpu_volt_cur(){
  fix_freq_volt=$(cat /proc/gpufreq/gpufreq_fixed_freq_volt | grep g_fixed_vgpu)
  if [[ "$fix_freq_volt" != "" ]]; then
     echo $fix_freq_volt | awk '{ print $3}'
  else
     echo '-1'
  fi
}

ultra_limit_get() {
  trip_0=$(grep trip_0 /proc/driver/thermal/tzcpu)
  trip_0=$(echo ${trip_0:7} | awk '{printf $1}')
  if [[ "$trip_0" != "" ]] && [[ "$trip_0" -gt "120000" ]]; then
    echo 1
  else
    echo 0
  fi
}

sspm_thermal_throttle(){
  if [[ "$state" == "1" ]]; then
    echo 'Modify PPM Status…'
    cat /proc/ppm/policy_status | grep -E 'PWR_THRO|THERMAL' | while read row
    do
      idx=$(echo ${row:1:1})
      echo  > /proc/ppm/policy_status
      ulock_val "$idx 0" /proc/ppm/policy_status
    done
  fi
  echo $state > /proc/driver/thermal/sspm_thermal_throttle
}

ultra_limit_set() {
  if [[ "$state" == "1" ]]; then
    echo '温度墙超限 会使默认的CPU 120°C自动关机设定失效' 1>&2
    echo '这是极危险的行为，可能导致你的设备过热发生故障！' 1>&2
    echo '由此造成的后果，将无人为你负责！' 1>&2
    echo '如果你还没有准备好，请在15秒内点击退出！' 1>&2
    echo '⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️' 1>&2
    sleep 15
    echo '⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️' 1>&2
    echo 'Modify Thermal Throttle…'
    t_limit="125"
    t_limit_ui="145°C"
    no_cooler="0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler"
    lock_val "1 ${t_limit}000 0 mtktscpu-sysrst $no_cooler 200" /proc/driver/thermal/tzcpu
    lock_val "1 ${t_limit}000 0 mtktspmic-sysrst $no_cooler 1000" /proc/driver/thermal/tzpmic
    lock_val "1 ${t_limit}000 0 mtktsbattery-sysrst $no_cooler 1000" /proc/driver/thermal/tzbattery
    lock_val "1 ${t_limit}000 0 mtk-cl-kshutdown00 $no_cooler 2000" /proc/driver/thermal/tzpa
    lock_val "1 ${t_limit}000 0 mtktscharger-sysrst $no_cooler 2000" /proc/driver/thermal/tzcharger
    lock_val "1 ${t_limit}000 0 mtktswmt-sysrst $no_cooler 1000" /proc/driver/thermal/tzwmt
    lock_val "1 ${t_limit}000 0 mtktsAP-sysrst $no_cooler 1000" /proc/driver/thermal/tzbts
    lock_val "1 ${t_limit}000 0 mtk-cl-kshutdown01 $no_cooler 1000" /proc/driver/thermal/tzbtsnrpa
    lock_val "1 ${t_limit}000 0 mtk-cl-kshutdown02 $no_cooler 1000" /proc/driver/thermal/tzbtspa
    echo "Thermal Throttle up to ${t_limit_ui}"
    sspm_thermal_throttle
  else
    ulock_val '3 117000 0 mtktscpu-sysrst 57000 0 cpu_adaptive_0 56000 0 cpu_adaptive_1 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 200' /proc/driver/thermal/tzcpu
    ulock_val '1 136000 0 mtktspmic-sysrst 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 1000' /proc/driver/thermal/tzpmic
    ulock_val '1 120000 0 mtk-cl-kshutdown00 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 2000' /proc/driver/thermal/tzpa
    ulock_val '1 120000 0 mtktscharger-sysrst 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 2000' /proc/driver/thermal/tzcharger
    ulock_val '1 120000 0 mtktswmt-sysrst 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 1000' /proc/driver/thermal/tzwmt
    ulock_val '5 100000 0 mtktsAP-sysrst 90000 0 mtk-cl-kshutdown03 58000 0 mtk-cl-cam00 52000 0 abcct_lcmoff 50000 0 abcct 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 1000' /proc/driver/thermal/tzbts
    ulock_val '4 120000 0 mtk-cl-kshutdown01 110000 0 no-cooler 100000 0 no-cooler 68000 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 1000' /proc/driver/thermal/tzbtsnrpa
    ulock_val '4 120000 0 mtk-cl-kshutdown02 110000 0 no-cooler 100000 0 no-cooler 90000 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 0 0 no-cooler 1000' /proc/driver/thermal/tzbtspa
  fi

  echo $state > /proc/driver/thermal/sspm_thermal_throttle
}