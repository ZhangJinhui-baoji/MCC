temp_file="$fas_path/temp_file.txt"
sed '/\[balance\]/,/\[performance\]/ {/^\[balance\]/b;/^\[performance\]/b;d}' $fas_path/games.toml  | awk '/\[balance\]/{print; print ""; next} 1' > "$temp_file" && mv "$temp_file" $fas_path/games.toml

file="$fas_path/games.toml"

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

insert_content="fas_boost = $fas_boost_var\nscale = $scale\njank_scale = $jank_scale\nbig_jank_scale = $big_jank_scale\nuse_performance_governor = $use_performance_governor_var"

awk -v content="$insert_content" '/\[balance\]/{print; print content; next} 1' "$file" > "$file.tmp" && mv "$file.tmp" "$file"