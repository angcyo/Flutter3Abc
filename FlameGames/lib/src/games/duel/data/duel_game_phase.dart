import 'package:flutter3_flame/flutter3_flame.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/09
///
/// 游戏阶段相关
enum DuelGamePhaseType {
  /// 准备阶段
  ready,

  /// 战斗阶段
  combat,

  /// 游戏结束阶段
  gameOver,
}

class DuelGamePhase extends BaseGamePhase {
  final DuelGamePhaseType type;

  DuelGamePhase(this.type);

  @override
  String get name => type.name;
}

class DuelGamePhaseController extends BasePhaseController<DuelGamePhase> {}
