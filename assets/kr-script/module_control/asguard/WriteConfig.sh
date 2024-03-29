conf=/sdcard/Android/ASGuard.conf
source $conf >/dev/null 2>&1
[ "$1" == 'AS' -o "$1" == 'package_whitelist' -o "$1" == 'exclude' -o "$1" == 'exAS' ] && eval "$1=\"\n$2\n\n\"" || eval "$1=\"$2\""
text() {
cat <<EOF
#面板日期：2022.04.14#作者：酷安@沍澤#QQ用户群：837934310#
#======================提示========================
#需要保护的APP包名请填在下面AS的" "内，一行一个！不要填在" "外面！否则无法正常运行！
#填在AS配置里的包名不需要填到package_Whitelist里面
AS="${AS:-}"

#排除名单包名(当运行模式为A时有效)
exAS="${exAS:-}"

#这个是电池优化白名单列表，开机后先清空电池优化百名单，再将列表内APP加入电池优化白名单，修改此项开机时生效
#一行一个包名，填在" "内！
package_whitelist="${package_whitelist:-}"

#模式运行周期时间(当运行模式为R/M时有效，默认为10，单位: M:秒 R:分)
CTime=${CTime:-10}

#是否开启log日志(开启/关闭: 1/0)
log=${log:-1}

#是否开机时关闭所有无障碍服务(开启/关闭: 1/0)
clean=${clean:-1}

#是否清空电池优化白名单(开启/关闭: 1/0)
WhitelistCleaner=${WhitelistCleaner:-0}

#运行模式(A/M/F/R)
#A(Auto): 自动管理开启相应无障碍功能无须配置AS即可使用
#M(Monitor): 监控无障碍服务的启用应用，将被关闭的无障碍服务重新开启
#F(Focus): 选择该模式在开机时不会自动打开无障碍服务，直到列表内的APP处于焦点窗口时若app未打开无障碍服务，则将其打开
#R(Refresh): 该模式为定时刷新的增强版，定时刷新开启状态
mode=${mode:-A}

#过滤无障碍开关
#名单内的无障碍将会被忽略
exclude="${exclude:-}"

#对于不同版本magisk(如正式版和lite版)安装路径略有不同，此用于定位模块安装目录的参数，请不要修改
MODPATH="${DIR}"

EOF
}
echo -e "$(text)" > ${conf}