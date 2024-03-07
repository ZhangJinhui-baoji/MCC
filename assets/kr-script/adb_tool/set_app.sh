if [[ $app = Scene ]]; then
    echo "正在激活 Scene ADB模式"
    adb shell sh /sdcard/Android/data/com.omarea.vtools/up.sh
    
elif [[ $app = HeiYu ]]; then
    echo "正在激活 黑阈"
    adb shell sh /data/data/me.piebridge.brevent/brevent.sh
    
elif [[ $app = XiaoHeiWu ]]; then
    echo "正在激活 小黑屋"
    adb shell sh /sdcard/Android/data/web1n.stopapp/files/demon.sh
    
elif [[ $app = Shizuku ]]; then
    echo "正在激活 Shizuku"
    adb shell sh /sdcard/Android/data/moe.shizuku.privileged.api/files/start.sh || adb shell sh /storage/emulated/0/Android/data/moe.shizuku.privileged.api/start.sh
    
elif [[ $app = IceBox ]]; then
    echo "正在激活 冰箱"
    adb shell sh /sdcard/Android/data/com.catchingnow.icebox/files/start.sh
    
elif [[ $app = IceBox ]]; then
    echo "正在使用快否激活器激活「快否」"
    adb shell sh /storage/emulated/0/Android/data/cn.endureblaze.activatebenchaf/files/Run.sh
    
elif [[ $app = PermissionDog ]]; then
    echo "正在激活 权限狗 AppOps"
    adb shell sh /storage/emulated/0/Android/data/com.web1n.permissiondog/files/starter.sh
fi
