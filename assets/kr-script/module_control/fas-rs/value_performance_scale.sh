file="$fas_path/games.toml"
search_term="scale"
content=$(awk -F ' *= *' -v term="$search_term" '/\[performance\]/,/\[fast\]/{ if ($1 ~ "^"term"$" || $1 ~ "^"term"=") {sub(/"/, "", $2); gsub(/ *$/, "", $2); print $2}}' "$file")

echo "$content"