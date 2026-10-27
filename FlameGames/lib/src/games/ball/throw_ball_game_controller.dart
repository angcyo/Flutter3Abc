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
}
