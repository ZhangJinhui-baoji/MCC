sed -n '/\[game_list\]/,/\[powersave\]/p' /data/media/0/Android/fas-rs/games.toml > /data/media/0/Android/fas-rs/temporary_file
grep -E '[a-zA-Z0-9]+\.[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*' /data/media/0/Android/fas-rs/temporary_file
rm "/data/media/0/Android/fas-rs/temporary_file"