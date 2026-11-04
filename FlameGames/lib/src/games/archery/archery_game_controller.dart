import 'package:flame_games/src/games/archery/archery_game_config.dart';
import 'package:flame_games/src/games/base_game_controller.dart';
import 'package:flutter3_basics/flutter3_basics.dart' as fb;
import 'package:flutter3_flame/flutter3_flame.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/03
///
/// 射箭游戏控制器
class ArcheryGameController extends BaseGameController {
  late ArcheryGameConfig config;

  /// 游戏有效区域
  @fb.mm
  Rect? playerAreaRect;

  /// 游戏内部得分
  int innerScore = 0;

  @override
  String get scoreText => "$innerScore/$gameScore";

  /// 当前手势是否在有效区域
  bool isInPlayerArea(Vector2 localPosition) {
    if (playerAreaRect?.contains(localPosition.toOffset()) == true ||
        isDebugMode) {
      return true;
    }
    return false;
  }

  @override
  Vector2 getBallImpulse(Vector2 p1, Vector2 p2) {
    /*final distance = p1.distanceTo(p2);

    // 拉弓距离限制
    final pullRatio = (distance / config.maxPullDistance)
        .clamp(0.0, 1.0)
        .toDouble();

    // 非线性蓄力
    final power = math.pow(
      pullRatio,
      config.powerExponent,
    ).toDouble();*/
    return super.getBallImpulse(p1, p2) * 6;
  }
}
