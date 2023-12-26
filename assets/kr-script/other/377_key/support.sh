key_377=`grep '^key 377' /system/usr/keylayout/gpio-keys.kl`
if [[ "$key_377" == "" ]]; then
    echo 0
else
    echo 1
fi
