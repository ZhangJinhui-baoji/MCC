if [[ $state -eq 1 ]]; then
    dumpsys deviceidle enable
elif [[ $state -eq 0 ]]; then
    dumpsys deviceidle disable
fi

