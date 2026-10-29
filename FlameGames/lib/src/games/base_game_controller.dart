import 'package:flutter3_basics/flutter3_basics.dart' as fb;
import 'package:flutter3_flame/flutter3_flame.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/27
///
/// 游戏基础控制器
abstract class BaseGameController {
  //MARK: config

  String durationLabel = "用时: ";
  String scoreLabel = "分数: ";

  //--

  /// 游戏累加的时长, 毫秒
  int gameDuration = 0;

  /// 游戏得分
  int gameScore = 0;

  //MARK: temp

  /// 发射的球是否停止了移动
  bool isLaunchBallStopped = true;

  //MARK: get

  /// 游戏是否完成
  bool get isGameSolved => false;

  /// 游戏时长文本
  String get durationText => gameDuration.toMSTime();

  /// 游戏得分文本
  String get scoreText => gameScore.toString();

  //MARK: method

  /// 获取一个球的冲量
  Vector2 getBallImpulse(Vector2 p1, Vector2 p2) {
    return calculateImpulse(p1, p2, strength: 1) /*Vector2(1, -1)*/;
  }

  /// 获取一个球速度
  Vector2 getBallVelocity(Vector2 p1, Vector2 p2, double mass) {
    return calculateVelocity(getBallImpulse(p1, p2), mass);
  }

  //--

  /// 发射了一个球的回调
  @fb.overridePoint
  void didLaunchBall(Ball ball) {
    isLaunchBallStopped = false;
    gameScore++;
  }

  /// 发射的球停止了移动回调
  @fb.overridePoint
  void didBallStopped(Ball ball) {
    isLaunchBallStopped = true;
  }

  //--

  @override
  String toString() => classHash();
}
