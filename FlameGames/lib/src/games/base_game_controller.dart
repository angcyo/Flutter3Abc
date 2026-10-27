import 'package:flutter3_basics/flutter3_basics.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/27
///
/// 游戏基础控制器
abstract class BaseGameController {

  String durationLabel = "用时: ";
  String scoreLabel = "分数: ";

  //--

  /// 游戏累加的时长, 毫秒
  int gameDuration = 0;

  /// 游戏得分
  int gameScore = 0;

  //--

  /// 游戏是否完成
  bool get isGameSolved => false;

  //--

  /// 游戏时长文本
  String get durationText => gameDuration.toMSTime();

  /// 游戏得分文本
  String get scoreText => gameScore.toString();
}
