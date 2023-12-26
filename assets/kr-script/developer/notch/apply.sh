if [[ "$MAGISK_PATH" == "" ]]; then
  echo '使用此功能必须安装Magisk及SCENE的附加模块！' 1>&2
  return
fi

target_dir="${MAGISK_PATH}/system/product/overlay"
os=$(getprop ro.build.version.sdk)
sdk=sdk$os
dir=$PAGE_WORK_DIR/notch

echo '查找资源文件夹...' # $dir/$sdk
if [[ -d $dir/$sdk ]]; then
  echo '创建目录 ...'
  mkdir -p $target_dir
  echo '复制Overlay文件 ...'
  for item in $dir/$sdk/*
  do
    echo '  ' $item
    cp -rf $item $target_dir/
  done
  if [[ "$type" == "hole" ]]; then
    echo '现在，请先重启手机。'
    echo '再前往系统设置【开发者选项】，定位【刘海屏】选项，选择【打孔屏】'
  fi
else
  echo '未找到适用于您当前设备的Overlay文件' 1>&2
fi
