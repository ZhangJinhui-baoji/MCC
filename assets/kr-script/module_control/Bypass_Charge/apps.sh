if [ -z "$apps" ]; then
temp_file2="/data/adb/modules/Bypass_Charge/temp_file2.txt"
grep -E -v -e '[a-zA-Z0-9]+\.[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*' /data/adb/modules/Bypass_Charge/GameList.txt > "$temp_file2"
mv "$temp_file2" /data/adb/modules/Bypass_Charge/GameList.txt
exit 0
fi
temp_file="/data/adb/modules/Bypass_Charge/temp_file.txt"
echo "$apps" | while IFS= read -r app; do
grep "$app " "/data/adb/modules/Bypass_Charge/GameList.txt" >> "$temp_file"
done
temp_file2="/data/adb/modules/Bypass_Charge/temp_file2.txt"
grep -E -v -e '[a-zA-Z0-9]+\.[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*' /data/adb/modules/Bypass_Charge/GameList.txt > "$temp_file2"
mv "$temp_file2" /data/adb/modules/Bypass_Charge/GameList.txt
temp_file3="/data/adb/modules/Bypass_Charge/temp_file3.txt"
echo "$apps" | while IFS= read -r app; do
echo "$app" >> "$temp_file3"
done
temp_file3_tmp="/data/adb/modules/Bypass_Charge/temp_file3.tmp"
while IFS= read -r line; do
pattern=$(echo "$line" | awk '{print $1}')
sed -E "/$pattern / d" "$temp_file3" > "$temp_file3_tmp"
mv "$temp_file3_tmp" "$temp_file3"
done < "$temp_file"
cat "$temp_file3"
cat "$temp_file3" "$temp_file" >> /data/adb/modules/Bypass_Charge/GameList.txt
rm "$temp_file" "$temp_file3"