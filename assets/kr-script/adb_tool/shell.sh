shell="$START_DIR/kr-script/adb_tool/shell"
echo "$CMD" >$shell

echo -e "- 当前输入的命令：\n"
cat $shell
echo -e "\n----------\n"
echo -e "- 执行结果：\n"
. $shell
echo -e "\n----------\n"
