#!/system/bin/sh

SOURCE_DIR="$START_DIR/kr-script/magisk_tool/sync_dir/main/"
TARGET_DIR="/data/adb/modules/mcc_sync_dir/"

if [ ! -d "$TARGET_DIR" ]; then
    mkdir -p "$TARGET_DIR"
fi

cp -r "$SOURCE_DIR"* "$TARGET_DIR"

if [ $? -eq 0 ]; then
    echo "模块创建成功！"
else
    echo "模块创建失败！"
fi

FILE_PATH="/data/adb/modules/mcc_sync_dir/main.sh"

modified_sync_dir=$(echo "$sync_dir" | sed "s|^|sync_dir |")

echo "$modified_sync_dir" > /data/adb/modules/mcc_sync_dir/temp_file.tmp

if [ -z "$sync_dir" ]; then
    sed -i '/^#同步路径/{n;/^$/,$d}' "$FILE_PATH"
else

    sed -i "/^#同步路径/r /data/adb/modules/mcc_sync_dir/temp_file.tmp" "$FILE_PATH"
fi

rm /data/adb/modules/mcc_sync_dir/temp_file.tmp

echo "目录设置完成，需要重启设备才能生效！"

if [[ $reboot -eq 1 ]]; then
    echo "即将在5秒后自动重启，开始倒计时……"
    for i in $(seq 5 -1 1); do
        echo $i
        sleep 1
    done
    echo "即将重启"
    reboot
fi