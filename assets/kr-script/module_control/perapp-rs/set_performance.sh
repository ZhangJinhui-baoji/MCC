apps=$(echo -e "$apps" | sed ':a;N;$!ba;s/\n/", "/g' | sed 's/^/"/;s/$/"/')

sed -i '/^\[performance\]/,/list =/ s/list = \[.*\]/list = ['"$apps"']/g' /data/media/0/Android/perapp-rs/config.toml