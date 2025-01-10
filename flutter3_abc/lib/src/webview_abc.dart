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
    addJavaScriptHandler("callFlutter", (args) {
      result = args;
      updateState();
      return "from flutter:${nowTimestamp()}";
    });
    super.initState();
  }

  @override
  Widget buildAbc(BuildContext context) {
    return ProgressStateWidget(child: super.buildAbc(context));
  }

  @override
  WidgetList buildBodyList(BuildContext context) {
    //debugger();
    webConfigMixin.url = urlFieldConfig.text;
    return [
      SingleInputWidget(config: urlFieldConfig).paddingAll(kH),
      [
        GradientButton.normal(() {
          loadWebviewUrl(urlFieldConfig.text);
        }, child: "Go".text()),
        GradientButton.normal(() async {
          final html = await loadAssetString("web/test_web.html");
          loadWebviewHtml(html);
        }, child: "test.html".text()),
        GradientButton.normal(() async {
          result = await evaluateJavascript(
              "callJs(${nowTimestamp()}, {a:'a'}, [1,2,3])");
          updateState();
        }, child: "callJs".text()),
        GradientButton.normal(() {
          isOffstage = true;
          buildContext?.maybePop();
        }, child: "close".text()),
        GradientButton.normal(() {}, onContextTap: (context) {
          const ProgressStateNotification(progress: -1).dispatch(context);
        }, child: "-1".text()),
        GradientButton.normal(() {}, onContextTap: (context) {
          const ProgressStateNotification(progress: 0.5).dispatch(context);
        }, child: "50".text()),
        GradientButton.normal(() {}, onContextTap: (context) {
          const ProgressStateNotification(progress: -1, error: "error")
              .dispatch(context);
        }, child: "e".text()),
      ].flowLayout(
        selfConstraints:
            const LayoutBoxConstraints(widthType: ConstraintsType.matchParent),
        padding: const EdgeInsets.all(kH),
        childGap: kX,
      )!,
      if (result != null)
        "${result.runtimeType}\n$result".text(
          textAlign: TextAlign.left,
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
}
