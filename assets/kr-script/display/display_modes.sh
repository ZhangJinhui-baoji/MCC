# v1
# i=0
# dumpsys display | grep 'DisplayInfo=.*modes' | head -1 | cut -f2 -d '['| cut -f1 -d ']' | tr "}" "\n" | cut -f2 -d '{' | while read row
# do
#   if [[ -n "$row" ]]; then
#     text=$(echo ${row:12})
#     text=$(echo ${text/, height=/x})
#     text=$(echo ${text/, fps=/' '} | cut -f1 -d '.')
#     echo "$i"'|'${text}Hz
#     i=$((i+1))
#   fi
# done

ANDROID_SDK=`getprop ro.build.version.sdk`

if [[ "$ANDROID_SDK" -gt 30 ]]
then
  # v3
  dumpsys display | grep -A 24 'mSfDisplayModes=' | grep ' DisplayMode{id=' | cut -f2 -d '{' | while read row
  do
    if [[ -n "$row" ]]; then
      echo $row | tr "," "\n" | while read col
      do
        # echo $col
        case "$col" in
          "id="*)
            echo -n $(echo ${col:3}'|')
          ;;
          "width="*)
            echo -n $(echo ${col:6})
          ;;
          "height="*)
            echo -n x$(echo ${col:7})
          ;;
          "refreshRate="*)
            echo ' '$(echo ${col:12} | cut -f1 -d '.')Hz
          ;;
        esac
      done
    fi
  done
else
  # v2
  i=0
  dumpsys display | grep -A 1 'mSupportedModesByDisplay' | tail -1 | tr "}" "\n" | cut -f2 -d '{' | while read row
  do
    if [[ -n "$row" ]]; then
      echo -n "$i|"
      echo $row | tr "," "\n" | while read col
      do
        # echo $col
        case "$col" in
          "width="*)
            echo -n $(echo ${col:6})
          ;;
          "height="*)
            echo -n x$(echo ${col:7})
          ;;
          "fps="*)
            echo ' '$(echo ${col:4} | cut -f1 -d '.')Hz
          ;;
        esac
      done
      i=$((i+1))
    fi
  done
fi

