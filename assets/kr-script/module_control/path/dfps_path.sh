source_file="$START_DIR/kr-script/module_control/path/dfps_path"
target_file="$START_DIR/kr-script/module_control/dfps/path"
[ ! -f "$target_file" ] && cp "$source_file" "$target_file"