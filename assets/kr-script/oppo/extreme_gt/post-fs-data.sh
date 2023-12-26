# 模块务必要处理文件权限，如：
# set_perm_recursive  $MODPATH  0  0  0755  0644

# 如果要将此脚本修改为 仅作用于当前模块或某一个模块，则可以将*替换为模块id
target_module="extreme_gt"

# 如果要替换为 MODDIR=${0%/*} 写法，需要改一些代码才行嘞
modules=/data/adb/modules

# post-fs-data 5s执行超时，不要太贪心哦
map_files() {
  local module=$1
  local dir=$2
  for file in $(ls $module/$dir)
  do
    local abs_path="$module/$dir/$file"
    if [[ -f "$abs_path" ]]; then
      if [[ -f "/$dir/$file" ]]; then
        echo "   > $module  $dir/$file"
        mount --bind "$abs_path" "/$dir/$file"
      else
        echo "   ! $module  $dir/$file"
      fi
      # mount --bind 
    elif [[ -d "$abs_path" ]]; then
      echo "   + $module  $dir/$file"
      map_files "$module" "$dir/$file"
    else
      # 正常应该不会有非文件又非目录的东西再这里
      # 遇到这个错误，应该是module和dir被当作全局变量了
      echo "???" "$abs_path"
    fi
  done
}

for module in $modules/$target_module
do
  # 遍历需要处理的特殊目录
  for dir in 'my_product' 'my_heytap' 'odm'
  do
    if [[ -d $module/$dir ]]; then
      echo ">> $module/$dir"
      map_files "$module" "$dir"
    fi
  done
done
