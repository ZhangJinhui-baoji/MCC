# source ${0%/*}/sql_utils.sh

source ./kr-script/miui/user_configure/sql_utils.sh

cloud_configure "delete from ThermalInfo"
cloud_configure "delete from TrackTable"

# fps_group='{"list60":"com.android.soundrecorder,com.android.camera,com.autonavi.minimap,com.tencent.map,com.sogou.map.android.maps,com.sdu.didi.psnger,com.dingda.app,com.mobike.mobikeapp,com.jingyao.easybike,com.cmcc.cmvideo,com.taobao.litetao,com.zybang.parent,com.baidu.BaiduMap"}'
fps_group='{"list60":"","list90":""}'
user_configure "update misc set value = '$fps_group' where name = 'fps_group'"

# fps_top_video_pkg='com.tencent.qqlive,tv.danmaku.bili,com.tencent.qqlive,tv.danmaku.bili,com.ss.android.ugc.live,com.miui.videoplayer,com.smile.gifmaker,com.kuaishou.nebula,com.ss.android.ugc.aweme,com.youku.phone,com.pplive.androidphone,com.ss.android.article.video,tv.pps.mobile,com.sesame.video,com.all.video,com.cmcc.cmvideo,com.ss.android.ugc.livelite,com.sgn.popcornmovie,com.storm.smart,cn.cntv,com.baidu.haokan,com.doudou.ysvideo,com.zhongduomei.rrmj.society,com.hunantv.imgo.activity,dopool.player,com.sohu.sohuvideo,com.ztsoft.xplayer,com.korean.tv,com.m1905.mobilefree,com.shg.shadow.ying,com.kandian.cartoonapp,com.duowan.kiwi,com.tudou.android,com.funshion.video.mobile,com.dianshijia.newlive,com.letv.android.client,com.clov4r.android.nil,com.xgyybfq.uc.va,com.sup.android.superb,com.kmplayer,com.xiaodutv.bdysvideo,cn.com.dy.mm,com.rumtel.mobiletv,com.kandian.vodapp,org.fungo.fungolive,cn.vcinema.cinema,com.ztsoft.tvlive,com.nacai.taose,com.mxtech.videoplayer.ad,com.rumtel.pandatv,net.tvfanqie.video,vmovier.com.activity,com.pplive.androidphone.sport,com.tencent.research.drop,com.now.video,com.xunlei.kankan,com.melot.meshow,com.quanwang.videos,com.ifeng.newvideo,com.kwai.thanos,cn.v6.sixrooms,com.sljh.zqxsp,com.danxx.mdplayer,com.waqu.android.general_video,com.yy.yylite,com.wnys.video,com.zhtd.vr.goddess,cn.quicktv.androidpro,com.jingvo.alliance,com.cmvideo.migumovie,com.ysdq.hd,com.chaojishipin.sarrs,info.bsbetag.ka,com.taohua.live,com.sjdsgqzb.zhenniubi,com.bestv.app,com.yinyuetai.ui,com.miui.video,com.shg.play.daquan,com.tencent.qgame,com.bokecc.dance,com.lgy.android.kpsq,com.tianyou.play.kuaikan,newmediacctv6.com.cctv6,com.xunlei.cloud,com.telecom.video,com.ido.projection,com.airsky.tv.mobiletv,cn.pipi.mobile.pipiplayer,com.xghotplay.bluedo,com.kaixin.android.vertical_3_gcwspdq,com.wasu.wasuvideoplayer,com.olimsoft.android.oplayer,com.pipi.JPlayer,app.zhaotong.cn,cn.wangxiao.gongchengzhuntiku,com.hiti.likoda,japan.shopping.taiwan,com.sobeycloud.wangjie.czsdst,com.sregg.android.subloader,com.jb.gokeyboard.theme.twcolorthemeskeyboard,com.aiitec.goodlive,hk.com.nextmedia.magazine.nextmediaplus,com.rsbrowser.browser'
fps_top_video_pkg=''
user_configure "update misc set value = '$fps_group' where name = 'fps_top_video_pkg'"

# fps_exclude_pkg='com.studiowildcard.wardrumstudios.ark,com.studiowildcard.wardrumstudios.ark.ncr,com.ludashi.benchmark,com.ludashi.benchmark2,com.antutu.benchmark.bench64,com.antutu.videobench,com.antutu.ABenchMark5,com.antutu.ABenchMark.GL2,com.antutu.tester,com.antutu.ABenchMark,com.antutu.benchmark.full,org.zwanoo.android.speedtest'
fps_exclude_pkg=''
user_configure "update misc set value = '$fps_group' where name = 'fps_exclude_pkg'"

# fps_smart_group='{"list60":"com.miui.cit,com.tmall.wireless,com.jingdong.app.mall,com.taobao.live,com.tencent.mtt,com.xunmeng.pinduoduo,com.qq.ac.android,com.milink.service,com.tencent.qqpinyin,com.baidu.input,com.iflytek.inputmethod,com.sohu.inputmethod.sogou,com.lechuan.mdxs,com.taobao.taobao,com.UCMobile,com.tencent.wemeet.app,com.chaozh.iReader.dj,com.sankuai.meituan.dispatch.crowdsource,com.chaozh.iReaderFree,com.cootek.crazyreader,com.sankuai.meituan.meituanwaimaibusiness,com.lalamove.huolala.driver,com.faloo.BookReader4Android,com.jjwxc.reader,io.legado.app.release,com.sankuai.meituan.dispatch.homebrew,com.hpbr.bosszhipin,com.lwby.breader.ad,com.snda.wifilocating,com.duoduo.child.story,me.ele.crowdsource,com.alukaxi.bqshugg.blue,com.tencent.map,com.flyersoft.seekbooks,me.ele.napos,com.jingyao.easybike,cn.kuwo.player,com.yiyou.ga,com.ninesixshop.say,com.tmri.app.main,com.lechuan.midunovel,com.comics.bika,com.kuangxiangciweimao.novel,com.sdu.didi.psnger,com.bokecc.dance,com.duowan.mobile,com.ifreetalk.ftalk,com.kugou.android.elder,com.kuaidi.daijia.driver,com.dongqiudi.news,com.bilibili.comic,com.xiwei.logistics,com.huaxiaozhu.driver,com.xinchuzu.driver,com.jd.pingou,com.tool.biqudaogexs,com.tool.txtqbydq,com.baidu.yuedu,com.relief.space.master.cleaner,com.mampod.ergedd,com.ophone.reader.ui,com.ishansong,com.ximalaya.ting.lite,com.sfexpress.knight,com.mianfeizs.book,com.didapinche.booking,com.jryg.driver,com.tadu.read,com.android.incallui,com.android.camera,com.autonavi.minimap,com.sdu.didi.gsui,com.baidu.BaiduMap,com.duokan.reader,tv.danmaku.bili,com.dragon.read,com.kmxs.reader,com.eg.android.AlipayGphone,com.kugou.android,com.netease.cloudmusic,com.lechuan.mdwz,com.tencent.karaoke,com.qidian.QDReader,com.shuqi.controller,com.tencent.qqmusic,com.duokan.free,com.qq.reader,com.yueyou.adreader,com.ximalaya.ting.android,com.tencent.weread,com.android.deskclock,com.miui.cleanmaster,com.mfashiongallery.emag,com.android.calendar,com.android.soundrecorder,com.miui.tsmclient,com.miui.fm,com.miui.huanji,com.android.nfc,com.xiaomi.scanner,com.mipay.wallet,com.miui.yellowpage,com.android.providers.downloads.ui,com.miui.virtualsim,com.xiaomi.aiasst.service,com.miui.compass,com.miui.miservice,com.miui.packageinstaller,com.lbe.security.miui,com.miui.player,com.kuaiyin.player,com.tencent.edu,com.wondertek.miguaikan,com.cmcc.cmvideo,com.kuaikan.comic,com.xs.fm"}'
fps_smart_group='{"list60":"","list90":""}'
user_configure "update misc set value = '$fps_group' where name = 'fps_smart_group'"

# key_priv_names='com.tencent.tmgp.sgame:120,com.activision.callofduty.shooter:120,com.netease.lztg1.mi:120,com.netease.lztg:120,com.pwrd.xxajh.laohu:120,com.pwrd.xxajh.mi:120,com.t2ksports.nba2k20and:90,com.tencent.af:120,com.tencent.tmgp.pubgmhd:90,com.tencent.tmgp.speedmobile:120,com.tencent.tmgp.WePop:120,com.tencent.YiRen:120,com.tencent.KiHan:120,com.gs.truckdrive.road.train.truck.gtx:60,com.tencent.ig:90,com.tencent.tmgp.cod:120,com.tencent.tmgp.codty:120,com.denachina.g13002010.mi:120,com.denachina.g13002010.denacn:120,com.tencent.lolm:90,com.dfjz.moba:120'
key_priv_names=''
user_configure "update misc set value = '$fps_group' where name = 'key_priv_names'"

killall com.miui.powerkeeper 2>/dev/null
am force-stop com.miui.powerkeeper 2>/dev/null
am kill com.miui.powerkeeper 2>/dev/null

# Disable PowerStateMachineService
if [[ "$disable_machine" == "1" ]]; then
  pm disable com.miui.powerkeeper/com.miui.powerkeeper.statemachine.PowerStateMachineService  >/dev/null 2>&1 &
else
  pm enable com.miui.powerkeeper/com.miui.powerkeeper.statemachine.PowerStateMachineService  >/dev/null 2>&1 &
fi
