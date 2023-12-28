source_file="$START_DIR/kr-script/module_control/path/feas_path"
target_file="$START_DIR/kr-script/module_control/feas/path"
[ ! -f "$target_file" ] && cp "$source_file" "$target_file"