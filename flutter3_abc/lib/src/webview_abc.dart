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
              "https://dev.laserabc.com/train-web/?theme=dark&app=light";
          loadWebviewUrl(urlFieldConfig.text);
        }, child: "->train-web".text()),
        GradientButton.normal(() {
          urlFieldConfig.text =
              "https://dev.laserabc.com/examine-web/?"
              "host=https://dev.laserabc.com/api-light/"
              "&token=eyJraWQiOiI5MDQ1YjgwYi05YmU0LTRiNTgtOTU2Zi1hZjAzYzk4ZDNkMzIiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJ1c2VybmFtZSIsImF1ZCI6Im9hdXRoLWNsaWVudC1pZCIsIm5iZiI6MTc3NjA0ODU3MSwic2hvcnRUb2tlbiI6Imd0Ry91Tkhtc21hV3NoMzgwREp6MGJ4YjhDSEsyM1VzdXBZdXRKL0tXeHFpRTArNnNqTCtQa3hiSDhwSUdRZ2VuWmJvVW9yRFcwZ0RScEhNQVZIbDJBPT0iLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjI5MDAxIiwiZXhwIjoxNzc4NjQwNTcxLCJpYXQiOjE3NzYwNDg1NzEsInVzZXIiOnsidXNlcklkIjoiMTcyMDk0N2ZmYjM5NDBmZjk1NjFkMGRjMzU2NzJhOGEiLCJhY2NvdW50SWQiOiI1NjlkZGU4YTZhNGE5MzQxNzY0OWVjNWY5YjdhNWFmMiIsInVzZXJuYW1lIjoidXNlcm5hbWUiLCJuYW1lIjoidXNlcm5hbWUiLCJjb2RlIjpudWxsLCJzZXgiOm51bGwsIm1vYmlsZSI6bnVsbCwiZW1haWwiOm51bGwsImNhdGVnb3J5IjoxLCJoZWFkSW1nVXJsIjpudWxsLCJzb3VyY2VPZlJlcXVlc3QiOiJBUFAiLCJsb2dpblRpbWUiOiIyMDI2LTA0LTEzIDEwOjQ5OjMxIn0sImp0aSI6ImM3M2UzODdhLTJkMDItNDc1NS1iZTg0LTRkZGNmYTllODVkNyJ9.YcAG4A-tc6B-XMScNKnBhmyJpzlqr9_4MyPEGjotqfSF3sXMV-O4XoEkFprG_pHtcpn7QtKwEF26X4vOqnR7pGl1o5L7DoqifwhyUSjyQneQPFtM8l2HQ_hU0UOUuEHey2IpYKTUS67gC0Dro_lXGu3Ka_-ktYSj2ev5JI0APWO4QDJWo0qHgZYjPlAeGoJGzTDt5HpEHH--o9rq-rWsbu62svM_CxPRvqeDof9wzal6LI8wK0pTqUNwVzQaE2AHkCYUkTAfKlQ_T7Ag-Maj9RzWKhxjf2d3P6IDFwk5bRgZEpRIXih0KQ6pula5XEfoyQEy8zxlpTaEaRZ4E_-aGg"
              "&regionId=c89b900a29bdc1672d5e3da25f1d3e6d";
          loadWebviewUrl(urlFieldConfig.text);
        }, child: "->examine-web".text()),
        GradientButton.normal(() {
          urlFieldConfig.text =
              "http://192.168.1.175:5500/?"
              "lang=zh-CN"
              "&debug"
              "&host=https://www.laserabc.com/api-light/"
              "&token=eyJraWQiOiI5MDQ1YjgwYi05YmU0LTRiNTgtOTU2Zi1hZjAzYzk4ZDNkMzIiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJ1c2VybmFtZSIsImF1ZCI6Im9hdXRoLWNsaWVudC1pZCIsIm5iZiI6MTc3NjA0ODU3MSwic2hvcnRUb2tlbiI6Imd0Ry91Tkhtc21hV3NoMzgwREp6MGJ4YjhDSEsyM1VzdXBZdXRKL0tXeHFpRTArNnNqTCtQa3hiSDhwSUdRZ2VuWmJvVW9yRFcwZ0RScEhNQVZIbDJBPT0iLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjI5MDAxIiwiZXhwIjoxNzc4NjQwNTcxLCJpYXQiOjE3NzYwNDg1NzEsInVzZXIiOnsidXNlcklkIjoiMTcyMDk0N2ZmYjM5NDBmZjk1NjFkMGRjMzU2NzJhOGEiLCJhY2NvdW50SWQiOiI1NjlkZGU4YTZhNGE5MzQxNzY0OWVjNWY5YjdhNWFmMiIsInVzZXJuYW1lIjoidXNlcm5hbWUiLCJuYW1lIjoidXNlcm5hbWUiLCJjb2RlIjpudWxsLCJzZXgiOm51bGwsIm1vYmlsZSI6bnVsbCwiZW1haWwiOm51bGwsImNhdGVnb3J5IjoxLCJoZWFkSW1nVXJsIjpudWxsLCJzb3VyY2VPZlJlcXVlc3QiOiJBUFAiLCJsb2dpblRpbWUiOiIyMDI2LTA0LTEzIDEwOjQ5OjMxIn0sImp0aSI6ImM3M2UzODdhLTJkMDItNDc1NS1iZTg0LTRkZGNmYTllODVkNyJ9.YcAG4A-tc6B-XMScNKnBhmyJpzlqr9_4MyPEGjotqfSF3sXMV-O4XoEkFprG_pHtcpn7QtKwEF26X4vOqnR7pGl1o5L7DoqifwhyUSjyQneQPFtM8l2HQ_hU0UOUuEHey2IpYKTUS67gC0Dro_lXGu3Ka_-ktYSj2ev5JI0APWO4QDJWo0qHgZYjPlAeGoJGzTDt5HpEHH--o9rq-rWsbu62svM_CxPRvqeDof9wzal6LI8wK0pTqUNwVzQaE2AHkCYUkTAfKlQ_T7Ag-Maj9RzWKhxjf2d3P6IDFwk5bRgZEpRIXih0KQ6pula5XEfoyQEy8zxlpTaEaRZ4E_-aGg&regionId=c89b900a29bdc1672d5e3da25f1d3e6d";
          loadWebviewUrl(urlFieldConfig.text);
        }, child: "->t3".text()),
        GradientButton.normal(() {
          urlFieldConfig.text = "http://192.168.1.175:5500/";
          loadWebviewUrl(urlFieldConfig.text);
        }, child: "->5500".text()),
        GradientButton.normal(() {
          urlFieldConfig.text = "http://192.168.1.175:5173/";
          loadWebviewUrl(urlFieldConfig.text);
        }, child: "->5173".text()),
        GradientButton.normal(() {
          urlFieldConfig.text =
              "http://192.168.1.175:5174/?host=https://dev.laserabc.com/api-light&token=eyJraWQiOiI5MDQ1YjgwYi05YmU0LTRiNTgtOTU2Zi1hZjAzYzk4ZDNkMzIiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJ1c2VybmFtZSIsImF1ZCI6Im9hdXRoLWNsaWVudC1pZCIsIm5iZiI6MTc3NzE5MTMzMCwic2hvcnRUb2tlbiI6IldaY3hFWjZmZHdPbVNkeUxWSHIrT25uZDU4ZEpkYVZSZUU3YjBGTXFhTmE2anhCNUdBQlRBR3RpN3JlTDAvMGhNR1IzOWlpQVVZd21uOEpGcHNvdit3PT0iLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjI5MDAxIiwiZXhwIjoxNzc5NzgzMzMwLCJpYXQiOjE3NzcxOTEzMzAsInVzZXIiOnsidXNlcklkIjoiMTcyMDk0N2ZmYjM5NDBmZjk1NjFkMGRjMzU2NzJhOGEiLCJhY2NvdW50SWQiOiI1NjlkZGU4YTZhNGE5MzQxNzY0OWVjNWY5YjdhNWFmMiIsInVzZXJuYW1lIjoidXNlcm5hbWUiLCJuYW1lIjoidXNlcm5hbWUiLCJjb2RlIjpudWxsLCJzZXgiOm51bGwsIm1vYmlsZSI6bnVsbCwiZW1haWwiOm51bGwsImNhdGVnb3J5IjoxLCJoZWFkSW1nVXJsIjpudWxsLCJzb3VyY2VPZlJlcXVlc3QiOiJBUFAiLCJsb2dpblRpbWUiOiIyMDI2LTA0LTI2IDE2OjE1OjMwIn0sImp0aSI6IjFmZWEyZGNkLTNmYjctNDY3ZS04ZGY0LWZiY2NlMzVkZmI3MiJ9.JbtcfNsGKxtXcBkW4fFaU1AyJRTIyW3emlTVVF-nSVSGMvG3a1nXEJ1-E4fzv4muJUneVW4SX5Vx85dBtx1RfUY3J7wsxKA1NpGXiIaB1_ynilutCZnCHQhsQRPPeidIEJtjvy9yyg3hz9HWn5HqcaYPvjVymEG64Io5u0FDQlyRezVvGngWwWIGnLtCKPpq_N42gwgZGaQecDp2h6352sfjCFZGvL8wCk_JsS5_4i9Scw5_JqBSw9h_PF4jqR1SENMJJAZknbah4iycCXulDVP-EMJ181pg-upid_jtJFsW0mzqpbIW0i5SzhIG9ClafWJQYTrngxyH6FbhjOpKZQ";
          loadWebviewUrl(urlFieldConfig.text);
        }, child: "->5174".text()),
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
        () => _overrideUrlLive.value?.text(
          style: globalTheme.textDesStyle,
          maxLines: 3,
        ),
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
      assert(() {
        final uri = url.toUri();
        final host = uri?.host;
        final path = uri?.path;
        final query = uri?.query;
        l.d("onSelfShouldOverrideUrlLoading->$url");
        return true;
      }());
    }
    return super.onSelfShouldOverrideUrlLoading(controller, navigationAction);
  }
}
