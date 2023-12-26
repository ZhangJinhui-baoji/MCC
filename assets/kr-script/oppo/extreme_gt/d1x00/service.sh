lock_value() {
  if [[ -f $2 ]];then
    chmod 644 $2
    echo $1 > $2
    chmod 444 $2
  fi
}

if [[ "$soc" == 'mt6891' ]] || [[ "$soc" == 'mt6893' ]] || [[ "$soc" == 'mt6889' ]]; then
  disable_core_ctl() {
    c0=/sys/devices/system/cpu/cpu0/core_ctl
    c1=/sys/devices/system/cpu/cpu4/core_ctl
    c2=/sys/devices/system/cpu/cpu7/core_ctl

    lock_value 4 $c0/max_cpus
    lock_value 4 $c0/min_cpus
    lock_value 0 $c0/enable

    lock_value 3 $c1/max_cpus
    lock_value 3 $c1/min_cpus
    lock_value 0 $c1/enable

    lock_value 1 $c2/max_cpus
    lock_value 1 $c2/min_cpus
    lock_value 0 $c2/enable

    lock_value -1 /sys/kernel/fpsgo/fbt/thrm_limit_cpu
    lock_value -1 /sys/kernel/fpsgo/fbt/thrm_sub_cpu
  }
  sched_isolation_disable() {
    for i in 0 1 2 3 4 5 6 7; do
      echo $i > /sys/devices/system/cpu/sched/set_sched_deisolation
    done
    chmod 000 /sys/devices/system/cpu/sched/set_sched_isolation
    disable_core_ctl
  }

  for i in 3 4 5 6; do
    echo $i 0 0 > /proc/gpufreq/gpufreq_limit_table
  done
  for i in 'hard_userlimit_cpu_freq' 'hard_userlimit_freq_limit_by_others'; do
    echo 0 -1 > /proc/ppm/policy/$i
    echo 1 -1 > /proc/ppm/policy/$i
    chmod 444 /proc/ppm/policy/$i
    # cat /proc/ppm/policy/$i
  done
  for i in 3 4 5 6; do
    echo $i 0 0 > /proc/gpufreq/gpufreq_limit_table
  done

  # PPM
  echo 1 > /proc/ppm/enabled
  cat /proc/ppm/policy_status | grep -e '\[.*\]' | while read row
  do
    case "$row" in
      *"PPM_POLICY_HARD_USER_LIMIT"*)
        v=1
      ;;
      *)
        v=0
      ;;
    esac
    echo ${row:1:1} $v > /proc/ppm/policy_status
  done
  lock_value 100 /sys/kernel/fpsgo/fbt/thrm_temp_th
  lock_value -1 /sys/kernel/fpsgo/fbt/thrm_limit_cpu
  lock_value -1 /sys/kernel/fpsgo/fbt/thrm_sub_cpu
  sched_isolation_disable
fi
