if [ -z "\"$app_package_name\" = " ]; then exit 1
fi
sed -i -E "s|(^\"$app_package_name\" = )[[:blank:]]*(.*)|\1$target_fps|" /data/media/0/Android/fas-rs/games.toml