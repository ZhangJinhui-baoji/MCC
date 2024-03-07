Time=$(date +"%Y%m%d%H%M%S")
IFS=$'\n'
echo "$extract" > $START_DIR/kr-script/backup_tool/img_extract_dir
[[ ! -d "$extract" ]] && mkdir -p "$extract"

for i in $img; do
    e=${i##*/}
    File="$extract/${e}_${Time}.img"
    [[ ! -L $i ]] && abort "！$e分区不存在无法提取"
    echo "- 开始提取$e分区…………"
    dd if="$i" of="$File"
    echo "- 已提取$e分区到：$File"
    echo
done
