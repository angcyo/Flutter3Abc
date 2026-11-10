import 'package:flame_games/src/games/duel/duel_game_controller.dart';
import 'package:flutter3_flame/flutter3_flame.dart';

import '../../../assets/soldier_orc_assets.dart';
import '../../game_over_component.dart';
import '../component/duel_components.dart';
import '../duel_game_screen.dart';
import 'duel_game_phase.dart';
import 'duel_game_ready_phase.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/09
///
/// 战斗阶段
class DuelGameCombatPhase extends DuelGamePhase {
  final DuelWorld world;

  /// 时间调度器
  final timeScheduler = TimeScheduler();

  DuelGameController get controller => world.controller;

  DuelGameCombatPhase(this.world) : super(.combat);

  @override
  void onEnter(BaseGamePhase? prevPhase) {
    super.onEnter(prevPhase);
    final w = world.gameCanvasSize.x;
    final h = world.gameCanvasSize.y;
    final soldierInfo = DuelCombatStatsInfoComponent(
      controller,
      controller.combatStatsSoldier,
    );
    final orcInfo = DuelCombatStatsInfoComponent(
      controller,
      controller.combatStatsOrc,
      isRight: true,
    );
    world.add(soldierInfo);
    world.add(orcInfo..position = Vector2(w - orcInfo.size.x, 0));
    //--添加士兵 / 兽人
    final cx = w / 2;
    final cy = h / 2;
    final soldier = SoldierSprite(
      Combatant(id: 'soldier', stats: controller.combatStatsSoldier),
    );
    final orc = OrcSprite(
      Combatant(id: 'orc', stats: controller.combatStatsOrc),
    );
    final soldierY = cy - soldier.size.y / 2;
    final orcY = cy - orc.size.y / 2;
    world.add(
      soldier
        ..position = Vector2(cx / 2 - soldier.size.x / 2, soldierY)
        ..currentState = SpriteState.walk.name
        ..add(
          MoveToEffect(
            Vector2(cx - soldier.size.x - soldier.size.x / 2, soldierY),
            EffectController(duration: controller.config.combatMoveTime),
            onComplete: () {
              soldier.currentState = SpriteState.attack.name;
              timeScheduler.every(controller.config.combatTurnTime, (task) {
                startCombatCalc(soldier: soldier, orc: orc);
                soldierInfo.hp = soldier.combatant.hp.toString();
                orcInfo.hp = orc.combatant.hp.toString();
                soldierInfo.updateText();
                orcInfo.updateText();
              });
            },
          ),
        ),
    );
    world.add(
      orc
        ..position = Vector2(w * 3 / 4 - orc.size.x / 2, orcY)
        ..currentState = SpriteState.walk.name
        ..add(
          MoveToEffect(
            Vector2(cx + orc.size.x / 2, orcY),
            EffectController(duration: controller.config.combatMoveTime),
            onComplete: () {
              orc.currentState = SpriteState.attack.name;
            },
          ),
        ),
    );
  }

  @override
  void onExit(BaseGamePhase? nextPhase) {
    super.onExit(nextPhase);
    world.removeWhereType<DuelCombatStatsInfoComponent>();
    world.removeWhereType<SoldierSprite>();
    world.removeWhereType<OrcSprite>();
    world.removeWhereType<GameOverComponent>();
  }

  @override
  void update(double dt) {
    super.update(dt);
    timeScheduler.update(dt);
  }

  /// 开始战斗计算
  void startCombatCalc({
    required SoldierSprite soldier,
    required OrcSprite orc,
  }) {
    if (soldier.combatant.isDead || orc.combatant.isDead) {
      timeScheduler.clear();
      return;
    }
    final combatCalculator = CombatCalculator();
    final combatResult1 = combatCalculator.attackTarget(
      attacker: soldier.combatant,
      defender: orc.combatant,
    );
    _showCombatResult(soldier, orc, combatResult1);
    if (combatResult1.isHit) {
      orc.currentState = SpriteState.hurt.name;
      timeScheduler.delay(controller.config.combatMoveTime / 2, (task) {
        if (!controller.isGameSolved && !orc.combatant.isDead) {
          orc.currentState = SpriteState.attack.name;
        }
      });
    }
    final combatResult2 = combatCalculator.attackTarget(
      attacker: orc.combatant,
      defender: soldier.combatant,
    );
    _showCombatResult(orc, soldier, combatResult2);
    if (combatResult2.isHit) {
      soldier.currentState = SpriteState.hurt.name;
      timeScheduler.delay(controller.config.combatMoveTime / 2, (task) {
        if (!controller.isGameSolved && !soldier.combatant.isDead) {
          soldier.currentState = SpriteState.attack.name;
        }
      });
    }
    //debugger();
    //--
    if (soldier.combatant.isDead) {
      soldier.currentState = SpriteState.death.name;
      orc.currentState = orc.combatant.isDead
          ? SpriteState.death.name
          : SpriteState.idle.name;
      controller.endGame(world);
    }
    if (orc.combatant.isDead) {
      orc.currentState = SpriteState.death.name;
      soldier.currentState = soldier.combatant.isDead
          ? SpriteState.death.name
          : SpriteState.idle.name;
      controller.endGame(world);
    }
  }

  /// 显示战斗结果
  void _showCombatResult(
    PositionComponent from,
    PositionComponent to,
    CombatResult combatResult,
  ) {
    double delay = 0.0;
    int index = 1;
    final moveYByDown = 80.0;
    if (combatResult.isHit) {
      //命中了, 则在目标处显示效果
      if (combatResult.isDodged) {
        world.add(
          DamageTextComponent(
            type: .dodge,
            text: "闪避",
            moveYBy: moveYByDown,
            /*fontSizeScale: 0.5,*/
            position: to.center,
          ),
        );
      } else {
        world.add(
          DamageTextComponent(
            type: combatResult.isCritical ? .critical : .normal,
            text: "-${combatResult.hpDamage}",
            fontSizeScale: combatResult.isCritical ? 1.1 : 1,
            position: to.center,
          ),
        );
      }
      //--吸血
      if (combatResult.isHealed) {
        world.add(
          DamageTextComponent(
            type: .heal,
            text: "+${combatResult.healed}",
            moveYBy: moveYByDown,
            fontSizeScale: 1.1,
            position: from.center,
            delay: delay * index++,
          ),
        );
      } //--反伤
      if (combatResult.isReflected) {
        world.add(
          DamageTextComponent(
            type: .normal,
            text: "-${combatResult.reflectedDamage}",
            moveYBy: moveYByDown,
            fontSizeScale: 1,
            position: from.center,
            delay: delay * index++,
          ),
        );
      }
    } else {
      //未命中, 则在攻击者处显示效果
      world.add(
        DamageTextComponent(
          type: .miss,
          text: "miss",
          moveYBy: moveYByDown,
          /*fontSizeScale: 0.5,*/
          position: from.center,
          delay: delay * index++,
        ),
      );
    }
  }
}
