list_file="/sdcard/Android/HChai/HC_memory/名单列表.conf"
tempfile="/sdcard/Android/HChai/HC_memory/tempfile"
tempfile_temp="$tempfile"_temp
list_file_temp="$list_file"_temp.conf
awk '/{/{f++} f==2; /}/{if (f==2) print}' "$list_file" | sed 's/{//;s/}//' > "$tempfile"
awk 'NF' "$tempfile" > "$tempfile_temp" && mv "$tempfile_temp" "$tempfile"
grep -Fvf "$tempfile" "$list_file" > "$list_file_temp" && mv "$list_file_temp" "$list_file"
rm "$tempfile"
child_processes_fixed=$(echo -n "$child_processes" | tr '\n' '\t')
awk -v child_processes="$child_processes_fixed" 'BEGIN{gsub(/\t/, "\n", child_processes)} {print} /{/{count++} count==2 && !inserted{print child_processes; inserted=1; next} ' "$list_file" > tmpfile && mv tmpfile "$list_file"