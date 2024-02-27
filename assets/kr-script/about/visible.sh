directory="/data/data/module.config.control/files/kr-script/module_control/visible"
if [ ! -d "$directory" ]; then
    mkdir -p "$directory"
    file_names=("asguard" "uperf" "dfps" "qti" "asopt" "feas" "perapp-rs" "fas-rs" "QuantitativeStopCharging_switch" "MiuiVariableThermal" "Bypass_Charge" "A1Memory" "ram")
    for name in "${file_names[@]}"
    do
        filepath="$directory/$name"
        echo "echo 1" > "$filepath"
    done
fi