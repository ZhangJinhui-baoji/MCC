platform=`getprop ro.board.platform | tr 'A-Z' 'a-z'`
mode="$state"

if [[ "$MAGISK_PATH" == "" ]]; then
  MAGISK_PATH="/data/adb/modules/scene_systemless"
fi

# 方案2 - 替换到 /data
thermal_dir="/data/vendor/thermal"
install_dir="$thermal_dir/config"
mode_state_save="$install_dir/thermal.current.ini"
source="$1"

thermal_files=(
)
if [[ "$mode" != "default" ]] && [[ "$mode" != "" ]]; then
  if [[ "$source" == "local" ]];then
    echo '根据本机配置生成目标配置……'
    mode_code=$(echo $mode | cut -f2 -d '_')
    resource_dir="$START_DIR/miui-thermal/$mode_code"
    if [[ ! -f $resource_dir/files.ini ]]; then
      echo '没有找到可用的温控文件，此设备可能未兼容' 1>&2
      return
    fi
    thermal_files=$(cat $resource_dir/files.ini)
    all_file_names=$(cat $resource_dir/files.ini)
  else
    resource_dir="./kr-script/miui/thermal_conf3/$platform/$mode"
    # 覆盖 thermal_files
    # source ./kr-script/miui/thermal_conf3/$platform/thermal_files.sh
    source ./kr-script/miui/thermal_conf3/download.sh
  fi
fi

clear_old() {
  old_dir="${MAGISK_PATH}/system/vendor/etc"
  old_state_save="$old_dir/thermal.current.ini"
  if [[ -f $old_state_save ]]; then
    echo '清理旧版文件'
    for thermal in ${thermal_files[@]}; do
      if [[ -f $old_dir/$thermal ]]; then
        rm -f $old_dir/$thermal
      fi
    done
    rm -f "$old_state_save" 2> /dev/null

    echo '建议稍后重启手机' 1>&2
    echo '#################################'
  fi
}

# 重设目录权限 据酷友 @代号10007 的方法
reset_permissions(){
  chmod -R 0771 $thermal_dir
  chown -R root:system $thermal_dir
  chcon -R 'u:object_r:vendor_data_file:s0' $thermal_dir
}

# 重建目录 据酷友 @代号10007 的方法
clear_thermal_dir() {
  r=0
  for dir in $thermal_dir $install_dir
  do
    if [[ -f $dir ]]; then
      chattr -R -i $dir
      rm -f $dir
      r=1
    fi

    if [[ -e $dir ]]; then
      chattr -R -i $dir
    else
      mkdir -p $dir
    fi
  done

  rm $install_dir/* 2>/dev/null
  rm -f "$mode_state_save" 2> /dev/null

  return $r
}

uninstall_thermal() {
  clear_old

  echo "从 $install_dir 目录"
  echo '卸载已安装的自定义配置……'
  echo ''

  clear_thermal_dir
  if [[ "$?" != '0' ]]; then
     echo "发现 $thermal_dir 目录遭到破坏" 1>&2
     echo 'Scene已尝试通过重建将其恢复至正常状态' 1>&2
     echo '请自行检查并移除可能覆盖/修改温控的模块' 1>&2
     echo "以免 $thermal_dir 被被再次破坏"
  fi

  echo ''
}

install_thermal() {
  uninstall_thermal

  echo '检测模块间是否存在冲突……'
  echo ''

  # 检查其它模块是否更改温控
  magisk_dir=`echo $MAGISK_PATH | awk -F '/[^/]*$' '{print $1}'`
  modules=`ls $magisk_dir`
  for module in ${modules[@]}; do
    if [[ "$magisk_dir/$module" != "$MAGISK_PATH" ]] && [[ -d "$magisk_dir/$module" ]] && [[ ! -f "$magisk_dir/$module/disable" ]]; then
      if [[ "$module" != "uperf" ]] && [[ "$module" != "extreme_gt" ]] && [[ -d "$magisk_dir/$module/system" ]]; then
        find_result=`find "$magisk_dir/$module/system" -name "*thermal*" -type f`
        if [[ -n "$find_result" ]]; then
          echo '发现其它修改温控的模块：' $module 1>&2
          echo "$find_result" 1>&2
          echo '请删除以上位置的文件，或禁用相关模块！' 1>&2
          echo '否则，Scene无法正常替换系统温控！' 1>&2
          exit 5
        fi
      fi
    fi
  done
  # c_dir=$(getprop vendor.sys.thermal.data.path)
  # if [[ "$c_dir" != "$thermal_dir" && "$c_dir" != "$thermal_dir/" ]];then
  #   echo 'vendor.sys.thermal.data.path 值与预期不符' 1>&2
  #   echo '当前指定为：' $(getprop vendor.sys.thermal.data.path) 1>&2
  #   echo '这可能导致温控配置不生效！' 1>&2
  #   # exit 5
  # fi

  if [[ "$source" != "local" ]];then
    download_files
  fi

  if [[ -f $resource_dir/info.txt ]]; then
    echo ''
    echo '#################################'
    cat $resource_dir/info.txt
    echo ''
    echo '#################################'
    echo ''
    echo ''
  fi

  if [[ ! -d "$install_dir" ]]; then
    mkdir -p "$install_dir"
  fi

  # for thermal in ${thermal_files[@]}; do
  #   if [[ -f "$resource_dir/$thermal" ]]; then
  #     echo '复制' $thermal
  #     cp "$resource_dir/$thermal" "$install_dir/$thermal"
  #     chmod 644 "$install_dir/$thermal"
  #   elif [[ -f "$resource_dir/general.conf" ]]; then
  #     echo '复制' $thermal
  #     cp "$resource_dir/general.conf" "$install_dir/$thermal"
  #     chmod 644 "$install_dir/$thermal"
  #   fi
  #   dos2unix "$install_dir/$thermal" 2> /dev/null
  # done

  # ls $resource_dir | while read thermal; do
  echo "$all_file_names" | dos2unix | while read thermal; do
    if [[ -f "$resource_dir/$thermal" ]]; then
      echo '复制' $thermal
      cp "$resource_dir/$thermal" "$install_dir/$thermal"
      chmod 444 "$install_dir/$thermal"
    elif [[ -f "$resource_dir/general.conf" ]]; then
      echo '复制' $thermal
      cp "$resource_dir/general.conf" "$install_dir/$thermal"
      chmod 444 "$install_dir/$thermal"
    else
      echo '跳过' $thermal
    fi
    dos2unix "$install_dir/$thermal" 2> /dev/null
  done

  echo "$mode" > "$mode_state_save"

  echo 'OK~'
  echo ''
  echo '留意，如果你使用的不是官方原版系统，或曾使用其它工具或模块更改温控，此操作可能不会生效'
  echo '如遇温控切换不生效情况，可尝试重启手机，如果重启后依然无效，那……' 1>&2
}

if [[ "$mode" == "default" || "$mode" == "" ]]; then
  uninstall_thermal
else
  install_thermal
fi

# 重启温控相关进程
for p in 'mi_thermald' 'thermal-engine'; do
if [[ $(which -a $p) != "" ]]; then
  stop $p 2>/dev/null
  start $p 2>/dev/null
fi
done

reset_permissions
