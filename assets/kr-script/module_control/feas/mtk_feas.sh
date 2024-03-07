perfmgr=/sys/module/mtk_fpsgo/parameters/perfmgr_enable
pandora_feas=/sys/module/perfmgr_mtk/parameters/perfmgr_enable
if [[ -f $pandora_feas ]]; then
  perfmgr=$pandora_feas
fi
fpsgo=/sys/kernel/fpsgo/common/fpsgo_enable
ged_kpi=/sys/module/sspm_v3/holders/ged/parameters/is_GED_KPI_enabled

lock_value () {
  chmod 644 $2
  echo $1 > $2
  chmod 444 $2
}

set_fpsgo(){
  lock_value $state $fpsgo
}

set_perfmgr() {
  if [[ $(cat $fpsgo) != "1" ]]; then
    lock_value 1 $fpsgo
  fi

  if [[ $(cat $ged_kpi) != "1" ]]; then
    lock_value 1 $ged_kpi
  fi

  lock_value $state $perfmgr
}