file="/data/media/0/Android/fas-rs/games.toml"
search_term="userspace_governor"
content=$(awk -F ' = ' -v term="$search_term" '$1 ~ "^"term"$" {sub(/"/, "", $2); gsub(/ *$/, "", $2); print $2}' "$file")
echo "$content"