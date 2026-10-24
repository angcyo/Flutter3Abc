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
    //setScreenOrientation();
    //setEnabledSystemUIMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: buildGame());
  }

  /// 创建游戏
  @overridePoint
  Game buildGame();
}
