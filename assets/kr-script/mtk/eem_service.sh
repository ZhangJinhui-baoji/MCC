MODDIR=${0%/*}

sleep 120
# MODDIR=/data/adb/modules/scene_mtk_eem

if [[ -f $MODDIR/offset.conf ]];then
  grep '=' $MODDIR/offset.conf | while read row
  do
    path=$(echo $row | cut -f1 -d '=')
    value=$(echo $row | cut -f2 -d '=')
    if [[ "$value" != "" ]] && [[ "$value" != "0" ]];then
      chmod 664 $path
      echo $value > $path
    fi
  done
fi