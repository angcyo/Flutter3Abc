import 'package:flame_games/src/games/base_game_controller.dart';
import 'package:flutter3_flame/flutter3_flame.dart';

import '../game_over_component.dart';
import 'data/duel_game_combat_phase.dart';
import 'data/duel_game_phase.dart';
import 'data/duel_game_ready_phase.dart';
import 'duel_game_config.dart';
import 'duel_game_screen.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/09
///
/// 游戏控制
class DuelGameController extends BaseGameController {
  static CombatStats get defCombatStats1 => CombatStats(
    baseHP: 500,
    baseAttack: 10,
    baseDefense: 5,
    baseCritChance: 0,
    accuracy: 1,
    dodgeChance: 0,
  );

  static CombatStats get defCombatStats2 => CombatStats(
    baseHP: defCombatStats1.baseHP,
    baseAttack: defCombatStats1.baseAttack,
    baseDefense: defCombatStats1.baseDefense,
    //--
    baseCritChance: 0,
    accuracy: 0.1,
    dodgeChance: 0,
  );

  static CombatStats get defCombatStats3 => CombatStats(
    baseHP: defCombatStats2.baseHP,
    baseAttack: defCombatStats2.baseAttack,
    baseDefense: defCombatStats2.baseDefense,
    //--
    baseCritChance: defCombatStats2.baseCritChance,
    accuracy: defCombatStats2.accuracy,
    dodgeChance: defCombatStats2.dodgeChance,
    //--
    penetration: 0,
    lifesteal: 0,
    reflect: 0,
  );

  /// 游戏配置
  final DuelGameConfig config;

  /// 游戏阶段控制器
  final DuelGamePhaseController phaseController = DuelGamePhaseController();

  /// 士兵的 combatStats
  CombatStats combatStatsSoldier = defCombatStats1;

  /// 兽人的 combatStats
  CombatStats combatStatsOrc = defCombatStats1;

  //--

  /// 游戏是否结束
  bool isGameOver = false;

  @override
  bool get isGameSolved => isGameOver;

  DuelGameController({required this.config}) {
    onRestartGame = (from) {
      final world = from?.world;
      if (world is DuelWorld) {
        startGame(world);
      }
    };
  }

  //MARK: phase

  /// 开始游戏
  /// - [DuelGameReadyPhase] 游戏准备阶段
  /// - [DuelGameCombatPhase] 游戏战斗阶段
  void startGame(DuelWorld world) {
    isGameOver = false;
    phaseController.changePhase(
      DuelGameReadyPhase(
        world,
        onComplete: () {
          phaseController.changePhase(DuelGameCombatPhase(world));
        },
      ),
    );
  }

  /// 游戏结束
  void endGame(DuelWorld world) {
    isGameOver = true;
    world.add(GameOverComponent(gap: 100));
  }

  /// 更新
  void update(double dt) {
    phaseController.update(dt);
  }
}
