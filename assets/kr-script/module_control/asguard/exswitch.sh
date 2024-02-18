#!/bin/sh
for var in $(echo ${exAS:-}); do
    result="$(dumpsys package ${var} | grep -s "ACCESSIBILITY_SERVICE" | sed 's/ /\n/g' | grep "${var}/" | sort | uniq)"
    if [[ -n "${result}" ]]; then
        result="$(echo "${result}" | sed "s:/\.:/${var}\.:g")"
        tmp="${tmp:-}${result} "
    fi
done
result="${tmp}"

source $asguard/ASGuard.conf; 
exclude_lines=$(echo -e "${exclude}" | sed 's/ /\n/g')
echo -e "${result}\n${exclude_lines}" | sed 's: :\\n:g' | sort | uniq