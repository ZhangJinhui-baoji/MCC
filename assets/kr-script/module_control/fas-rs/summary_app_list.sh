sed -n '/\[game_list\]/,/\[powersave\]/p' /sdcard/Android/fas-rs/games.toml > /sdcard/Android/fas-rs/temporary_file
grep -E '[a-zA-Z0-9]+\.[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*' /sdcard/Android/fas-rs/temporary_file
rm "/sdcard/Android/fas-rs/temporary_file"