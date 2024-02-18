source_file="$START_DIR/kr-script/module_control/path/asguard_path"
target_file="$START_DIR/kr-script/module_control/asguard/path"
[ ! -f "$target_file" ] && cp "$source_file" "$target_file"