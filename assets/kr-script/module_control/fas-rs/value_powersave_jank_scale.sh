file="$fas_path/games.toml"
search_term="jank_scale"
content=$(awk -F ' *= *' -v term="$search_term" '/\[powersave\]/,/\[balance\]/{ if ($1 ~ "^"term"$" || $1 ~ "^"term"=") {sub(/"/, "", $2); gsub(/ *$/, "", $2); print $2}}' "$file")

echo "$content"