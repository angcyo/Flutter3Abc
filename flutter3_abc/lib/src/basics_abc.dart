part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/10/23
///

/// 基础信息
class BasicsAbc extends StatefulWidget {
  const BasicsAbc({super.key});

  @override
  State<BasicsAbc> createState() => _BasicsAbcState();
}

class _BasicsAbcState extends State<BasicsAbc> with BaseAbcStateMixin {
  BaseDeviceInfo? _deviceInfo;

  @override
  void initState() {
    $platformDeviceInfo.getValue((info, error) {
      _deviceInfo = info;
      updateState();
    });
    super.initState();
  }

  @override
  Widget buildBody(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final EdgeInsets padding = MediaQuery.paddingOf(context);
    final viewPadding = MediaQuery.viewPaddingOf(context);
    final flutterView = View.of(context);
    //WidgetsBinding.instance.window.locale
    final locale = flutterView.platformDispatcher.locale;
    final renderView = RendererBinding.instance.renderView;
    //当前语言
    final globalCurrentLocale =
        Localizations.localeOf(GlobalConfig.def.globalAppContext ?? context);
    final currentLocale = Localizations.localeOf(context);

    const textStyle = TextStyle(color: Colors.red);
    dynamic textWidget = textSpanBuilder((builder) {
      final w = deviceWidth;
      final h = deviceHeight;

      final screenSize = flutterView.physicalSize;

      // 使用勾股定理计算对角线长度，并将像素转换为英寸
      double calculateDiagonalInches(double width, double height) {
        double diagonalPixels = sqrt(width * width + height * height);
        double diagonalInches = diagonalPixels / dpi;
        return diagonalInches;
      }

      /*$getWifiName().get((wifiName, error) {
        l.d("wifiName:$wifiName");
      });*/

      builder
        ..addText(nowTimeString(), style: textStyle)
        ..addText(lineSeparator)
        ..addText(String.fromEnvironment("test_yaml_value", defaultValue: "--"))
        ..addText(lineSeparator)
        ..addText(lineSeparator)
        ..addText("buildConfig->${$buildConfig?.toString() ?? "--"}")
        ..addText(lineSeparator)
        ..addText(lineSeparator)
        ..addText("appSettingBean->${$appSettingBean.toString() ?? "--"}")
        ..addText(lineSeparator)
        ..addText(lineSeparator)
        ..addText("appVersionBean->${$appVersionBean.toString() ?? "--"}")
        ..addText(lineSeparator)
        ..addText(lineSeparator)
        ..addText(
            "屏幕dpi:$dpi dpr:$dpr 状态栏高度:$screenStatusBar dp 导航栏高度:$screenBottomBar dp $screenNavigationBar dp $deviceInch")
        ..addText(lineSeparator)
        ..addText("屏幕宽度:$screenWidth dp $screenWidthPixel px ")
        ..addText("屏幕高度:$screenHeight dp $screenHeightPixel px ")
        ..addText(lineSeparator)
        ..addText(
            "physicalSize:$screenSize ${calculateDiagonalInches(screenSize.width, screenSize.height)} ${calculateDiagonalInches(deviceWidthPixel, deviceHeightPixel)}")
        ..addText(lineSeparator)
        ..addText(
            "设备宽度:${deviceWidth.toMmFromDp()} mm 设备高度:${deviceHeight.toMmFromDp()} mm")
        ..addText(lineSeparator)
        ..addText(
            "设备宽度:$deviceWidthPixel px 设备高度:$deviceHeightPixel px ${cl(deviceWidthPixel, deviceHeightPixel).toInchFromPixel()} ${cl(w, h).toMmFromDp()}")
        ..addText(lineSeparator)
        ..addText(
            "对角线长度:${screenDiagonalLength.toInchFromDp()} $screenDiagonalLength dp ${screenDiagonalLengthPixel.toInchFromPixel()} $screenDiagonalLengthPixel px")
        ..addText(lineSeparator)
        ..addText(lineSeparator);

      builder
        ..addText("当前平台->", style: textStyle)
        ..addText("${themeData.platform}")
        ..addText(lineSeparator)
        ..addText("设备平台->", style: textStyle)
        ..addText(
            "$defaultTargetPlatform ${Platform.pathSeparator} ${Platform.numberOfProcessors} ${Platform.localeName} | ${Platform.operatingSystem} ")
        ..addText(lineSeparator)
        ..addText("设备平台版本->", style: textStyle)
        ..addText(
            '${Platform.operatingSystemVersion} | ${Platform.version} | ${Platform.localHostname}')
        ..addText(lineSeparator)
        ..addText(
            '${Platform.resolvedExecutable} | ${Platform.script} | ${Platform.executable} | ${Platform.resolvedExecutable}')
        ..addText(lineSeparator)
        ..addText(
            '${Platform.packageConfig} | ${Platform.executableArguments} | ${Platform.lineTerminator}')
        ..addText(lineSeparator)
        ..addText("PackageInfo->", style: textStyle)
        ..addText($platformPackageInfoCache?.toString())
        ..addText(lineSeparator)
        ..addText(lineSeparator)
        ..addText("DeviceInfo->", style: textStyle)
        ..addText(_deviceInfo.toString())
        ..addText(lineSeparator)
        ..addText(lineSeparator)
        ..addText("设备/平台信息->", style: textStyle)
        ..addText("文本缩放比例:${flutterView.platformDispatcher.textScaleFactor}")
        ..addText(lineSeparator)
        ..addText("物理设备约束->", style: textStyle)
        ..addText("${flutterView.physicalConstraints}")
        ..addText(lineSeparator)
        ..addText("显示屏信息->", style: textStyle)
        ..addText("${flutterView.display}")
        ..addText(lineSeparator)
        ..addText("显示屏特性->", style: textStyle)
        ..addText("${flutterView.displayFeatures}")
        ..addText(lineSeparator)
        ..addText("设备区域列表->", style: textStyle)
        ..addText("${flutterView.platformDispatcher.locales}")
        ..addText(lineSeparator)
        ..addText("设备区域/语言->", style: textStyle)
        ..addText("$locale")
        ..addText(" language:${locale.languageCode}")
        ..addText(" country:${locale.countryCode}")
        ..addText(" script:${locale.scriptCode}")
        ..addText(lineSeparator)
        ..addText("当前区域/语言->", style: textStyle)
        ..addText("$currentLocale/$globalCurrentLocale |")
        ..addText(" language:${currentLocale.languageCode}")
        ..addText(" country:${currentLocale.countryCode}")
        ..addText(" script:${currentLocale.scriptCode}")
        ..addText(lineSeparator)
        ..addText("手势配置->", style: textStyle)
        ..addText("${flutterView.gestureSettings}")
        ..addText(lineSeparator * 2);

      /*debugger();
      "testOnlyZhKey".intlMessage(locale: "zh");*/
      builder
        ..addText("intl->", style: textStyle)
        ..addText(
            "顺序:${LibRes.delegate.supportedLocales} 主要语言:${LibRes.delegate.supportedLocales.firstOrNull?.languageCode}")
        ..addText(lineSeparator)
        ..addText(
            "intlCurrentLocaleName:$intlCurrentLocaleName intlDefaultLocaleName:$intlDefaultLocaleName")
        ..addText(lineSeparator)
        ..addText("正常获取资源↓", style: textStyle)
        ..addText(lineSeparator)
        ..addText("testOnlyZhKey->${LibRes.of(context).testOnlyZhKey}")
        ..addText(lineSeparator)
        ..addText("testResKey->${LibRes.of(context).testResKey}")
        ..addText(lineSeparator)
        ..addText("通过key获取资源↓", style: textStyle)
        ..addText(lineSeparator)
        ..addText("testOnlyEnKey->")
        ..addText("testOnlyEnKey".intlMessage())
        ..addText(lineSeparator)
        ..addText("testOnlyZhKey->")
        ..addText("testOnlyZhKey".intlMessage(locale: "zh"))
        ..addText(lineSeparator)
        ..addText("testResKey->")
        ..addText("testResKey".intlMessage())
        ..addText(lineSeparator * 2);

      renderViews.forEachIndexed((index, rv) {
        var fv = rv.flutterView;
        builder
          ..addText("renderView[${index + 1}]->", style: textStyle)
          ..addText(
              "$rv | ${rv.size} | ${rv.configuration} | ${rv.automaticSystemUiAdjustment}")
          ..addText(" | ${rv.paintBounds} | ${rv.semanticBounds}")
          ..addText(lineSeparator)
          ..addText("flutterView->", style: textStyle)
          ..addText(
              "$fv | ${fv.display.size / fv.devicePixelRatio} | ${fv.display}")
          ..addText(
              /*| physicalGeometry:${fv.physicalGeometry}*/
              ' | physicalSize:${fv.physicalSize} | systemGestureInsets:${fv.systemGestureInsets}')
          ..addText(
              ' | padding:${fv.padding} | viewInsets:${fv.viewInsets} | viewPadding:${fv.viewPadding}')
          ..addText(lineSeparator * 2);
      });

      builder
            ..addText("平台媒体查询信息->", style: textStyle)
            ..addText("$platformMediaQueryData")
            ..addText(lineSeparator)
            ..addText("上下文媒体查询信息->", style: textStyle)
            ..addText("$mediaQueryData")
            ..addText(lineSeparator * 2)
            ..addText("viewInsets:", style: textStyle)
            ..addText("${mediaQueryData.viewInsets}")
            ..addText(lineSeparator)
            ..addText("viewPadding1:", style: textStyle)
            ..addText("${mediaQueryData.viewPadding}")
            ..addText(lineSeparator)
            ..addText("viewPadding2:", style: textStyle)
            ..addText("$viewPadding")
            ..addText(lineSeparator)
            ..addText("padding1:", style: textStyle)
            ..addText("${mediaQueryData.padding}")
            ..addText(lineSeparator)
            ..addText("padding2:", style: textStyle)
            ..addText("$padding")
            ..addText(lineSeparator * 2)
            ..addWidget(GestureDetector(
              onTap: () {
                //debugger();
                /*final home = LPRes.of(context).home;
                final iKnown = LPRes.of(context).iKnown;*/
                final home = "!home!";
                final iKnown = "!iKnown!";
                final creation = "creation".intlMessage();
                final account = "account".intlMessage();
                toastInfo("click it\n"
                    "$intlSystemLocaleName|$intlCurrentLocaleName|$intlDefaultLocaleName"
                    "findLocale:${GlobalConfig.def.findLocale()}\n"
                    "$home\n$iKnown\n$creation\n$account");
              },
              child: const Text(
                "click me test",
                style: TextStyle(color: Colors.blue),
              ),
            ))
            ..addText(
                "\nsize = ${platformMediaQueryData.size}\n1 dp = $dpr px dpi=$dpi")
            ..addText(
                "\n1 px= ${1 / (dpi * sInchesPerMM)}mm =${1.toMmFromPx().formatMm()} =${IUnit.pcmm.format(IUnit.pcmm.toUnit(1))}")
            ..addText(
                "\n1 dp= $dpr px =${1.toPixel(IUnit.dp).formatPixel()} =${1.toMmFromDp()}mm")
            ..addText(
                "\n1 pt= ${dpi * sInchesPerPT} px =${1.toPixel(IUnit.pt).formatPixel()}")
            ..addText(
                "\n1 mm= ${dpi * sInchesPerMM} =${1.toPixel().formatPixel()} =${1.toDpFromMm().formatDp()}")
            ..addText(
                "\n1 in= $dpi px =${1.toPixel(IUnit.inch).formatPixel()} =25.4 mm =72 pt")
            ..addText(lineSeparator * 2)
            ..addText("环境变量->", style: textStyle)
            ..addText("${Platform.environment}")
            ..addText(lineSeparator)
          /*..addText("...test..." * 1000)*/
          ;
    });
    return Container(padding: const EdgeInsets.all(10), child: textWidget);
  }
}
