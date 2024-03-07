file_path="/data/media/0/Android/perapp-rs/config.toml"

awk -F'[][]' '/^\[balance\]/{flag=1; next} /^\[/{flag=0} flag && /list/{$1=""; gsub(/[" ,]/, "\n"); print}' "$file_path" | sed '/^$/d'