part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/07/10
///
class UrlLauncherAbc extends StatefulWidget {
  const UrlLauncherAbc({super.key});

  @override
  State<UrlLauncherAbc> createState() => _UrlLauncherAbcState();
}

///
/// 比如一些常用的
/// 微信：weixin://
/// QQ：mqq://
/// 飞书: feishu://
/// 京东：openapp.jdmoble://
/// 淘宝：taobao://
/// Chrome：googlechrome://
/// 百度地图：baidumap://
/// 高德地图：androidamap://、iosamap://
/// https://juejin.cn/post/6899680984254382093
///
/// FaceBook: fb://
/// whatsapp: whatsapp://
/// twitter: twitter://
/// instagram: instagram://
/// https://www.bootschool.net/article/5befcd89f60a3165a5f8c7c1
///
/// https://pub.dev/packages/android_intent_plus
///
class _UrlLauncherAbcState extends State<UrlLauncherAbc>
    with BaseAbcStateMixin {
  //--
  final TextFieldConfig _iosUrlConfig = TextFieldConfig(
    hintText: "请输入ios的url",
    text: "_iosUrlConfig".hiveGet() ?? "https://www.baidu.com",
    onChanged: (text) {
      "_iosUrlConfig".hivePut(text);
    },
  );
  final TextFieldConfig _androidUrlConfig = TextFieldConfig(
    hintText: "请输入android的url",
    text: "_androidUrlConfig".hiveGet() ?? "https://www.baidu.com",
    onChanged: (text) {
      "_androidUrlConfig".hivePut(text);
    },
  );

  //--
  final TextFieldConfig _iosAppConfig = TextFieldConfig(
    hintText: "请输入ios的App跳转",
    text: "_iosAppConfig".hiveGet() ?? "weixin://",
    onChanged: (text) {
      "_iosAppConfig".hivePut(text);
    },
  );
  final TextFieldConfig _androidAppConfig = TextFieldConfig(
    hintText: "请输入android的App跳转",
    text: "_androidAppConfig".hiveGet() ?? "mqq://", //weixin //mqq
    onChanged: (text) {
      "_androidAppConfig".hivePut(text);
    },
  );

  //--
  final TextFieldConfig _iosMarketConfig = TextFieldConfig(
    hintText: "请输入ios的App 市场",
    text: "_iosMarketConfig".hiveGet() ??
        "itms-apps://itunes.apple.com/app/id6445970960",
    onChanged: (text) {
      "_iosMarketConfig".hivePut(text);
    },
  );
  final TextFieldConfig _androidMarketConfig = TextFieldConfig(
    hintText: "请输入android的App 市场",
    text: "_androidMarketConfig".hiveGet() ??
        "market://details?id=com.tencent.mm",
    onChanged: (text) {
      "_androidMarketConfig".hivePut(text);
    },
  );

  @override
  WidgetList buildBodyList(BuildContext context) {
    return [
      LabelSingleInputTile(
        label: "iOS Url",
        inputFieldConfig: _iosUrlConfig,
      ),
      LabelSingleInputTile(
        label: "android Url",
        inputFieldConfig: _androidUrlConfig,
      ),
      LabelSingleInputTile(
        label: "iOS App",
        inputFieldConfig: _iosAppConfig,
      ),
      LabelSingleInputTile(
        label: "android App",
        inputFieldConfig: _androidAppConfig,
      ),
      LabelSingleInputTile(
        label: "iOS Market",
        inputFieldConfig: _iosMarketConfig,
      ),
      LabelSingleInputTile(
        label: "android Market",
        inputFieldConfig: _androidMarketConfig,
      ),
      [
        GradientButton.normal(() async {
          final url = _iosUrlConfig.text;
          if (await url.canLaunch()) {
            url.launch();
          } else {
            toastInfo('无法启动[$url]');
          }
        }, child: "启动iOS Url".text()),
        GradientButton.normal(() async {
          final url = _androidUrlConfig.text;
          if (await url.canLaunch()) {
            url.launch();
          } else {
            toastInfo('无法启动[$url]');
          }
        }, child: "启动Android Url".text()),
        //--
        GradientButton.normal(() async {
          final url = _iosAppConfig.text;
          if (await url.canLaunch()) {
            url.launch();
          } else {
            toastInfo('无法启动[$url]');
          }
        }, child: "启动iOS App".text()),
        GradientButton.normal(() async {
          final url = _androidAppConfig.text;
          if (await url.canLaunch()) {
            url.launch();
          } else {
            toastInfo('无法启动[$url]');
          }
        }, child: "启动Android App".text()),
        //--
        GradientButton.normal(() async {
          final url = _iosMarketConfig.text;
          if (await url.canLaunch()) {
            url.launch();
          } else {
            toastInfo('无法启动[$url]');
          }
        }, child: "启动iOS Market".text()),
        GradientButton.normal(() async {
          final url = _androidMarketConfig.text;
          if (await url.canLaunch()) {
            url.launch();
          } else {
            toastInfo('无法启动[$url]');
          }
        }, child: "启动Android Market".text()),
      ].flowLayout(childGap: kX)!,
    ];
  }
}
