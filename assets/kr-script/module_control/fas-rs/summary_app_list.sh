sed -n '/\[game_list\]/,/\[powersave\]/p' $fas_path/games.toml > $fas_path/temporary_file
grep -E '[a-zA-Z0-9]+\.[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*' $fas_path/temporary_file
rm "$fas_path/temporary_file"