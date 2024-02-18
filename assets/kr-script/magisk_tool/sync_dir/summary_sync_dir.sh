#!/bin/bash

FILE_PATH="/data/adb/modules/mcc_sync_dir/main.sh"

content=$(grep "^sync_dir " "$FILE_PATH" | awk -F"'" '{print $2}' | tr '\n' ' ')

echo "已同步：$content"