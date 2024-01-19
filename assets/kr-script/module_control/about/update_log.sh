repository="ZhangJinhui-baoji/MCC"

latest_release=$(curl --connect-timeout 3 --max-time 5 -s "https://api.github.com/repos/$repository/releases/latest" | awk -F'"' '/"tag_name": ".+"/{print $4}')

if [ -z "$latest_release" ]; then
    echo "无法获取发行版信息"
else
    current_version="2024.1.4"

    if [ "$latest_release" != "$current_version" ]; then
        echo "*发现新版本: $latest_release\n"

        changelog=$(curl --connect-timeout 3 --max-time 5 -s "https://api.github.com/repos/$repository/releases/latest" | awk -v RS='"body":' -F '"' 'NR>1 {print $2}')

        changelog=$(echo -e "$changelog")

        echo -e "更新日志：\n$changelog"
    else
        echo "当前已是最新版本: $current_version"
    fi
fi