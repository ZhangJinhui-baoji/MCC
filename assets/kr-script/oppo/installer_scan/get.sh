#!/system/bin/sh

installed=`pm list packages com.oplus.appdetail`
if [[ -n "$installed" ]]
then
  echo 1
else
  echo 0
fi
