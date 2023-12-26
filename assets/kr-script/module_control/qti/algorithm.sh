function get_zram_device_path {
    zram_devices=$(ls /sys/block | grep "zram")

    for device in $zram_devices; do
        if [ -f "/sys/block/$device/comp_algorithm" ]; then
            echo "/sys/block/$device/comp_algorithm"
            return
        fi
    done

    echo ""
}

zram_path=$(get_zram_device_path)

if [ -z "$zram_path" ]; then
    echo "No ZRAM device found or comp_algorithm file not accessible"
else
    comp_algorithm=$(cat "$zram_path" | sed 's/\[//g; s/\]//g')
    echo "$comp_algorithm" | sed 's/ /\n/g'
fi