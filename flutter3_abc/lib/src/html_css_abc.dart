part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/11/08
///

class HtmlCssAbc extends StatefulWidget {
  const HtmlCssAbc({super.key});

  @override
  State<HtmlCssAbc> createState() => _HtmlCssAbcState();
}

class _HtmlCssAbcState extends State<HtmlCssAbc> with BaseAbcStateMixin {
  final html1 = """<div>
        <h1>Demo Page</h1>
        <p>This is a fantastic product that you should buy!</p>
        <h3>Features</h3>
        <ul>
          <li>It actually works</li>
          <li>It exists</li>
          <li>It doesn't cost much!</li>
        </ul>
        <p><a href='https://www.baidu.com'>百度一下</a></p>
        <p><a href='https://www.google.com'>谷歌</a></p>
        <p><a href='https://www.pgyer.com/angcyo'>angcyo</a></p>
        <p><a href='https://www.pgyer.com/LaserPecker'>LaserPecker</a></p>
        <!--You can pretty much put any html in here!-->
      </div>""";

  final html2 = """
        <h1>Hello, World!</h1>
        <p><span style="font-style:italic;">flutter_html</span> supports a variety of HTML and CSS tags and attributes.</p>
        <p>Over a hundred static tags are supported out of the box.</p>
        <p>Or you can even define your own using an <code>Extension</code>: <flutter></flutter></p>
        <p>Its easy to add custom styles to your Html as well using the <code>Style</code> class:</p>
        <p class="fancy">Here's a fancy &lt;p&gt; element!</p>
        """;

  final html3 = """
  感谢您选择使用LaserPecker平台！ 通过我们的 <a href='https://faq.hingin.com/docs/service'>"服务条款"</a>和<a href='https://faq.hingin.com/docs/privacy_creation'>"隐私政策"</a>，我们希望帮助 您了解我们提供的服务以及我们如何收集和 处理您的个人信息。点击“同意”表示 您同意上述和以下协议。
  """;

  final html4 = """
  纯文本:angcyo<br>
  <span>纯文本:angcyo<span>
        <a href='https://www.baidu.com' mode='platformDefault'>百度一下(platformDefault)</a><br>
        <a href='https://www.baidu.com' mode='inAppWebView'>百度一下(inAppWebView)</a><br>
        <a href='https://www.baidu.com' mode='inAppBrowserView' >百度一下(inAppBrowserView)</a><br>
        <a href='https://www.baidu.com' mode='externalApplication'>百度一下(externalApplication)</a><br>
        <a href='https://www.baidu.com' mode='externalNonBrowserApplication'>百度一下(externalNonBrowserApplication)</a>
  """;

  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      html1.toHtmlWidget(context),
      html4.toHtmlWidget(context, onAnchorTap: (url, attributes, element) {
        var mode = element?.attributes["mode"];
        for (var value in LaunchMode.values) {
          if (value.toString() == "LaunchMode.$mode") {
            url?.launch(mode: value).then((value) {
              if (!value) {
                l.w("启动失败:$url");
              }
            });
          }
        }
      }),
      html2.toHtmlWidget(
        context,
        extensions: [
          TagExtension(
            tagsToExtend: {"flutter"},
            child: const FlutterLogo(),
          ),
        ],
        style: {
          "p.fancy": Style(
            textAlign: TextAlign.center,
            padding: HtmlPaddings.all(16),
            backgroundColor: Colors.grey,
            margin: Margins(left: Margin(50, Unit.px), right: Margin.auto()),
            width: Width(300, Unit.px),
            fontWeight: FontWeight.bold,
          ),
        },
      ),
      html3.toHtmlWidget(context),
    ];
  }
}
