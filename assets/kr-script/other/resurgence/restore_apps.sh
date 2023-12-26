restore_apps() {
  restrictions=/data/system/users/0/package-restrictions.xml
  sed -i 's/hidden="true"/hidden="false"/g' $restrictions | grep daemon
  sed -i 's/inst="false"/inst="true"/g' $restrictions | grep daemon
  sed -i 's/enabled="2"/enabled="1"/g' $restrictions | grep daemon
  chown system:system $restrictions
}

restore_apps
