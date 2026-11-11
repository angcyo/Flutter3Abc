import 'package:flutter3_basics/flutter3_basics.dart';
import 'package:flutter3_flame/flutter3_flame.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/09
///
/// 游戏配置
class DuelGameConfig {
  //--

  /// 士兵精灵缩放比例
  static double soldierScale = 6;

  /// 兽人精灵缩放比例
  static double orcScale = soldierScale;

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
  double accuracyStep = 0.05;

  /// 闪避率增加步长
  double dodgeChanceStep = 0.02;

  /// 防御穿透增加步长
  double penetrationStep = 2;

  /// 吸血增长比例
  double lifestealStep = 0.01;

  /// 反伤增长比例
  double reflectStep = 0.02;

  //--

  /// 最大暴击率
  double maxCritChance = 0.9;

  /// 最大命中率
  double maxAccuracy = 1;

  /// 最大闪避率
  double maxDodgeChance = 0.4;

  /// 最大吸血率
  double maxLifesteal = 0.8;

  /// 最大反伤率
  double maxReflect = 0.9;

  //--

  /// [DuelGameMode.speed]模式下
  /// 第一阶段的持续时间 s
  @configProperty
  double phase1Duration = isDebugMode ? 1 : 10;

  /// [DuelGameMode.fixed]模式下
  /// 第一阶段的操作次数
  @configProperty
  int phase1TapCount = /*isDebugMode ? 3 :*/ 10;

  /// 最大点击次数
  int get maxTapCount => gameDifficulty * phase1TapCount;

  /// 战斗移动时间 s
  @configProperty
  double combatMoveTime = 1;

  /// 战斗每回合结算时间 s
  @configProperty
  double combatTurnTime = 1;

  //--

  /// 游戏难度等级, 1-5
  /// - 值越小，难度越小
  @configProperty
  int gameDifficulty = 1;

  /// 游戏模式
  @configProperty
  DuelGameMode gameMode = DuelGameMode.speed;
}

enum DuelGameMode {
  /// 竞速模式
  speed,

  /// 固定模式
  fixed,
}
