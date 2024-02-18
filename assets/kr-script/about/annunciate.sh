USERNAME="ZhangJinhui-baoji"
REPO="MCC"
FILE_PATH="annunciate"

RAW_URL="https://raw.githubusercontent.com/$USERNAME/$REPO/main/$FILE_PATH"

file_content=$(curl --connect-timeout 3 --max-time 5 -s "$RAW_URL")

if [ -z "$file_content" ]; then
    echo "当前网络环境无法获取通告信息"
    echo "可能是由于你所处的地区github被DNS污染造成的"
    echo "你可以尝试查找一些防污染方法或直接通过魔法上网来解决"
else
    echo "$file_content"
fi