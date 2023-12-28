FAS-RS

简介
假如肉眼看到的画面能直接反映在调度上, 也就是说以把调度器放在观看者的角度来决定性能, 是否就能实现完美的性能控制和最大化体验? FAS(Frame Aware Scheduling)就是这种调度概念, 通过监视画面渲染来尽量控制性能以在保证渲染时间的同时实现最小化开销

什么是fas-rs?
fas-rs是运行在用户态的FAS(Frame Aware Scheduling)实现, 对比核心思路一致但是在内核态的MI FEAS有着近乎在任何设备通用的兼容性和灵活性方面的优势
对比其它用户态FAS实现(如scene fas), fas-rs采用了侵入性更强的inline hook方法获取渲染时间, 这带来了更准确的数据和更小的开销, 然而这本质上是注入, 可能被反作弊系统误判断, 虽然我还没遇到过

自定义(配置)
配置路径：/sdcard/Android/magisk/fas-rs/games.toml

参数(config)说明：
keep_std

类型：Bool
true：永远在配置合并时保持标准配置的profile, 保留本地配置的应用列表, 其它地方和false相同 *
false：见配置合并的默认行为
*：默认配置

游戏列表(game_list)说明：
"package" = target_fps

package：字符串, 应用包名
target_fps：一个数组(如[30, 60, 120, 144])或者单个整数, 表示游戏会渲染到的目标帧率, fas-rs会在运行时动态匹配

powersave / balance / performance / fast 说明：

mode：
目前fas-rs还没有官方的切换模式的管理器, 而是接入了scene的配置接口, 如果你不用scene则默认使用balance的配置
如果你有在linux上编程的一些了解, 向/dev/fas_rs/mode节点写入4模式中的任意一个即可切换到对应模式, 同时读取它也可以知道现在fas-rs所处的模式

参数说明(暂无)：

games.toml配置标准例：
[config]
keep_std = true

[game_list]
"com.hypergryph.arknights" = [30, 60]
"com.miHoYo.Yuanshen" = [30, 60]
"com.miHoYo.enterprise.NGHSoD" = [30, 60, 90]
"com.miHoYo.hkrpg" = [30, 60]
"com.mojang.minecraftpe" = [60, 120]
"com.netease.party" = [30, 60]
"com.shangyoo.neon" = 60
"com.tencent.tmgp.pubgmhd" = [60, 90, 120]
"com.tencent.tmgp.sgame" = [30, 60, 90, 120]

# 目前没有可以配置的东西，但是还是预留着
[powersave]

[balance]

[performance]

[fast]

配置合并
fas-rs内置配置合并系统, 来解决未来的配置功能变动问题。它的行为如下
删除本地配置中, 标准配置不存在的配置
插入本地配置缺少, 标准配置存在的配置
保留标准配置和本地配置都存在的配置
注意
使用自动序列化和反序列化实现, 无法保存注释等非序列化必须信息
安装时的自动合并配置不会马上应用，不然可能会影响现版本运行，而是会在下一次重启时用合并后的新配置替换掉本地的
手动合并
模块每次安装都会自动调用一次
手动例
fas-rs --merge --local-profile /path/to/local/config --std-profile /path/to/std/config

Uperf v3支持
fas-rs支持使用uperf-v3替代系统调速器在非fas场景生效
但是, 必须使用特殊修改过的的uperf-v3来实现这一点，其它任何版本(包括官方版本)都不支持