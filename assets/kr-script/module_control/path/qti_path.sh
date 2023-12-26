source_file="$START_DIR/kr-script/module_control/path/qti_path"
target_file="$START_DIR/kr-script/module_control/qti/path"
[ ! -f "$target_file" ] && cp "$source_file" "$target_file"