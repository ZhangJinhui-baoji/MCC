lu="/data/misc/apexdata/com.android.wifi"

cd "$lu" && {
    if [[ -f WifiConfigStore.xml ]]; then
        egrep '"SSID|"PreSharedKey' WifiConfigStore.xml | sed -r 's/&quot\;|<\/string>//g; s/<null .*"PreSharedKey".*/密码：无/g; s/.*="SSID">/\nWiFi名称：/g; s/<string .*"PreSharedKey">/密码：/g' | sed '1{/^$/d}'
    elif [[ -f wpa_supplicant.conf ]]; then
        ssid=( $(sed -n '/ssid="/=' wpa_supplicant.conf') )
        key=( $(sed -n '/key_mgmt=/=' wpa_supplicant.conf') )
        num=0

        for i in "${ssid[@]}"; do
            sed -n "$i,${key[$num]}p" wpa_supplicant.conf | egrep 'ssid="|psk="|key_mgmt=NONE' | sed -r 's/"$//g; s/.*ssid="/\nWiFi名称：/g; s/.*psk="/密码：/g; s/.*key_mgmt=NONE/密码：无/g' | sed '1{/^$/d}'
            num=$((num + 1))
        done
    else
        echo "未找到 WiFi 配置文件"
    fi
} || {
    echo "切换到 $lu 目录失败"
    lu="/data/misc/wifi"

    cd "$lu" && {
        if [[ -f WifiConfigStore.xml ]]; then
            egrep '"SSID|"PreSharedKey' WifiConfigStore.xml | sed -r 's/&quot\;|<\/string>//g; s/<null .*"PreSharedKey".*/密码：无/g; s/.*="SSID">/\nWiFi名称：/g; s/<string .*"PreSharedKey">/密码：/g' | sed '1{/^$/d}'
        elif [[ -f wpa_supplicant.conf ]]; then
            ssid=( $(sed -n '/ssid="/=' wpa_supplicant.conf') )
            key=( $(sed -n '/key_mgmt=/=' wpa_supplicant.conf') )
            num=0

            for i in "${ssid[@]}"; do
                sed -n "$i,${key[$num]}p" wpa_supplicant.conf | egrep 'ssid="|psk="|key_mgmt=NONE' | sed -r 's/"$//g; s/.*ssid="/\nWiFi名称：/g; s/.*psk="/密码：/g; s/.*key_mgmt=NONE/密码：无/g' | sed '1{/^$/d}'
                num=$((num + 1))
            done
        else
            echo "未找到 WiFi 配置文件"
        fi
    } || {
        echo "切换到 $lu 目录失败"
        echo "未找到 WiFi 配置文件"
    }
}