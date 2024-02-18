file="$fas_path/games.toml"
search_term="use_performance_governor"
content=$(awk -F ' *= *' -v term="$search_term" '/\[powersave\]/,/\[balance\]/{ if ($1 ~ "^"term"$" || $1 ~ "^"term"=") {sub(/"/, "", $2); gsub(/ *$/, "", $2); print $2}}' "$file")

if [ "$content" = "true" ]; then
  echo "1"
elif [ "$content" = "false" ]; then
  echo "0"
fi