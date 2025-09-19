import 'package:flutter/material.dart';
import 'package:flutter3_app/flutter3_app.dart';

import '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2025/09/19
///
/// 导航[Navigator]组件示例
///
class NavigatorAbc extends StatefulWidget {
  const NavigatorAbc({super.key});

  @override
  State<NavigatorAbc> createState() => _NavigatorAbcState();
}

class _NavigatorAbcState extends State<NavigatorAbc> with BaseAbcStateMixin {
  final navigatorKeyList = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  late GlobalKey<NavigatorState> selectedNavigatorKey;

  @override
  void initState() {
    selectedNavigatorKey = navigatorKeyList.first;
    useScroll = false;
    super.initState();
  }

  @override
  Widget buildAbc(BuildContext context) {
    return super.buildAbc(context);
  }

  final double _strokeWidth = 2;

  @override
  WidgetList buildBodyList(BuildContext context) {
    return [
      [
        GradientButton(
          child: "Push".text(),
          onTap: () {
            selectedNavigatorKey.currentState?.pushWidget(NavigatorContentPage(
              content: "Content[${nextInt()}]",
            ));
          },
        ),
        GradientButton(
          child: "Pop".text(),
          onTap: () {
            selectedNavigatorKey.currentState?.pop();
          },
        ),
      ].flowLayout(
        padding: const EdgeInsets.all(kH),
        childGap: kH,
      )!,
      //--
      [
        for (final (index, key) in navigatorKeyList.indexed)
          InsideNavigatorPage(
            navigatorKey: key,
            home: NavigatorContentPage(
              content: "Navigator${index + 1} Content[${nextInt()}]",
            ),
          )
              .bounds(
                  strokeWidth: selectedNavigatorKey == key ? _strokeWidth : 0)
              .listenerPointer(onPointerDown: (detail) {
            selectedNavigatorKey = key;
            updateState();
          }).flowLayoutData(onGetChildConstraints: (parent, child) {
            final constraints = parent.constraints;
            //debugger();
            return BoxConstraints(
              minWidth: 0,
              maxWidth: constraints.maxWidth / 2,
              minHeight: 0,
              maxHeight: constraints.maxHeight / 2,
            );
          })
      ].flowLayout(/*equalWidthRange: "", lineChildCount: 2*/)!.expanded(),
    ];
  }
}

/// 内部导航页面
class InsideNavigatorPage extends StatefulWidget {
  final Key? navigatorKey;
  final Widget home;

  const InsideNavigatorPage({super.key, this.navigatorKey, required this.home});

  @override
  State<InsideNavigatorPage> createState() => _InsideNavigatorPageState();
}

class _InsideNavigatorPageState extends State<InsideNavigatorPage> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      initialRoute: Navigator.defaultRouteName,
      onGenerateRoute: (settings) {
        l.w("NavigatorAbc! onGenerateRoute->$settings");
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => widget.home,
        );
      },
      onUnknownRoute: (settings) {
        l.w("NavigatorAbc! onUnknownRoute->$settings");
        return MaterialPageRoute(
          settings: settings,
          builder: (context) =>
              "NavigatorAbc! onUnknownRoute->$settings".text(),
        );
      },
      onDidRemovePage: (page) {
        l.w("NavigatorAbc! onDidRemovePage->$page");
      },
    );
  }
}

/// 导航详情页面
class NavigatorContentPage extends StatefulWidget {
  final String content;

  const NavigatorContentPage({super.key, required this.content});

  @override
  State<NavigatorContentPage> createState() => _NavigatorContentPageState();
}

class _NavigatorContentPageState extends State<NavigatorContentPage>
    with BaseAbcStateMixin {
  @override
  WidgetList buildBodyList(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    final modelRoute = context.modalRoute;
    final rootNavigator = context.navigatorOf(true);
    final navigator = context.navigatorOf();
    return [
      widget.content.text(style: globalTheme.textDesStyle),
      "root:$rootNavigator\nparent:$navigator".text(),
      context.routeSettings
              ?.toString()
              .text(style: globalTheme.textPlaceStyle) ??
          empty,
      "${modelRoute?.overlayEntries}".text(),
      //--
      [
        GradientButton(
          child: "Push".text(),
          onTap: () {
            context.pushWidget(NavigatorContentPage(
              content: "Inside Content[${nextInt()}]",
            ));
          },
        ),
        GradientButton(
          child: "Pop".text(),
          onTap: () {
            context.pop();
          },
        ),
      ].flowLayout(
        padding: const EdgeInsets.all(kH),
        childGap: kH,
      )!,
    ];
  }
}
