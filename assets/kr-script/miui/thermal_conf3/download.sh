platform=`getprop ro.board.platform | tr 'A-Z' 'a-z'`
device=$(getprop ro.product.device)

# https://vtools.oss-cn-beijing.aliyuncs.com/Scene-Online/Thermal/msmnile/cepheus/extreme/info.txt
host="https://vtools.oss-cn-beijing.aliyuncs.com/Scene-Online/Thermal"
# $host/msmnile/cepheus/thermal_files.ini

all_file_names=$(curl -s $host/$platform/$device/thermal_files.ini)
if [[ $(echo $all_file_names | grep Error) != "" ]];then
  echo '获取文件信息失败' 1>&2
  exit 2
fi

download_files() {
  file_names=$(curl -s $host/$platform/$device/$mode/files.ini)
  if [[ $(echo $file_names | grep Error) != "" ]];then
    echo '获取文件信息失败' 1>&2
    exit 3
  fi

  echo 'Downloading……'
  mkdir -p $resource_dir
  rm -rf $resource_dir/*
  echo "$file_names" | dos2unix | while read name; do
    # echo 'progress:[-1/100]'
    echo '-' $name
    curl -s $host/$platform/$device/$mode/$name -o $resource_dir/$name
    if [[ ! -f $resource_dir/$name ]] || [[ $(grep Error $resource_dir/$name) != "" ]];then
      echo 'Fail!' 1>&2
      exit 4
    fi
  done
  echo '-' info.txt
  curl -s $host/$platform/$device/$mode/info.txt -o $resource_dir/info.txt
}

# if [[ "$resource_dir" != "" ]]; then
#   download_files
# fi
