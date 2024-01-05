repository="ZhangJinhui-baoji/MCC"

latest_release=$(curl -s "https://api.github.com/repos/$repository/releases/latest" | awk -F'"' '/"tag_name": ".+"/{print $4}')

if [ -z "$latest_release" ]; then
    echo "无法获取发行版信息"
else
    current_version="2023.12.28"
    if [ "$latest_release" != "$current_version" ]; then
        echo "发现新的发行版: $latest_release"
    else
        echo "当前已是最新版本: $current_version"
    fi
fi