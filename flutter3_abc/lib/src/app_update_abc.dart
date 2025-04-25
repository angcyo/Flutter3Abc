part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/08/16
///
class AppUpdateAbc extends StatefulWidget {
  const AppUpdateAbc({super.key});

  @override
  State<AppUpdateAbc> createState() => _AppUpdateAbcState();
}

class _AppUpdateAbcState extends State<AppUpdateAbc> with BaseAbcStateMixin {
  late final TextFieldConfig _lastAndroidMarketUrlConfig = TextFieldConfig(
    hintText: "Android市场跳转链接",
    text: "_lastAndroidMarketUrlConfig".hiveGet() ??
        "market://details?id=com.tencent.mm",
    textInputAction: TextInputAction.done,
    onChanged: (value) {
      "_lastAndroidMarketUrlConfig".hivePut(value);
    },
  );

  late final TextFieldConfig _lastIosMarketUrlConfig = TextFieldConfig(
    hintText: "iOS市场跳转链接",
    text: "_lastIosMarketUrlConfig".hiveGet() ??
        "itms-apps://itunes.apple.com/app/id6445970960",
    textInputAction: TextInputAction.done,
    onChanged: (value) {
      "_lastIosMarketUrlConfig".hivePut(value);
    },
  );

  bool _force = false;
  bool _jumpToMarket = false;

  @override
  WidgetList buildBodyList(BuildContext context) {
    return [
      Empty.height(kX),
      SingleInputWidget(
        config: _lastAndroidMarketUrlConfig,
        labelText: _lastAndroidMarketUrlConfig.hintText,
      ).paddingSym(),
      SingleInputWidget(
        config: _lastIosMarketUrlConfig,
        labelText: _lastIosMarketUrlConfig.hintText,
      ).paddingSym(),
      LabelSwitchTile(
        label: "强制",
        value: _force,
        onValueChanged: (value) {
          _force = value;
        },
      ),
      LabelSwitchTile(
        label: "跳转市场",
        value: _jumpToMarket,
        onValueChanged: (value) {
          _jumpToMarket = value;
        },
      ),
      [
        GradientButton(
            onTap: () {
              _lastAndroidMarketUrlConfig.text.launch();
            },
            child: "跳转Android市场".text()),
        GradientButton(
            onTap: () {
              _lastIosMarketUrlConfig.text.launch();
            },
            child: "跳转iOS市场".text()),
        GradientButton(
            onTap: () {
              AppUpdateDialog.checkUpdateAndShow(
                context,
                LibAppVersionBean()
                  ..versionName = "1.0.1"
                  ..versionTile = "新版本升级"
                  ..forceUpdate = _force
                  ..outLink = false
                  ..jumpToMarket = _jumpToMarket
                  //..marketUrl = "itms-apps://itunes.apple.com/app/id6445970960"
                  ..marketUrl = "market://details?id=com.tencent.mm"
                  ..downloadUrl =
                      "https://gitcode.net/angcyo/file/-/raw/master/BackManage/BackManage-1.2.0_pre_pretest_app.apk"
                  ..versionDes = "1:angcyo\n2:angcyo" * 1,
                forceShow: isDebug,
              );
            },
            child: "显示更新弹窗".text()),
        GradientButton(
            onTap: () {
              AppUpdateDialog.checkUpdateAndShow(
                context,
                LibAppVersionBean()
                  ..forbiddenReason = "forbiddenReason"
                  ..forceForbidden = _force,
                forceShow: false,
              );
            },
            child: "forbidden".text()),
      ].flowLayout(padding: kXInsets, childGap: kX)!,
    ];
  }
}
