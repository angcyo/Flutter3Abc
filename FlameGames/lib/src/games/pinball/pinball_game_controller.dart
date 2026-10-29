import 'package:flame_games/src/games/base_game_controller.dart';
import 'package:flame_games/src/games/pinball/pinball_game_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter3_basics/flutter3_basics.dart' as fb;
import 'package:flutter3_flame/flutter3_flame.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/28
///
/// 弹球乐游戏控制器
class PinballGameController extends BaseGameController {
  /// 游戏相关配置
  PinballGameConfig? config;

  /// 发送区的边界
  /// 发射区域的边界
  Rect launchAreaBounds = Rect.zero;

  /// 游戏内部得分
  int innerScore = 0;

  @override
  String get scoreText => "$innerScore/$gameScore";

  /// 是否可以发送下一个
  bool get canLaunchNext => isLaunchBallStopped;

  /// 创建障碍点信息
  /// - 坐标位置
  List<ObstacleInfo> createObstaclePoints({
    required double left,
    required double top,
    required double right,
    required double bottom,
    bool isMinScreen = false,
  }) {
    final config = this.config;
    if (config == null) {
      return [];
    }
    final result = <ObstacleInfo>[];
    final leftMargin = config.ballRadius * 2 + 0.1;
    final rightMargin = leftMargin;

    //每个障碍球之间的间隙, 至少要让球能够掉下去, 不能挡住球
    final xMinStep = config.ballRadius * 2 + 0.1;

    //在挡板一行上先创建一排障碍球
    double startX =
        left + config.boardWardSize + config.topObstacleBallRadius * 2;
    while (startX < right) {
      final step = xMinStep + config.topObstacleBallRadius * 2;
      final y = top + config.boardWardSize;
      result.add(
        ObstacleInfo(
          type: .top,
          position: Vector2(startX, y),
          size: Vector2(
            config.topObstacleBallRadius,
            config.topObstacleBallRadius,
          ),
        ),
      );
      startX += step;
    }

    //创建中间的障碍球
    final bottomList = <ObstacleInfo>[];
    final yStep = config.ballRadius * (isMinScreen ? 3 : 5);
    final topMargin = config.ballRadius * (isMinScreen ? 3 : 5);
    final bottomMargin =
        config.scoringObstacleHeight * (isMinScreen ? 2 / 3 : 1);
    startX = left;
    int row = 0;
    double startY = top + yStep + topMargin;
    while (startY < (bottom - bottomMargin)) {
      final xStep = xMinStep + config.obstacleBallRadius * 2;
      startX = left + xStep / 2;
      if (row % 2 == 1) {
        //奇数行, 需要错位偏移
        startX += xStep / 2;
      }
      bottomList.clear();
      while (startX <
          (right - (config.obstacleBallRadius * 3) /*xStep / 2*/ )) {
        final info = ObstacleInfo(
          type: .middle,
          position: Vector2(startX, startY),
          size: Vector2(config.obstacleBallRadius, config.obstacleBallRadius),
        );
        result.add(info);
        bottomList.add(info);
        startX += xStep;
      }
      row++;
      startY += yStep;
    }

    //底部得分区域 U 形
    /*result.add(
      ObstacleInfo(
        type: .bottom,
        position: Vector2(left, bottomList.last.position.y + yStep),
        size: Vector2(
          right - left,
          bottom - bottomList.last.position.y - yStep,
        ),
        isScoringPoint: true,
      ),
    );*/

    final scoringPointCount = kDebugMode
        ? bottomList.length
        : fb.nextInt(bottomList.length ~/ 2, 1);
    final scoringPointIndexList = List.generate(
      scoringPointCount,
      (index) => fb.nextInt(bottomList.length + 1),
    );
    double prevX = left;
    double lastY = bottom;

    for (final (index, info) in bottomList.indexed) {
      final y = info.position.y + yStep;
      lastY = y;
      final w = info.position.x - prevX;
      result.add(
        ObstacleInfo(
          type: .bottom,
          position: Vector2(prevX, y),
          size: Vector2(w, fb.minOf(config.scoringObstacleHeight, bottom - y)),
          isScoringPoint:
              w > config.ballRadius * 2 &&
              scoringPointIndexList.contains(index),
        ),
      );
      prevX = info.position.x;
    }
    //last
    final w = right - prevX;
    result.add(
      ObstacleInfo(
        type: .bottom,
        position: Vector2(prevX, lastY),
        size: Vector2(w, bottom - lastY),
        isScoringPoint:
            w > config.ballRadius * 2 &&
            scoringPointIndexList.contains(bottomList.length),
      ),
    );
    return result;
  }
}

/// 障碍物类型
enum ObstacleType {
  /// 顶部
  top,

  /// 中间
  middle,

  /// 底部
  bottom,
}

class ObstacleInfo {
  /// 类型
  final ObstacleType type;

  /// 位置
  final Vector2 position;

  /// 大小
  final Vector2 size;

  /// 是否是得分点
  final bool isScoringPoint;

  ObstacleInfo({
    required this.type,
    required this.position,
    required this.size,
    this.isScoringPoint = false,
  });
}
