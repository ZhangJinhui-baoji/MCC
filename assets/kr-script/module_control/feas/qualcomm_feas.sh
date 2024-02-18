path=/sys/module/perfmgr/parameters/perfmgr_enable
chmod 777 $path
echo $state > $path
if [[ "$state" == "1" ]]; then
chmod 444 $path
fi