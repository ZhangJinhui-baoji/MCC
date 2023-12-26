module_dir=/data/adb/modules/scene_resurgence
if [[ -d $module_dir ]]; then
  echo 'Remove installed module……'
  rm -rf $module_dir
fi

if [[ ! -d /data/adb/modules ]];then
  echo 'Please install Magisk first!'
  exit 0
fi

modules_dir=/data/adb/modules
self=scene_resurgence
module_files=$PAGE_WORK_DIR/resurgence

cp_module_file() {
  echo '[+]' $1
  cp $module_files/$1 $modules_dir/$self/$1
  chmod 755 $modules_dir/$self/$1
}
remove_module_file(){
  if [[ -f $modules_dir/$self/$1 ]]; then
    rm $modules_dir/$self/$1
  fi
}

build_options() {
boot_completed=$(getprop sys.boot_completed)
echo "
splash_fix=$splash_fix
splash_methods=$splash_methods
anim_fix=$anim_fix
anim_methods=$anim_methods
timeout_fix=$boot_completed
timeout_methods=$timeout_methods
update_protect=$update_protect
update_methods=$update_methods
" > $modules_dir/$self/options.conf
echo '[+] options.conf'

}

install(){
  mkdir -p $modules_dir/$self
  version=$(cat /system/build.prop | grep ro.build.version.incremental)
  echo "$version" > $modules_dir/$self/last.version

  cp_module_file post-fs-data.sh
  cp_module_file service.sh
  cp_module_file module.prop
  cp_module_file disable_module.sh
  cp_module_file reset_display.sh
  cp_module_file restore_apps.sh
  build_options
  remove_module_file 'last.splash'
  remove_module_file 'last.animation'

  echo ' '
  echo '# 系统自救会在何时触发？'
  echo '> 检测到系统版本已更新'
  echo '> 3分钟内设备重启两次'
  echo '> 显示开机动画3分钟后仍未完成启动'
  echo ' '
  echo '# 系统自救会做什么？'
  echo '> 禁用除自身以外的所有Magisk模块'
  echo '> 还原对分辨率、DPI的修改'
  echo '> 还原隐藏、冻结的应用'
  echo ' '
  echo '注意：自救模块并不是万能的，对系统的修改操作无论何时都需要保持谨慎' 1>&2
}

install
