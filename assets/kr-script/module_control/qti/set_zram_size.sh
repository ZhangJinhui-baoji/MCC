file_path="$qti_path/panel_qti_mem.txt"
search_text="zram_size"
line_number=$(grep -n "$search_text" "$file_path" | cut -d ':' -f 1)
if [ -n "$line_number" ]; then
  line_content=$(sed -n "${line_number}p" "$file_path")
  original_alg=$(echo "$line_content" | sed 's/.*=//')
  new_line_content=$(echo "$line_content" | sed "s/$original_alg/$zram_size/")
  sed -i "${line_number}s/.*/$new_line_content/" "$file_path"
fi