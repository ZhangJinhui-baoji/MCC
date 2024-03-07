rm -f /data/data/module.config.control/files/kr-script/module_control/visible/*
mkdir -p /data/data/module.config.control/files/kr-script/module_control/visible/
file_names=(${state//,/ })
for name in "${file_names[@]}"
do
    filename="${name}"
    echo "echo 1" > "/data/data/module.config.control/files/kr-script/module_control/visible/$filename"
done
am force-stop $PACKAGE_NAME;am start -n $PACKAGE_NAME/$PACKAGE_NAME.SplashActivity