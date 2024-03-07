module_prop="/data/adb/modules/asoul_affinity_opt/module.prop"

if [ -f "$module_prop" ]; then
    installed_version=$(grep '^version=' "$module_prop" | cut -d'=' -f2)
    echo "已安装，模块版本：$installed_version"
else
    echo "未安装"
fi