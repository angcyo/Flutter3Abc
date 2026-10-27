import 'package:flutter3_flame/flutter3_flame.dart';

import '../base_game_controller.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/27
///
/// 掷球游戏控制器
class ThrowBallGameController extends BaseGameController {
  /// 进桶的数量
  int innerScore = 0;

  @override
  String get scoreText => "$innerScore/$gameScore";

  /// 获取一个冲量
  Vector2 getImpulse(Vector2 p1, Vector2 p2) {
    return calculateImpulse(p1, p2, strength: 1) /*Vector2(1, -1)*/;
  }

  /// 获取一个速度
  Vector2 getVelocity(Vector2 p1, Vector2 p2, double mass) {
    return calculateVelocity(getImpulse(p1, p2), mass);
  }
}
