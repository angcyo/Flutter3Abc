part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/06/27
///
class WebviewAbc extends StatefulWidget {
  const WebviewAbc({super.key});

  @override
  State<WebviewAbc> createState() => _WebviewAbcState();
}

class _WebviewAbcState extends State<WebviewAbc>
    with BaseAbcStateMixin, InAppWebViewStateMixin {
  late TextFieldConfig urlFieldConfig = TextFieldConfig(
    text: "lastUrlField".hiveGet("http://www.baidu.com"),
    hintText: "url",
    notifyDefaultTextChange: true,
    onChanged: (value) {
      //debugger();
      "lastUrlField".hivePut(value);
    },
    onSubmitted: (value) {
      loadWebviewUrl(value);
    },
  );

  late TextFieldConfig uaFieldConfig = TextFieldConfig(
    text: "lastUserAgent".hiveGet(
      inAppWebViewSettings.applicationNameForUserAgent,
    ),
    hintText: "User Agent",
    notifyDefaultTextChange: true,
    onChanged: (value) {
      //debugger();
      "lastUserAgent".hivePut(value);
    },
    onSubmitted: (value) {
      updateCustomUserAgent(value);
    },
  );

  @override
  String? get title => webviewTile ?? "...";

  @override
  bool get useScroll => false;

  @override
  bool get resizeToAvoidBottomInset => true;

  /// 返回值
  dynamic result;

  @override
  void initState() {
    updateCustomUserAgent(uaFieldConfig.text);
    addJavaScriptHandler("callFlutter", (args) {
      result = args;
      updateState();
      return "from flutter:${nowTimestamp()}";
    });
    if (isWindows) {
      InAppWebViewStateMixin.registerCustomSchemeEnvironment([
        "angcyo",
        "Laserabc",
      ]);
    }
    super.initState();
  }

  @override
  Widget buildAbc(BuildContext context) {
    return ProgressStateWidget(child: super.buildAbc(context));
  }

  @override
  WidgetList buildBodyList(BuildContext context) {
    //debugger();
    final globalTheme = GlobalTheme.of(context);
    webConfigMixin.url = urlFieldConfig.text;
    return [
      SingleInputWidget(
        prefix: "Url: ".text(textColor: globalTheme.icoNormalColor),
        keyboardType: .emailAddress,
        config: urlFieldConfig,
      ).paddingAll(kH),
      SingleInputWidget(
        prefix: "User Agent: ".text(textColor: globalTheme.icoNormalColor),
        keyboardType: .emailAddress,
        config: uaFieldConfig,
      ).paddingAll(kH),
      [
        GradientButton.normal(() {
          loadWebviewUrl(urlFieldConfig.text);
        }, child: "Go".text()),
        GradientButton.normal(() {
          reloadWebview();
        }, child: "Refresh".text()),
        GradientButton.normal(() async {
          final html = await loadAssetString(
            "web/test_web.html",
            package: Assets.package,
          );
          loadWebviewHtml(html);
        }, child: "test.html".text()),
        GradientButton.normal(() async {
          result = await evaluateJavascript(
            "callJs(${nowTimestamp()}, {a:'a'}, [1,2,3])",
          );
          updateState();
        }, child: "callJs".text()),
        GradientButton.normal(() {
          isOffstage = true;
          buildContext?.maybePop();
        }, child: "close".text()),
        GradientButton.normal(
          () {},
          onContextTap: (context) {
            const ProgressStateNotification(progress: -1).dispatch(context);
          },
          child: "-1".text(),
        ),
        GradientButton.normal(
          () {},
          onContextTap: (context) {
            const ProgressStateNotification(progress: 0.5).dispatch(context);
          },
          child: "50".text(),
        ),
        GradientButton.normal(
          () {},
          onContextTap: (context) {
            const ProgressStateNotification(
              progress: -1,
              error: "error",
            ).dispatch(context);
          },
          child: "e".text(),
        ),
        GradientButton.normal(() {
          urlFieldConfig.text = "https://www.baidu.com";
          loadWebviewUrl(urlFieldConfig.text);
        }, child: "->Baidu".text()),
        GradientButton.normal(() {
          urlFieldConfig.text =
              "https://www.laserabc.com/train-web/?theme=dark&app=light";
          loadWebviewUrl(urlFieldConfig.text);
        }, child: "->test1".text()),
      ].flowLayout(
        selfConstraints: const LayoutBoxConstraints(
          widthType: ConstraintsType.matchParent,
        ),
        padding: const EdgeInsets.all(kH),
        childGap: kX,
      )!,
      if (result != null)
        "${result.runtimeType}\n$result".text(textAlign: TextAlign.left),
      _overrideUrlLive.buildFn(
        () => _overrideUrlLive.value?.text(style: globalTheme.textDesStyle),
      ),
      buildInAppWebView(context, webConfigMixin)
      /*.repaintBoundary()
          .animatedOpacity(opacity: 0.1)*/
      .interceptPopResult(() async {
        if (await onWebviewBackPress() == true) {
          isOffstage = true;
          updateState();
          buildContext?.popRoute();
        }
      }).expanded(),
    ];
  }

  final _overrideUrlLive = $live<String?>();

  @override
  Future<NavigationActionPolicy?> onSelfShouldOverrideUrlLoading(
    InAppWebViewController controller,
    NavigationAction navigationAction,
  ) async {
    final url = navigationAction.request.url?.toString();
    _overrideUrlLive << url;
    if (url != null) {
      final uri = url.toUri();
      final host = uri?.host;
      final path = uri?.path;
      final query = uri?.query;
    }
    return super.onSelfShouldOverrideUrlLoading(controller, navigationAction);
  }
}
