if [ $switch -eq 1 ]; then
  sed -i "/^fps=.*/s/fps=.*/fps=$game_scenes $ordinary_scenes/" /data/adb/modules/MiuiVariableThermal/config.conf
else
  sed -i "s/^fps=.*/fps=0 0/" /data/adb/modules/MiuiVariableThermal/config.conf
fi