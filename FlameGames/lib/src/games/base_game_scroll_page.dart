import 'package:flutter/material.dart';
import 'package:flutter3_core/flutter3_core.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/23
///
/// - [AbsScrollPage.buildScrollBody] 重写界面
mixin BaseGameScrollPage<T extends StatefulWidget> on State<T>, AbsScrollPage {
  @override
  bool? get usePageSafeArea => false;

  @override
  bool? enableAppBar(BuildContext context) => false;

  @override
  Color? getBackgroundColor(BuildContext context) => Colors.black;

  @override
  void initState() {
    updateScreenStyle();
    super.initState();
  }

  /// 更新屏幕样式
  @overridePoint
  void updateScreenStyle() {
    setScreenLandscape();
    //setEnabledSystemUIMode();
  }

  @override
  Widget build(BuildContext context) {
    return super.build(context).darkStatusBar(context);
  }
}
