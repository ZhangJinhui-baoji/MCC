if [ -z "$apps" ]; then
temp_file2="/data/media/0/Android/fas-rs/temp_file2.txt"
sed '/\[game_list\]/,/\[powersave\]/ {/^\[game_list\]/b;/^\[powersave\]/b;d}' /data/media/0/Android/fas-rs/games.toml  | awk '/\[game_list\]/{print; print ""; next} 1' > "$temp_file2" && mv "$temp_file2" /data/media/0/Android/fas-rs/games.toml
exit 0
fi
temp_file="/data/media/0/Android/fas-rs/temp_file.txt"
echo "$apps" | while IFS= read -r app; do
grep "\"$app\"" "/data/media/0/Android/fas-rs/games.toml" >> "$temp_file"
done
temp_file2="/data/media/0/Android/fas-rs/temp_file2.txt"
sed '/\[game_list\]/,/\[powersave\]/ {/^\[game_list\]/b;/^\[powersave\]/b;d}' /data/media/0/Android/fas-rs/games.toml  | awk '/\[game_list\]/{print; print ""; next} 1' > "$temp_file2" && mv "$temp_file2" /data/media/0/Android/fas-rs/games.toml
temp_file3="/data/media/0/Android/fas-rs/temp_file3.txt"
echo "$apps" | while IFS= read -r app; do
echo "\"$app\" = 0" >> "$temp_file3"
done
temp_file3_tmp="/data/media/0/Android/fas-rs/temp_file3.tmp"
while IFS= read -r line; do
pattern=$(echo "$line" | awk '{print $1}')
sed -E "/$pattern/ d" "$temp_file3" > "$temp_file3_tmp"
mv "$temp_file3_tmp" "$temp_file3"
done < "$temp_file"
cat "$temp_file3"
temp_file4="/data/media/0/Android/fas-rs/temp_file4.txt"
cat "$temp_file3" "$temp_file" > "$temp_file4"
sed -i '/\[game_list\]/r '"$temp_file4" "/data/media/0/Android/fas-rs/games.toml"
rm "$temp_file" "$temp_file3" "$temp_file4"