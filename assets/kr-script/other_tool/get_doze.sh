dumpsys deviceidle | grep -q Enabled=true
A=$?
if [[ $A = 0 ]]; then
    echo 1
else
    echo 0
fi
