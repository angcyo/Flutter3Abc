import 'package:flutter3_flame/flutter3_flame.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/09
///
/// 游戏配置
class DuelGameConfig {
  //--

  /// 士兵精灵缩放比例
  static double soldierScale = 3;

  /// 兽人精灵缩放比例
  static double orcScale = 3;

  //--

  /// 基础攻击增加步长
  int baseAttackStep = 10;

  /// 基础防御增加步长
  int baseDefenseStep = 5;

  /// 基础HP增加步长
  int baseHPStep = 50;

  /// 暴击率增加步长
  double baseCritChanceStep = 0.01;

  /// 命中率增加步长
  double accuracyStep = 0.1;

  /// 闪避率增加步长
  double dodgeChanceStep = 0.01;

  /// 防御穿透增加步长
  double penetrationStep = 5;

  /// 吸血增长比例
  double lifestealStep = 0.01;

  /// 反伤增长比例
  double reflectStep = 0.01;

  //--

  /// 最大暴击率
  double maxCritChance = 1;

  /// 最大闪避率
  double maxDodgeChance = 0.5;

  /// 最大吸血率
  double maxLifesteal = 0.8;

  /// 最大反伤率
  double maxReflect = 0.8;

  //--

  /// 第一阶段的持续时间 s
  double phase1Duration = isDebugMode ? 1 : 10;

  /// 战斗移动时间 s
  double combatMoveTime = 1;

  /// 战斗每回合结算时间 s
  double combatTurnTime = 1;

  //--

  /// 游戏难度等级, 1-5
  /// - 值越小，难度越小
  int gameDifficulty = 1;
}
