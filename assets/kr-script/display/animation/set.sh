if [[ $w == "" ]]; then
    settings put global window_animation_scale 1
fi
if [[ $transition == "" ]]; then
    settings put global transition_animation_scale 1
fi
if [[ $animator == "" ]]; then
    settings put global animator_duration_scale 1
fi
if [[ $duration_ratio == "" ]]; then
    settings put global transition_animation_duration_ratio 1
fi

settings put global window_animation_scale $w
settings put global transition_animation_scale $transition
settings put global animator_duration_scale $animator
settings put global transition_animation_duration_ratio $duration_ratio
echo 'OK!'
