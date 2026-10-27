import 'package:flutter/material.dart';
import 'package:flutter3_basics/flutter3_basics.dart';
import 'package:flutter3_flame/flutter3_flame.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/21
///
/// 游戏基础混入
mixin BaseGameStateMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
  }

  /// 初始化游戏屏幕样式
  @overridePoint
  void initGameScreenStyle() {
    //setScreenOrientation();
    setEnabledSystemUIMode(); //全屏模式
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: buildGame());
  }

  /// 创建游戏
  @overridePoint
  Game buildGame();
}
