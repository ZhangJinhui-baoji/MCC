if [ -z "$apps" ]; then
temp_file2="$feas_path/temp_file2.txt"
grep -E -v -e '[a-zA-Z0-9]+\.[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*' $feas_path/feas.conf > "$temp_file2"
mv "$temp_file2" $feas_path/feas.conf
exit 0
fi
temp_file="$feas_path/temp_file.txt"
echo "$apps" | while IFS= read -r app; do
grep "$app " "$feas_path/feas.conf" >> "$temp_file"
done
temp_file2="$feas_path/temp_file2.txt"
grep -E -v -e '[a-zA-Z0-9]+\.[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*' $feas_path/feas.conf > "$temp_file2"
mv "$temp_file2" $feas_path/feas.conf
temp_file3="$feas_path/temp_file3.txt"
echo "$apps" | while IFS= read -r app; do
echo "$app 0" >> "$temp_file3"
done
temp_file3_tmp="$feas_path/temp_file3.tmp"
while IFS= read -r line; do
pattern=$(echo "$line" | awk '{print $1}')
sed -E "/$pattern / d" "$temp_file3" > "$temp_file3_tmp"
mv "$temp_file3_tmp" "$temp_file3"
done < "$temp_file"
cat "$temp_file3"
cat "$temp_file3" "$temp_file" >> $feas_path/feas.conf
rm "$temp_file" "$temp_file3"