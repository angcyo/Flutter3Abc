import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter3_basics/flutter3_basics.dart' as fb;

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/26
///
/// 掷球游戏配置
class ThrowBallGameConfig {

  /// 球的半径
  @fb.mm
  double ballRadius = 0.2;

  /// 桶的宽度
  @fb.mm
  double bucketWidth = 1.0;

  /// 桶的高度
  @fb.mm
  double bucketHeight = 2.0;

  /// 额外的偏移x
  @fb.mm
  double bucketOffsetX = 0.0;

  /// 额外的偏移y
  @fb.mm
  double bucketOffsetY = 0.0;

  /// 桶旋转的弧度
  double bucketAngle = -30.hd;

  /// 发射区域宽度占比
  double launchAreaRatio = 0.3;

  @fb.mm
  fb.UiRect get bucketRect =>
      fb.UiRect.fromLTWH(0, 0, bucketWidth, bucketHeight);

  @fb.mm
  fb.UiRect get bucketRotateRect =>
      bucketRect.rotate(bucketAngle, anchorX: 0, anchorY: 0);
}

/// 投掷轨迹
class BallTrajectory {
  /// 起点
  Vector2? start;

  /// 终点
  Vector2? end;

  void startWith(Vector2 position){
    start = position;
    end = position;
  }

  void endWith(Vector2 position){
    end = position;
  }

}
