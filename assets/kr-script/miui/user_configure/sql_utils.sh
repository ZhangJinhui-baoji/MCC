db_dir="/data/data/com.miui.powerkeeper/databases"
if [[ ! -f $db_dir/user_configure.db ]]; then
  echo '你好像已经把电量和性能(com.miui.powerkeeper)卸载了，所以这功能用不着了！' 1>&2
  exit
fi

if [[ $(type sqlite3 | grep  "/sqlite3") == "" ]];then
  if [[ -d "$TOOLKIT" ]];then
    wget -O "$TOOLKIT/sqlite3" https://vtools.oss-cn-beijing.aliyuncs.com/addin/sqlite3 2>/dev/null
    s=`du -k "$TOOLKIT/sqlite3"|awk '{print $1}'`
    if [[ "$s" -gt 256 ]]; then
      chmod 777 "$TOOLKIT/sqlite3" 2>/dev/null
    else
      rm "$TOOLKIT/sqlite3" 2>/dev/null
      echo '未能成功下载SQLite3组件！' 1>&2
      echo '你需要先安装一个Magisk模块([SQLite For ARM])以提供数据库修改功能！' 1>&2
      exit 0
    fi
  else
    echo '你需要先安装一个Magisk模块([SQLite For ARM])以提供数据库修改功能！' 1>&2
    exit
  fi
fi

# list_table[dbFile]
list_table(){
  sqlite3 $db_dir/$1.db 'SELECT name FROM sqlite_master'
}

# list_table[dbFile] [tableName]
list_table_fields(){
  sqlite3 $db_dir/$1.db "PRAGMA table_info('$2')"
}

alias user_configure="sqlite3 $db_dir/user_configure.db"
alias cloud_configure="sqlite3 $db_dir/cloud_configure.db"

# >> list_table user_configure
# android_metadata
# sqlite_sequence
# userTable
# sqlite_autoindex_userTable_1
# misc
# sqlite_autoindex_misc_1

# >> list_table_fields user_configure userTable
# 0|_id|INTEGER|0||1
# 1|userId|INTEGER|1|0|0
# 2|pkgName|TEXT|1||0
# 3|lastConfigured|INTEGER|0||0
# 4|bgControl|TEXT|1|'miuiAuto'|0
# 5|bgLocation|TEXT|0||0
# 6|bgDelayMin|INTEGER|0||0

# user_configure "select * from userTable"


# >> list_table_fields user_configure misc
# 0|_id|INTEGER|0||1
# 1|userId|INTEGER|1|0|0
# 2|name|TEXT|1||0
# 3|value|TEXT|0||0
# user_configure "select name,value from misc"
