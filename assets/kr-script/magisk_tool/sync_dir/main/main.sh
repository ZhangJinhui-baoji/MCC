#!/system/bin/sh
sleep 2

sync_dir() {
    local app_name="$1"
    local source_path="$2"
    local target_path="/data/media/0/Download/$app_name"

    if [[ -d $source_path ]]; then
        echo "存在$app_name"
        [[ ! -d $target_path ]] && mkdir -p "$target_path"
        mount --bind "$source_path" "$target_path"
        chcon u:object_r:media_rw_data_file:s0 "$source_path"
        chown media_rw:media_rw "$target_path"
    fi
}

#同步路径