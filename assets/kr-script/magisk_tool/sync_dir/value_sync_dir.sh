#!/bin/bash

FILE_PATH="/data/adb/modules/mcc_sync_dir/main.sh"

if [ -r "$FILE_PATH" ]; then

    content=$(awk '/^#同步路径/{p=1; next} p && NF {sub(/^sync_dir /, ""); print}' "$FILE_PATH")

    if [ -n "$content" ]; then
        echo "$content"
    else
        echo "'QQ' '/data/media/0/Android/data/com.tencent.mobileqq/Tencent/QQfile_recv'\n'微信' '/data/media/0/Android/data/com.tencent.mm/MicroMsg/Download'"
    fi
else
    echo "'QQ' '/data/media/0/Android/data/com.tencent.mobileqq/Tencent/QQfile_recv'\n'微信' '/data/media/0/Android/data/com.tencent.mm/MicroMsg/Download'"
fi