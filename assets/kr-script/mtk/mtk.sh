import_utils="source $START_DIR/kr-script/mtk/mtk_utils.sh;"
run="sh $START_DIR/kr-script/mtk"

xml_start() {
    echo '<?xml version="1.0" encoding="UTF-8" ?>'
    echo "<root>"
}
xml_end() {
    echo "</root>"
}
resource() {
    echo "  <resource dir=\"$1\" />"
}
group_start() {
    echo "  <group id=\"@$1\" title=\"$1\">"
}
group_end() {
    echo "  </group>"
}
switch() {
    echo "      <switch title=\"$1\">"
    echo "          <get>$2</get>"
    echo "          <set>$3</set>"
    echo "      </switch>"
}
switch_hidden() {
    echo "      <switch title=\"$1\" shell=\"hidden\" >"
    echo "          <get>$2</get>"
    echo "          <set>$3</set>"
    echo "      </switch>"
}

action() {
    echo "      <action confirm=\"true\" title=\"$1\">"
    echo "          <desc>$2</desc>"
    echo "          <set>$3</set>"
    echo "      </action>"
}

get_row_id() {
  local row_id=`echo $1 | cut -f1 -d ']'`
  echo ${row_id/[/}
}
get_row_title() {
    echo $1 | cut -f2 -d ' ' | cut -f1 -d ':'
}
get_row_state() {
    echo $1 | cut -f2 -d ':'
}

ppm_render() {
    switch_hidden "启用PPM" "state=\`cat /proc/ppm/enabled | grep enabled\`; if [[ \$state != '' ]]; then echo 1; fi" "echo \$state > /proc/ppm/enabled"

    path="/proc/ppm/policy_status"
    cat $path | grep 'PPM_' | while read line
    do
      id=`get_row_id "$line"`
      title=`get_row_title "$line"`
      state=`get_row_state "$line"`
      # echo $id $title $state
      switch_hidden "$title" "cat $path | grep $title | grep enabled 1>&amp;2 > /dev/null &amp;&amp; echo 1" "echo $id \$state > $path"
    done
}

ged_render() {
    local ged="/sys/module/ged/parameters"
    ls -1 $ged | grep -v "log" | grep -v "debug" | grep -E "enable|_on|mode" | while read line
    do
      # echo $line
      local title="$line"
      if [[ "$line" == "gpu_dvfs_enable" ]]; then
        title="动态调频调压"
      elif [[ "$line" == "ged_force_mdp_enable" ]]; then
        title="强制使用MDP"
      elif [[ "$line" == "gx_game_mode" ]]; then
        title="游戏模式"
      else
        continue # 有些效果不佳的选项，暂时隐藏掉
      fi
      switch_hidden "$title" "cat $ged/$line" "echo \$state > $ged/$line"
    done
}

soc=$(getprop ro.hardware)
gpu_render() {
    if [[ "$soc" == "mt6891" || "$soc" == "mt6893" ]]; then
      volt_list="65000 64375 63750 63125 62500 61875 61875 61250 60625 60000 59375 58750 58125 57500 56875 56250 55625 55000 54375 53750 53125 52500 51875 51250 50625 50000 49375 48750 48125 47500 46875 46250 45625 45000 44375 43750"
        echo "      <action title=\"固定频率\" shell=\"hidden\" reload=\"@GPU\" summary-sh=\"$import_utils gpu_freq_cur_khz\">"
        echo '          <param title="频率" name="state" value-sh="'$import_utils gpu_freq_cur'">'
        echo "            <option value=\"0\">不固定</option>"
        for freq in $(cat /proc/gpufreq/gpufreq_opp_dump | awk '{printf $4 "\n"}' | cut -f1 -d ",")
        do
          echo "            <option value=\"$freq\">${freq}KHz</option>"
        done
        echo "          </param>"
        echo '          <param title="电压" name="voltage" value-sh="'$import_utils gpu_volt_cur'">'
        echo "            <option value=\"-1\">不固定</option>"
        for voltage in $volt_list
        do
          echo "            <option value=\"$voltage\">${voltage}</option>"
        done
        echo "          </param>"
        echo "          <set>$import_utils gpu_freq</set>"
        echo "      </action>"
    else
        # local freqs=$(cat /proc/gpufreq/gpufreq_opp_dump | awk '{printf $4 "\n"}' | cut -f1 -d ",")
        local get_shell="cat /proc/gpufreq/gpufreq_opp_freq | grep freq | awk '{printf \$4 \"\\\\n\"}' | cut -f1 -d ','"

        echo "      <picker title=\"固定频率\" shell=\"hidden\" reload=\"@GPU\" summary-sh=\"$import_utils gpu_freq_cur_khz\">"
        echo "          <options>"
        echo "            <option value=\"0\">不固定</option>"
        for freq in $(cat /proc/gpufreq/gpufreq_opp_dump | awk '{printf $4 "\n"}' | cut -f1 -d ",")
        do
          echo "            <option value=\"$freq\">${freq}KHz</option>"
        done
        echo "          </options>"
        echo "          <get>$get_shell</get>"
        echo "          <set>$import_utils gpu_freq</set>"
        echo "      </picker>"
    fi
    echo "      <picker title=\"最高频率\" shell=\"hidden\" reload=\"@GPU\" summary-sh=\"$import_utils gpu_freq_max_freq_cur_khz\">"
    echo "          <options>"
    for freq in $(cat /proc/gpufreq/gpufreq_opp_dump | awk '{printf $4 "\n"}' | cut -f1 -d ",")
    do
      echo "            <option value=\"$freq\">${freq}KHz</option>"
    done
    echo "          </options>"
    echo "          <get>$import_utils gpu_freq_max_freq_cur</get>"
    echo "          <set>$import_utils gpu_freq_max_freq</set>"
    echo "      </picker>"


    local dvfs=/proc/mali/dvfs_enable
    if [[ -f $dvfs ]]; then
      switch_hidden "动态调频调压(DVFS)" "cat $dvfs | cut -f2 -d ' '" "echo \$state > $dvfs"
    fi

    if [[ -d '/data/adb/modules/dimensity_hybrid_governor' ]]; then
    switch_hidden 'GPU混合调频器(降压)' 'if [[ $(pidof gpu-scheduler) != "" ]]; then echo 1;fi' "$import_utils dimensity_hybrid_switch"
    else
    echo "\
    <action shell=\"hidden\">\
        <title>获取GPU混合调频器(降压)</title>\
        <desc>下载和使用GPU/DDR辅助调频器，也许能降低GPU高负载场景功耗，但它并不总是如此！</desc>\
        <set>am start -a android.intent.action.VIEW -d https://vtools.oss-cn-beijing.aliyuncs.com/addin/dimensity_hybrid_governor.zip</set>\
        <summary sh=\"if [[ '$(pidof gpu-scheduler)' != '' ]]; then echo '正在运行中';fi\" />\
    </action>"
    fi
}

cpu_render() {
    if [[ -f /sys/devices/system/cpu/sched/sched_boost ]]; then
      echo "      <picker title=\"Sched Boost\" shell=\"hidden\">"
      echo "          <options>"
      echo "            <option value=\"no boost\">no boost</option>"
      echo "            <option value=\"all boost\">all</option>"
      echo "            <option value=\"foreground boost\">foreground</option>"
      echo "          </options>"
      echo "          <get>$import_utils sched_boost_get</get>"
      echo "          <set>$import_utils sched_boost_set</set>"
      echo "      </picker>"
    fi

    if [[ -f /sys/devices/system/cpu/eas/enable ]]; then
      echo "      <picker title=\"Eas Enable\" shell=\"hidden\">"
      echo "          <options>"
      echo "            <option value=\"HMP\">HMP</option>"
      echo "            <option value=\"EAS\">EAS</option>"
      echo "            <option value=\"hybrid\">Hybrid</option>"
      echo "          </options>"
      echo "          <get>$import_utils eas_get</get>"
      echo "          <set>$import_utils eas_set</set>"
      echo "      </picker>"
    fi
}

ddr_render() {
  dvfsrc=/sys/devices/platform/10012000.dvfsrc/helio-dvfsrc
  opp_table=$dvfsrc/dvfsrc_opp_table
  echo "      <picker title=\"固定DDR频率\" summary=\"如果电压过低，会死机！！！\" shell=\"hidden\" reload=\"@DRAM\">"
  echo "          <options>"
  echo "            <option value=\"-1\">不固定</option>"
  cat $opp_table | while read freq
  do
    if [[ "$freq" != "" ]]; then
    d_opp=$(echo "${freq:4:2}")
    d_khz=$(echo ${freq:9})
    echo "            <option value=\"$d_opp\">${d_khz}</option>"
    fi
  done
  echo "          </options>"
  echo "          <set>$import_utils ddr_freq</set>"
  echo "      </picker>"
}

# 显存占用 bytes
# cat /proc/mali/memory_usage | grep "Total" | cut -f2 -d "(" | cut -f1 -d " "

xml_start
    resource 'file:///android_asset/kr-script/common'
    resource 'file:///android_asset/kr-script/mtk'
    group_start 'PPM'
        ppm_render
    group_end

    # group_start 'GED'
    #     ged_render
    # group_end

if [[ -f /proc/gpufreq/gpufreq_opp_freq ]]
then
    group_start 'GPU'
      gpu_render
    group_end
fi


group_start 'CPU'
  cpu_render
group_end

if [[ -f /sys/devices/platform/10012000.dvfsrc/helio-dvfsrc/dvfsrc_force_vcore_dvfs_opp ]]; then
group_start 'DRAM'
  ddr_render
group_end
fi

if [[ -f /proc/eem/EEM_DET_L/eem_offset ]]; then
group_start 'Voltage Offset'

# Little
if [[ -f /proc/eem/EEM_DET_L/eem_offset ]]; then
echo '  <action title="Little Cores" shell="hidden" summary-sh="cat /proc/eem/EEM_DET_L/eem_offset">'
echo '      <param name="value" value-sh="cat /proc/eem/EEM_DET_L/eem_offset" type="seekbar" min="-50" max="50" />'
echo "      <set>$import_utils eem_offset L \$value</set>"
echo '  </action>'
fi

# Middle
if [[ -f /proc/eem/EEM_DET_BL/eem_offset ]]; then
echo '  <action title="Middle Cores" shell="hidden" summary-sh="cat /proc/eem/EEM_DET_BL/eem_offset">'
echo '      <param name="value" value-sh="cat /proc/eem/EEM_DET_BL/eem_offset" type="seekbar" min="-50" max="50" />'
echo "      <set>$import_utils eem_offset BL \$value</set>"
echo '  </action>'
fi

# Big
if [[ -f /proc/eem/EEM_DET_B/eem_offset ]]; then
echo '  <action title="Big Cores" shell="hidden" summary-sh="cat /proc/eem/EEM_DET_B/eem_offset">'
echo '      <param name="value" value-sh="cat /proc/eem/EEM_DET_B/eem_offset" type="seekbar" min="-50" max="50" />'
echo "      <set>$import_utils eem_offset B \$value</set>"
echo '  </action>'
fi

# CCI
if [[ -f /proc/eem/EEM_DET_CCI/eem_offset ]]; then
echo '  <action title="CCI" shell="hidden" summary-sh="cat /proc/eem/EEM_DET_CCI/eem_offset">'
echo '      <param name="value" value-sh="cat /proc/eem/EEM_DET_CCI/eem_offset" type="seekbar" min="-50" max="50" />'
echo "      <set>$import_utils eem_offset CCI \$value</set>"
echo '  </action>'
fi

# GPU
if [[ -f /proc/eemg/EEMG_DET_GPU/eemg_offset ]]; then
echo '  <action title="GPU" shell="hidden" summary-sh="cat /proc/eemg/EEMG_DET_GPU/eemg_offset">'
echo '      <param name="value" value-sh="cat /proc/eemg/EEMG_DET_GPU/eemg_offset" type="seekbar" min="-50" max="50" />'
echo "      <set>$import_utils eemg_offset GPU \$value</set>"
echo '  </action>'
fi

# GPU_HI
if [[ -f /proc/eemg/EEMG_DET_GPU_HI/eemg_offset ]]; then
echo '  <action title="GPU HI" shell="hidden" summary-sh="cat /proc/eemg/EEMG_DET_GPU_HI/eemg_offset">'
echo '      <param name="value" value-sh="cat /proc/eemg/EEMG_DET_GPU_HI/eemg_offset" type="seekbar" min="-50" max="50" />'
echo "      <set>$import_utils eemg_offset GPU_HI \$value</set>"
echo '  </action>'
fi

if [[ -n "$MAGISK_PATH" ]] && [[ -d "$MAGISK_PATH" ]]
then
echo '  <action title="[Magisk]Automatic apply" summary-sh="'$import_utils' eem_module_summary" desc="Keep the current adjustment after restarting the phone\n手机重启后保留当前参数">'
echo "      <set>$run/install_eem_module.sh</set>"
echo '  </action>'
fi
group_end
fi


if [[ -n "$MAGISK_PATH" ]] && [[ -d "$MAGISK_PATH" ]]
then
  group_start 'PowerPolicy'
    powerscntbl=/system/vendor/etc/powerscntbl.xml
    if [[ -f $powerscntbl ]]; then
      if [[ $(grep 'powerhint' $powerscntbl) != "" ]]; then
        action "禁用场景升频" "禁用场景升频，这有助于你手动控制处理器性能，但会显著降低反应速度" "$run/powerscntbl_remove.sh"
      else
        action "启用场景升频" "恢复场景升频，恢复后需要立即重启手机" "$run/powerscntbl_restore.sh"
      fi
    fi
    power_app_cfg=/system/vendor/etc/power_app_cfg.xml
    if [[ -f $power_app_cfg ]]; then
      if [[ $(grep '<Package name' $power_app_cfg) != "" ]]; then
        action "禁用AppConfig" "禁用AppConfig(按应用/Activity调节的性能策略)，这有助于你手动控制处理器性能，但也可能在某些时候降低性能" "$run/power_app_cfg_remove.sh"
      else
        action "启用AppConfig" "恢复AppConfig(按应用/Activity调节的性能策略)" "$run/power_app_cfg_restore.sh"
      fi
    fi
  group_end
fi

group_start '电池统计'
    if [[ -f /sys/devices/platform/battery/reset_battery_cycle ]]
    then
      action "清空电池循环计数" "将手机统计的电池循环次数归零（这并不会恢复电池容量）" "echo 1 &gt; /sys/devices/platform/battery/reset_battery_cycle"
    fi

    if [[ -f /sys/devices/platform/battery/reset_aging_factor ]]
    then
      action "清空电池老化率" "将手机统计的电池老化率数值清空（并不会恢复电池寿命，重置此值可能导致低电量时突然关机！）" "echo 1 &gt; /sys/devices/platform/battery/reset_aging_factor"
    fi
group_end


group_start 'Thermal'
echo "      <picker reload=\"@Thermal\" options-sh=\"ls -a /vendor/etc/.tp | grep -E 'conf|mtc|thermal'\" title=\"Profile\" desc=\"切换温控策略配置，选择ht120可能会过热重启！\" shell=\"hidden\">"
echo "          <set>$import_utils thermal_profile</set>"
echo "      </picker>"

echo "      <switch title=\"SSPM Thermal Throttle\" shell=\"hidden\" desc=\"开启此选项会使一些自动降频行为失效，可能导致设备过热损坏或突然重启\" reload=\"@Thermal\">"
echo "          <get>cat /proc/driver/thermal/sspm_thermal_throttle | cut -f2 -d ':'</get>"
echo "          <set>$import_utils sspm_thermal_throttle</set>"
echo "      </switch>"

platform=$(getprop ro.board.platform)
if [[ "$platform" == "mt6893" ]] || [[ "$platform" == "mt6891" ]] || [[ "$platform" == "mt6885" ]] || [[ "$platform" == "mt6875" ]];then
echo "      <switch title=\"Thermal UltraLimit\" desc=\"将CPU过热关机温度(默认120°C)提高到145°C，可能导致设备过热损坏!!!\" reload=\"@Thermal\">"
echo "          <get>$import_utils ultra_limit_get</get>"
echo "          <set>$import_utils ultra_limit_set</set>"
echo "      </switch>"
fi
group_end


xml_end
