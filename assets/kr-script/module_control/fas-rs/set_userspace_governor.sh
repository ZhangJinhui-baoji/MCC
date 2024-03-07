file_path="/data/media/0/Android/fas-rs/games.toml"

if [[ ${state} == 0 ]]; then
  sed -i "/^userspace_governor =/s/.*/userspace_governor = false/" "$file_path"
elif [[ ${state} == 1 ]]; then
  sed -i "/^userspace_governor =/s/.*/userspace_governor = true/" "$file_path"
fi