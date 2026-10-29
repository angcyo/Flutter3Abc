import 'package:flutter3_basics/flutter3_basics.dart' as fb;

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/28
///
/// 弹球乐游戏配置
class PinballGameConfig {
  /// 玩家数量
  int playerCount = 1;

  /// 球的半径
  @fb.mm
  double ballRadius = 0.1;

  /// 顶部障碍球的大小
  @fb.mm
  double topObstacleBallRadius = 0.04;

  /// 中间障碍球的大小
  @fb.mm
  double obstacleBallRadius = 0.02;

  /// 每一行障碍球的数量
  int obstacleBallCountPerRow = 12;

  /// 行之间的间距
  @fb.mm
  double obstacleBallRowGap = 0.5;

  //MARK: Board

  /// 顶部弧形半径, 在高度范围内
  @fb.mm
  double boardArchRadius = 0.5;

  /// 顶部左侧/右侧挡板大小
  @fb.mm
  double boardWardSize = 0.3;

  /// 背景板的高度
  @fb.mm
  double boardHeight = 4.0;

  /// 背景板的宽度
  @fb.mm
  late double boardWidth = boardHeight * 3 / 4;

  /// 得分障碍的高度
  @fb.mm
  late double scoringObstacleHeight = ballRadius * 10;
}
