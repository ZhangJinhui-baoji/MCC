if [ -z "$apps" ]; then
temp_file2="$dfps_path/temp_file2.txt"
grep -E -v -e '[a-zA-Z0-9]+\.[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*' $dfps_path/dfps.txt > "$temp_file2"
mv "$temp_file2" $dfps_path/dfps.txt
exit 0
fi
temp_file="$dfps_path/temp_file.txt"
echo "$apps" | while IFS= read -r app; do
grep "$app " "$dfps_path/dfps.txt" >> "$temp_file"
done
temp_file2="$dfps_path/temp_file2.txt"
grep -E -v -e '[a-zA-Z0-9]+\.[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*' $dfps_path/dfps.txt > "$temp_file2"
mv "$temp_file2" $dfps_path/dfps.txt
temp_file3="$dfps_path/temp_file3.txt"
echo "$apps" | while IFS= read -r app; do
echo "$app 0 0" >> "$temp_file3"
done
temp_file3_tmp="$dfps_path/temp_file3.tmp"
while IFS= read -r line; do
pattern=$(echo "$line" | awk '{print $1}')
sed -E "/$pattern / d" "$temp_file3" > "$temp_file3_tmp"
mv "$temp_file3_tmp" "$temp_file3"
done < "$temp_file"
cat "$temp_file3"
target_file="$dfps_path/dfps.txt"
insert_file="$dfps_path/insert_file"
cat "$temp_file3" "$temp_file" > "$insert_file"
touch "$target_file"
temp_target_file="$dfps_path/temp_target_file.txt"
need_insert=true
while IFS= read -r line; do
if [[ $line == -* ]]; then
need_insert=false
printf '%s\n%s\n' "$(cat "$insert_file")" "$line"
elif [ "$need_insert" = true ]; then
printf '%s\n' "$line"
else
echo "$line"
fi
done < "$target_file" > "$temp_target_file"
mv "$temp_target_file" "$target_file"
sed -i '/^-/{x;p;x}' "$target_file"
rm "$temp_file" "$temp_file3" "$insert_file"
pattern='[a-zA-Z0-9]+\.[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*'
variable=$(grep -Eo "$pattern" $dfps_path/dfps.txt | head -n1)
awk -v pat="^$variable" 'BEGIN {
emptyLines = 0;
firstMatch = 1;
}
{
if ($0 ~ pat) {
firstMatch = 0;
print;
emptyLines = 0;
next;
}
if (emptyLines == 0 && NF == 0) {
emptyLines = 1;
print;
}
else if (emptyLines == 1 && NF > 0) {
print;
emptyLines = 0;
}
else if (emptyLines == 0 && NF > 0) {
print;
}
}' $dfps_path/dfps.txt > new_file.txt
mv new_file.txt $dfps_path/dfps.txt