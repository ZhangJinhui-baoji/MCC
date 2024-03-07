#!/system/bin/sh
MODDIR=${0%/*}

until [[ $(getprop sys.boot_completed) -eq 1 ]]; do
    sleep 2
done

sdcard_rw() {
    local test_file="/sdcard/Android/.TEST_FILE1"
    touch "$test_file"
    while [[ ! -f "$test_file" ]]; do
        touch "$test_file"
        sleep 1
    done
    rm "$test_file"
}

sdcard_rw

nohup sh "$MODDIR/main.sh" &
wait

until [[ $? == 0 ]]; do
    nohup sh "$MODDIR/main.sh" &
    sleep 1
    wait
done