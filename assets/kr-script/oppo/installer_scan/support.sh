#!/system/bin/sh

# pm list packages -u com.oplus.appdetail
installed=`pm list packages -a com.oplus.appdetail`
if [[ -n "$installed" ]]
then
    echo 1
else
    echo 0
fi

