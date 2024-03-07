echo "ip=$ip" >"$START_DIR/kr-script/adb_tool/ip_port"
echo "port=$port" >>"$START_DIR/kr-script/adb_tool/ip_port"
echo "- 当前输入IP：$ip"
echo "- 当前输入端口：$port"
echo "- 当出现USB授权弹窗时，请确定USB调试，授权过的无需再次授权"
adb connect $ip:$port