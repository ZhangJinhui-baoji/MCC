file_path="/data/media/0/Android/fas-rs/games.toml"

if [[ ${state} == 0 ]]; then
  sed -i "/^keep_std =/s/.*/keep_std = false/" "$file_path"
elif [[ ${state} == 1 ]]; then
  sed -i "/^keep_std =/s/.*/keep_std = true/" "$file_path"
fi