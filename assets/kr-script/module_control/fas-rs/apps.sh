if [ -z "$apps" ]; then
temp_file2="$fas_path/temp_file2.txt"
grep -E -v -e '[a-zA-Z0-9]+\.[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*' $fas_path/games.toml > "$temp_file2"
mv "$temp_file2" $fas_path/games.toml
exit 0
fi
temp_file="$fas_path/temp_file.txt"
echo "$apps" | while IFS= read -r app; do
grep "\"$app\"" "$fas_path/games.toml" >> "$temp_file"
done
temp_file2="$fas_path/temp_file2.txt"
grep -E -v -e '[a-zA-Z0-9]+\.[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*' $fas_path/games.toml > "$temp_file2"
mv "$temp_file2" $fas_path/games.toml
temp_file3="$fas_path/temp_file3.txt"
echo "$apps" | while IFS= read -r app; do
echo "\"$app\" = 0" >> "$temp_file3"
done
temp_file3_tmp="$fas_path/temp_file3.tmp"
while IFS= read -r line; do
pattern=$(echo "$line" | awk '{print $1}')
sed -E "/$pattern/ d" "$temp_file3" > "$temp_file3_tmp"
mv "$temp_file3_tmp" "$temp_file3"
done < "$temp_file"
cat "$temp_file3"
temp_file4="$fas_path/temp_file4.txt"
cat "$temp_file3" "$temp_file" > "$temp_file4"
sed -i '/\[game_list\]/r '"$temp_file4" "$fas_path/games.toml"
rm "$temp_file" "$temp_file3" "$temp_file4"