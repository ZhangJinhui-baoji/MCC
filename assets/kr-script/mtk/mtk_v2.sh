import_utils="source $START_DIR/kr-script/mtk/mtk_utils_v2.sh;"
run="sh $START_DIR/kr-script/mtk"

perfmgr=/sys/module/mtk_fpsgo/parameters/perfmgr_enable
pandora_feas=/sys/module/perfmgr_mtk/parameters/perfmgr_enable
if [[ -f $pandora_feas ]]; then
  perfmgr=$pandora_feas
fi
fpsgo=/sys/kernel/fpsgo/common/fpsgo_enable
hybrid=/data/adb/modules/dimensity_hybrid_governor

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
switch_full() {
    echo "      <switch title=\"$1\" desc=\"$2\">"
    echo "          <get>$3</get>"
    echo "          <set>$4</set>"
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


soc=$(getprop ro.hardware)
gpu_render() {
    if [[ "$soc" == "mt6983" || "$soc" == "mt6895" ]]; then
        if [[ "$soc" == "mt6983" ]]; then
          volt_list="62500 61875 61875 61250 60625 60000 59375 58750 58125 57500 56875 56250 55625 55000 54375 53750 53125 52500 51875 51250 50625 50000"
        else
          volt_list="62500 61875 61875 61250 60625 60000 59375 58750 58125 57500 56875 56250 55625 55000 54375 53750 53125 52500 51875 51250 50625 50000 49375 48750 48125 47500 46875 46250 45625 45000 44375 43750 43125 42500 41875"
        fi
        echo "      <action title=\"固定频率\" shell=\"hidden\" reload=\"@GPU\" summary-sh=\"$import_utils gpu_freq_cur_khz2\">"
        echo '          <param title="频率" name="state" value-sh="'$import_utils gpu_freq_cur'">'
        echo "            <option value=\"-1\">不固定</option>"
        for freq in $(cat /proc/gpufreqv2/stack_signed_opp_table | awk '{printf $3 "\n"}' | cut -f1 -d ",")
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
        echo "      <picker title=\"固定频率\" shell=\"hidden\" reload=\"@GPU\" summary-sh=\"$import_utils gpu_freq_cur_khz\">"
        echo "          <options>"
        echo "            <option value=\"-1\">不固定</option>"
        for freq in $(cat /proc/gpufreqv2/stack_signed_opp_table | awk '{printf $3 "\n"}' | cut -f1 -d ",")
        do
          echo "            <option value=\"$freq\">${freq}KHz</option>"
        done
        echo "          </options>"
        echo "          <get>$import_utils gpu_freq_cur</get>"
        echo "          <set>$import_utils gpu_freq</set>"
        echo "      </picker>"
    fi

    echo "      <picker title=\"最高频率\" shell=\"hidden\" reload=\"@GPU\" summary-sh=\"$import_utils gpu_freq_max_freq_cur_khz\">"
    echo "          <options>"
    cat /proc/gpufreqv2/stack_signed_opp_table | while read freq
    do
      echo "            <option value=\"$(echo ${freq:1:2})\">$(echo $freq | awk '{printf $3 "\n"}' | cut -f1 -d ",")KHz</option>"
    done
    echo "          </options>"
    echo "          <get>$import_utils gpu_freq_max_freq_cur</get>"
    echo "          <set>$import_utils gpu_freq_max_freq</set>"
    echo "      </picker>"
    echo "<text><slice>[固定频率]优先级高于[最高频率]，且不可同时设置</slice></text>"

    dcs_mode=/sys/kernel/ged/hal/dcs_mode
    if [[ -f $dcs_mode ]]; then
      switch_full "DCS Policy" '在GPU性能需求降低时，关闭部分核心以减少耗电。但开启此特性，有时GPU频率会在最低/最高之间反复跳动。' "if [[ \$(grep enable $dcs_mode) != '' ]]; then echo 1; fi" "$import_utils set_dcs_mode"
    fi

    ged_kpi=/sys/module/sspm_v3/holders/ged/parameters/is_GED_KPI_enabled
    if [[ -f $ged_kpi ]]; then
      switch_full "GED KPI" '抑制性能以减少耗电，但在游戏中可能会导致卡顿' "cat $ged_kpi" "$import_utils set_ged_kpi"
    fi

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

common_render() {
  if [[ -f $fpsgo ]]; then
    switch_full "FPSGO Enable" '根据实时帧率抑制或提升性能，以减少耗电或提高帧率稳定性。但开启此特性，可能会出现持续的小幅度掉帧' "cat $fpsgo" "$import_utils set_fpsgo"
  fi

  if [[ -f $perfmgr ]]; then
    echo "      <switch title=\"Perfmgr Enable\" desc=\"FEAS通过Perfmgr实现，启用该特性可以在某些游戏中大幅降低功耗\" reload=\"page\">"
    echo "          <get>cat $perfmgr</get>"
    echo "          <set>$import_utils set_perfmgr</set>"
    echo "      </switch>"
  fi
}

ddr_render() {
  dir='/sys/devices/platform/1c00f000.dvfsrc'
  if [[ -d /sys/devices/platform/soc/1c00f000.dvfsrc ]]; then
    dir='/sys/devices/platform/soc/1c00f000.dvfsrc'
  fi
  dvfsrc=${dir}/mtk-dvfsrc-devfreq/devfreq/mtk-dvfsrc-devfreq
  opp_table=$dvfsrc/available_frequencies
  echo "      <picker id=\"DDR-MIN-FREQ\" title=\"DDR MinFreq\" shell=\"hidden\" reload=\"@DRAM\">"
  echo "          <options>"
  echo "            <option value=\"0\">Default</option>"
  for freq in $(cat $opp_table)
  do
    if [[ "$freq" != "" ]]; then
    echo "            <option value=\"$freq\">${freq}hz</option>"
    fi
  done
  echo "          </options>"
  echo "          <set>$import_utils ddr_freq</set>"
  echo "          <get>cat $dvfsrc/min_freq</get>"
  echo "      </picker>"


  # 无意义
  if [[ -d /sys/devices/platform/soc/1c00f000.dvfsrc ]]; then
    dir='/sys/devices/platform/soc/1c00f000.dvfsrc'
  else
    dir='/sys/devices/platform/1c00f000.dvfsrc'
  fi
  dvfsrc2=${dir}/1c00f000.dvfsrc:dvfsrc-helper
  opp_table=$dvfsrc2/dvfsrc_opp_table
  echo "      <picker title=\"固定DDR频率\" summary=\"如果电压过低，会死机！！！大多时候，固定频率并无意义，仅做对比测试时使用\" shell=\"hidden\" reload=\"@DRAM\">"
  echo "          <options>"
  echo "            <option value=\"999\">不固定</option>"
  grep '\[OPP' $opp_table | while read freq
  do
    if [[ "$freq" != "" ]]; then
    d_opp=$(echo "${freq:4:2}")
    d_khz=$(echo ${freq:9})
    echo "            <option value=\"$(echo -n $d_opp)\">${d_khz}</option>"
    fi
  done
  echo "          </options>"
  echo "          <set>$import_utils ddr_freq_fixed</set>"
  echo "      </picker>"
}

xml_start
  resource 'file:///android_asset/kr-script/common'
  resource 'file:///android_asset/kr-script/mtk'

if [[ -f /proc/gpufreqv2/stack_signed_opp_table ]]
then
  group_start 'GPU'
    gpu_render
  group_end
fi

group_start 'FPSGO/FEAS'
  common_render
group_end

group_start 'DRAM'
  ddr_render
group_end

xml_end
