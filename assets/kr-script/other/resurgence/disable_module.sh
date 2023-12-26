modules_dir=/data/adb/modules
self=scene_resurgence

disable_module() {
  echo '' > "/data/adb/modules/$1/disable"
}

disable_module_all() {
  ls $modules_dir | grep -v $self | while read module; do
    echo '' > "/data/adb/modules/$module/disable"
  done
}

disable_module_all
