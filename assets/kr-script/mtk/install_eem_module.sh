if [[ ! -d /data/adb/modules ]];then
  echo 'Please install Magisk first!'
  exit 0
fi

echo '注意：请确保你已经完成稳定性测试！' 1>&2
echo 'Warning: Make sure you have completed the stability test!' 1>&2
echo '' 1>&2
echo '操作将在5秒后开始……' 1>&2
echo 'I will wait 5 seconds……' 1>&2
echo '' 1>&2

sleep 5

module_dir=/data/adb/modules/scene_mtk_eem
if [[ -d $module_dir ]]; then
  echo 'Remove installed module……'
  rm -rf $module_dir
fi

mkdir -p $module_dir

if [[ -f /proc/eem/EEM_DET_L/eem_offset ]];then
  EEM_DET_L=$(cat /proc/eem/EEM_DET_L/eem_offset)
fi
if [[ -f /proc/eem/EEM_DET_BL/eem_offset ]];then
  EEM_DET_BL=$(cat /proc/eem/EEM_DET_BL/eem_offset)
fi
if [[ -f /proc/eem/EEM_DET_B/eem_offset ]];then
  EEM_DET_B=$(cat /proc/eem/EEM_DET_B/eem_offset)
fi
if [[ -f /proc/eem/EEM_DET_CCI/eem_offset ]];then
  EEM_DET_CCI=$(cat /proc/eem/EEM_DET_CCI/eem_offset)
fi

if [[ -f /proc/eemg/EEMG_DET_GPU/eemg_offset ]];then
  EEMG_DET_GPU=$(cat /proc/eemg/EEMG_DET_GPU/eemg_offset)
fi
if [[ -f /proc/eemg/EEMG_DET_GPU_HI/eemg_offset ]];then
  EEMG_DET_GPU_HI=$(cat /proc/eemg/EEMG_DET_GPU_HI/eemg_offset)
fi

echo ''
echo 'Build offset.conf'
echo "/proc/eem/EEM_DET_L/eem_offset=$EEM_DET_L
/proc/eem/EEM_DET_BL/eem_offset=$EEM_DET_BL
/proc/eem/EEM_DET_B/eem_offset=$EEM_DET_B
/proc/eem/EEM_DET_CCI/eem_offset=$EEM_DET_CCI
/proc/eemg/EEMG_DET_GPU/eemg_offset=$EEMG_DET_GPU
/proc/eemg/EEMG_DET_GPU_HI/eemg_offset=$EEMG_DET_GPU_HI" > $module_dir/offset.conf

echo ''
echo 'Install Module'
echo 'id=scene_mtk_eem
name=[SCENE]Voltage Offset
version=1.0.0
versionCode=1
description=Change the voltage of the CPU and GPU
author=嘟嘟ski
' > $module_dir/module.prop

echo ''
echo 'Install Service'
cp $START_DIR/kr-script/mtk/eem_service.sh $module_dir/service.sh

echo ''
echo '此模块会在开机后120秒内执行'
echo 'The automation module will execute within 120 seconds after the restart'
