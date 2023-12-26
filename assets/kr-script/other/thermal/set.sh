module_dir=/data/adb/modules/scene_thermal_remover
if [[ -d $module_dir ]]; then
  echo 'Remove installed module……'
  rm -rf $module_dir
fi

if [[ ! -d /data/adb/modules ]];then
  echo 'Please install Magisk first!'
  exit 0
fi


echo '注意：此操作具有较高危险性，如果你还没有做好备份和急救准备，请立刻点击退出！' 1>&2
echo 'Warning: this operation is dangerous, if you have not backed up, please click exit immediately!' 1>&2
echo ''
echo '操作将在15秒后开始……' 1>&2
echo 'I will wait 15 seconds……' 1>&2
echo ''

sleep 15

props='id=scene_thermal_remover
name=[SCENE]ThermalRemover
version=1.0.0
versionCode=1
description=Replace the thermal-engine program with an empty file
author=嘟嘟ski
'

module_files=$PAGE_WORK_DIR/thermal
cp_t_module_file() {
  echo '[+]' $1
  cp $module_files/$1 $module_dir/$1
  chmod 755 $module_dir/$1
}

if [[ "$selected" != "" ]]; then
 mkdir $module_dir
 echo "$props" > $module_dir/module.prop
 cp_t_module_file service.sh
 echo "$selected" | while read item
 do
   echo [Replace] $item
   mkdir -p $module_dir$item
   rm -r $module_dir$item
   echo '' > $module_dir$item
 done
fi
