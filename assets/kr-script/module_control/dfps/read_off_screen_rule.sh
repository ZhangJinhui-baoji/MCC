awk '/^\-/ {sub(/^\-/, ""); print}' $dfps_path/dfps.txt