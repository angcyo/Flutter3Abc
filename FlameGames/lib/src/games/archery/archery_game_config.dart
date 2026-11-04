import 'package:flutter3_basics/flutter3_basics.dart' as fb;

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/03
///
/// 射箭游戏配置
class ArcheryGameConfig {
  /// 玩家控制区域宽度占比, 相对于左边
  double playerAreaRatio = 0.3;

  /// 箭能拉的最大宽度
  @fb.mm
  double archeryMaxWidth = 2;

  /// 箭的高度
  @fb.mm
  double archeryHeight = 0.2;

  //--

  /// 靶子的宽度
  @fb.mm
  double archeryTargetWidth = 1;

  /// 靶子的高度
  @fb.mm
  double archeryTargetHeight = 3;

  /// 靶子的偏移量
  @fb.mm
  fb.Vector2 archeryTargetOffset = fb.Vector2(-0.2, 0);

  /// 靶子的圈圈间隙
  @fb.mm
  double archeryTargetCircleGap = 0.3;
}
