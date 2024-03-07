temp_file="/data/media/0/Android/fas-rs/temp_file.txt"
sed '/\[balance\]/,/\[performance\]/ {/^\[balance\]/b;/^\[performance\]/b;d}' /data/media/0/Android/fas-rs/games.toml  | awk '/\[balance\]/{print; print ""; next} 1' > "$temp_file" && mv "$temp_file" /data/media/0/Android/fas-rs/games.toml

file="/data/media/0/Android/fas-rs/games.toml"

if [ "$fas_boost" -eq 1 ]; then
  fas_boost_var="true"
else
  fas_boost_var="false"
fi

if [ "$use_performance_governor" -eq 1 ]; then
  use_performance_governor_var="true"
else
  use_performance_governor_var="false"
fi

insert_content="fas_boost = $fas_boost_var\nuse_performance_governor = $use_performance_governor_var"

awk -v content="$insert_content" '/\[balance\]/{print; print content; next} 1' "$file" > "$file.tmp" && mv "$file.tmp" "$file"