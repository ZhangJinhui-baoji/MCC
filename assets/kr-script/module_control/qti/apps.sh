if [ -z "$apps" ]; then
temp_file2="/sdcard/Android/temp_file2.txt"
grep -E -v -e '[a-zA-Z0-9]+\.[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*' /sdcard/Android/panel_adjshield.txt > "$temp_file2"
mv "$temp_file2" /sdcard/Android/panel_adjshield.txt
exit 0
fi
temp_file="/sdcard/Android/temp_file.txt"
echo "$apps" | while IFS= read -r app; do
grep "$app " "/sdcard/Android/panel_adjshield.txt" >> "$temp_file"
done
temp_file2="/sdcard/Android/temp_file2.txt"
grep -E -v -e '[a-zA-Z0-9]+\.[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*' /sdcard/Android/panel_adjshield.txt > "$temp_file2"
mv "$temp_file2" /sdcard/Android/panel_adjshield.txt
temp_file3="/sdcard/Android/temp_file3.txt"
echo "$apps" | while IFS= read -r app; do
echo "$app" >> "$temp_file3"
done
temp_file3_tmp="/sdcard/Android/temp_file3.tmp"
while IFS= read -r line; do
pattern=$(echo "$line" | awk '{print $1}')
sed -E "/$pattern / d" "$temp_file3" > "$temp_file3_tmp"
mv "$temp_file3_tmp" "$temp_file3"
done < "$temp_file"
cat "$temp_file3"
cat "$temp_file3" "$temp_file" >> /sdcard/Android/panel_adjshield.txt
rm "$temp_file" "$temp_file3"