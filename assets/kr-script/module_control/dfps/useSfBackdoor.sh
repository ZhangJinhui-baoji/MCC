useSfBackdoor=$(grep '/useSfBackdoor' /sdcard/Android/yc/dfps/dfps.txt | awk '{print $2}')

if [ "$useSfBackdoor" -eq 0 ]; then
    echo "PEAK_REFRESH_RATE"
elif [ "$useSfBackdoor" -eq 1 ]; then
    echo "Surfaceflinger backdoor"
fi