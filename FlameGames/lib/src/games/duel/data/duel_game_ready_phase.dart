import 'dart:async';
import 'dart:ui';

import 'package:flame_games/src/games/duel/duel_game_config.dart';
import 'package:flutter3_basics/flutter3_basics.dart' as fb;
import 'package:flutter3_flame/flutter3_flame.dart';

import '../duel_game_controller.dart';
import '../duel_game_screen.dart';
import 'duel_game_phase.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/09
///
/// 游戏准备阶段
class DuelGameReadyPhase extends DuelGamePhase {
  final DuelWorld world;
  final VoidCallback? onComplete;

  DuelGameReadyPhase(this.world, {this.onComplete}) : super(.ready);

  @override
  void onEnter(BaseGamePhase? prevPhase) {
    super.onEnter(prevPhase);
    //-- 初始化战斗统计
    final controller = world.controller;
    final config = controller.config;
    final gameDifficulty = config.gameDifficulty;
    controller.combatStatsSoldier = gameDifficulty > 2
        ? DuelGameController.defCombatStats3
        : gameDifficulty > 1
        ? DuelGameController.defCombatStats2
        : DuelGameController.defCombatStats1;
    controller.combatStatsOrc = gameDifficulty > 2
        ? DuelGameController.defCombatStats3
        : gameDifficulty > 1
        ? DuelGameController.defCombatStats2
        : DuelGameController.defCombatStats1;
    //游戏模式
    //-- 添加倒计时组件
    final countdownComponent = CountdownComponent(
      autoStart: config.gameMode == .speed,
      duration: config.phase1Duration * config.gameDifficulty,
      fontSize: 80,
      onComplete: onComplete,
    );
    world.add(
      countdownComponent /*..debugMode = isDebugMode*/
        ..anchor = .center
        ..position = world.findGame()!.canvasSize / 2,
    );
    //--固定模式
    // 剩余点击次数
    int soldierRemainingTapCount = config.maxTapCount;
    int orcRemainingTapCount = config.maxTapCount;
    void updateFixedModeText() {
      if (config.gameMode == .fixed) {
        countdownComponent.text =
            '$soldierRemainingTapCount ：$orcRemainingTapCount';
        if (soldierRemainingTapCount <= 0 && orcRemainingTapCount <= 0) {
          countdownComponent.onSelfComplete();
        }
      }
    }

    updateFixedModeText();

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
    world.add(
      DuelCombatStatsTapEditComponent(
          controller,
          controller.combatStatsSoldier,
          onChanged: (tapCount) {
            soldierRemainingTapCount = config.maxTapCount - tapCount;
            updateFixedModeText();
            soldierInfo.updateText();
          },
        )
        /*..debugMode = isDebugMode*/
        ..size = Vector2(w / 2, h),
    );
    world.append(
      DuelCombatStatsTapEditComponent(
          controller,
          controller.combatStatsOrc,
          isRight: true,
          onChanged: (tapCount) {
            orcRemainingTapCount = config.maxTapCount - tapCount;
            updateFixedModeText();
            orcInfo.updateText();
          },
        )
        /*..debugMode = isDebugMode*/
        ..size = Vector2(w / 2, h),
      direction: .horizontal,
    );
    world.add(soldierInfo);
    world.add(orcInfo..position = Vector2(w - orcInfo.size.x, 0));
  }

  @override
  void onExit(BaseGamePhase? nextPhase) {
    super.onExit(nextPhase);
    world.removeWhereType<CountdownComponent>();
    world.removeWhereType<DuelCombatStatsTapEditComponent>();
    world.removeWhereType<DuelCombatStatsInfoComponent>();
  }
}

/// 战斗统计编辑组件
class DuelCombatStatsTapEditComponent extends PositionComponent {
  final DuelGameController controller;
  final CombatStats combatStats;

  final bool isRight;

  final void Function(int tapCount)? onChanged;

  /// 游戏配置
  DuelGameConfig get config => controller.config;

  /// 游戏难度
  int get gameDifficulty => config.gameDifficulty;

  DuelCombatStatsTapEditComponent(
    this.controller,
    this.combatStats, {
    this.isRight = false,
    this.onChanged,
  }) : super();

  int get maxTapCount => config.maxTapCount;

  /// 点击次数
  int _tapCount = 0;

  @override
  FutureOr<void> onLoad() {
    final sh = fb.$screenHeight;
    final isSmallScreen = sh < 500;
    final startLeft = size.x / 3;
    final startTop = isSmallScreen && gameDifficulty > 2
        ? size.y / 10
        : (size.y /
              (gameDifficulty > 2
                  ? 5
                  : gameDifficulty > 1
                  ? 4
                  : 3));
    final fontSize = (fb.isMobile && gameDifficulty > 2) ? 16.0 : 24.0;
    final padding = fb.isMobile
        ? fb.insets(
            h: 16,
            v: gameDifficulty > 2
                ? isSmallScreen
                      ? 2
                      : 4
                : 6,
          )
        : fb.insets(h: 16, v: 8);
    final gameDifficultyGap = /*isSmallScreen ? 10.0 :*/ 10.0 * 3;
    //--
    append(
      GameButtonComponent(
        text: '攻击 +${config.baseAttackStep}',
        color: GameAttributeColors.attack,
        onPressed: () {
          if (config.gameMode == .fixed) {
            if (_tapCount < maxTapCount) {
              combatStats.baseAttack += config.baseAttackStep;
              _tapCount++;
            }
          } else {
            combatStats.baseAttack += config.baseAttackStep;
          }
          onChanged?.call(_tapCount);
        },
        fontSize: fontSize,
        padding: padding,
      )..position = Vector2(isRight ? size.x - startLeft : startLeft, startTop),
    );
    append(
      GameButtonComponent(
        text: '防御 +${config.baseDefenseStep}',
        color: GameAttributeColors.defense,
        onPressed: () {
          if (config.gameMode == .fixed) {
            if (_tapCount < maxTapCount) {
              combatStats.baseDefense += config.baseDefenseStep;
              _tapCount++;
            }
          } else {
            combatStats.baseDefense += config.baseDefenseStep;
          }
          onChanged?.call(_tapCount);
        },
        fontSize: fontSize,
        padding: padding,
      ),
      offset: Vector2(0, 10),
    );
    append(
      GameButtonComponent(
        text: '血量 +${config.baseHPStep}',
        color: GameAttributeColors.health,
        onPressed: () {
          if (config.gameMode == .fixed) {
            if (_tapCount < maxTapCount) {
              combatStats.baseHP += config.baseHPStep;
              _tapCount++;
            }
          } else {
            combatStats.baseHP += config.baseHPStep;
          }
          onChanged?.call(_tapCount);
        },
        fontSize: fontSize,
        padding: padding,
      ),
      offset: Vector2(0, 10),
    );
    //--
    if (gameDifficulty > 1) {
      append(
        GameButtonComponent(
          text: '暴击率 +${config.baseCritChanceStep.percent}',
          color: GameAttributeColors.criticalRate,
          onPressed: () {
            if (config.gameMode == .fixed) {
              if (_tapCount < maxTapCount) {
                combatStats.baseCritChance += config.baseCritChanceStep;
                _tapCount++;
              }
            } else {
              combatStats.baseCritChance += config.baseCritChanceStep;
            }
            combatStats.baseCritChance = combatStats.baseCritChance.clamp(
              0,
              config.maxCritChance,
            );
            onChanged?.call(_tapCount);
          },
          fontSize: fontSize,
          padding: padding,
        ),
        offset: Vector2(0, gameDifficultyGap),
      );
      append(
        GameButtonComponent(
          text: '命中率 +${config.accuracyStep.percent}',
          color: GameAttributeColors.hitRate,
          onPressed: () {
            if (config.gameMode == .fixed) {
              if (_tapCount < maxTapCount) {
                combatStats.accuracy += config.accuracyStep;
                _tapCount++;
              }
            } else {
              combatStats.accuracy += config.accuracyStep;
            }
            combatStats.accuracy = combatStats.accuracy.clamp(
              0,
              config.maxAccuracy,
            );
            onChanged?.call(_tapCount);
          },
          fontSize: fontSize,
          padding: padding,
        ),
        offset: Vector2(0, 10),
      );
      append(
        GameButtonComponent(
          text: '闪避率 +${config.dodgeChanceStep.percent}',
          color: GameAttributeColors.dodgeRate,
          onPressed: () {
            if (config.gameMode == .fixed) {
              if (_tapCount < maxTapCount) {
                combatStats.dodgeChance += config.dodgeChanceStep;
                _tapCount++;
              }
            } else {
              combatStats.dodgeChance += config.dodgeChanceStep;
            }
            combatStats.dodgeChance = combatStats.dodgeChance.clamp(
              0,
              config.maxDodgeChance,
            );
            onChanged?.call(_tapCount);
          },
          fontSize: fontSize,
          padding: padding,
        ),
        offset: Vector2(0, 10),
      );
    }
    if (gameDifficulty > 2) {
      append(
        GameButtonComponent(
          text: '穿透 +${config.penetrationStep.toInt()}',
          color: GameAttributeColors.defensePenetration,
          onPressed: () {
            if (config.gameMode == .fixed) {
              if (_tapCount < maxTapCount) {
                combatStats.penetration += config.penetrationStep;
                _tapCount++;
              }
            } else {
              combatStats.penetration += config.penetrationStep;
            }
            onChanged?.call(_tapCount);
          },
          fontSize: fontSize,
          padding: padding,
        ),
        offset: Vector2(0, gameDifficultyGap),
      );
      append(
        GameButtonComponent(
          text: '吸血 +${config.lifestealStep.percent}',
          color: GameAttributeColors.lifesteal,
          onPressed: () {
            if (config.gameMode == .fixed) {
              if (_tapCount < maxTapCount) {
                combatStats.lifesteal += config.lifestealStep;
                _tapCount++;
              }
            } else {
              combatStats.lifesteal += config.lifestealStep;
            }
            combatStats.lifesteal = combatStats.lifesteal.clamp(
              0,
              config.maxLifesteal,
            );
            onChanged?.call(_tapCount);
          },
          fontSize: fontSize,
          padding: padding,
        ),
        offset: Vector2(0, 10),
      );
      append(
        GameButtonComponent(
          text: '反伤 +${config.reflectStep.percent}',
          color: GameAttributeColors.reflectDamage,
          onPressed: () {
            if (config.gameMode == .fixed) {
              if (_tapCount < maxTapCount) {
                combatStats.reflect += config.reflectStep;
                _tapCount++;
              }
            } else {
              combatStats.reflect += config.reflectStep;
            }
            combatStats.reflect = combatStats.reflect.clamp(
              0,
              config.maxReflect,
            );
            onChanged?.call(_tapCount);
          },
          fontSize: fontSize,
          padding: padding,
        ),
        offset: Vector2(0, 10),
      );
    }
    return super.onLoad();
  }
}

/// 战斗统计信息组件
class DuelCombatStatsInfoComponent extends PositionComponent {
  final DuelGameController controller;
  final CombatStats combatStats;
  final bool isRight;

  /// 指定血量文本
  /// - 不指定则使用[combatStats]的基础血量
  String? hp;

  /// 属性提示文本
  late final TextComponent _textComponent = TextComponent(
    textRenderer: TextAlignPaint(
      textAlign: isRight ? .end : .start,
      fontSize: fb.isMobile ? 16 : 18,
    ),
  );

  /// 游戏配置
  DuelGameConfig get config => controller.config;

  /// 游戏难度
  int get gameDifficulty => config.gameDifficulty;

  DuelCombatStatsInfoComponent(
    this.controller,
    this.combatStats, {
    this.isRight = false,
    this.hp,
  }) {
    updateText();
  }

  @override
  FutureOr<void> onLoad() {
    updateText();
    add(_textComponent..position = Vector2(isRight ? -10 : 10, 10));
    return super.onLoad();
  }

  void updateText() {
    final textList = <fb.ListString>[];
    textList.add(
      fb.ListString([
        "血量",
        ":",
        " ",
        hp ?? combatStats.baseHP.toInt(),
      ], reverse: isRight),
    );
    textList.add(
      fb.ListString([
        "攻击",
        ":",
        " ",
        combatStats.baseAttack.toInt(),
      ], reverse: isRight),
    );
    textList.add(
      fb.ListString([
        "防御",
        ":",
        " ",
        combatStats.baseDefense.toInt(),
      ], reverse: isRight),
    );
    if (gameDifficulty > 1) {
      textList.add(
        fb.ListString([
          "暴击率(${config.maxCritChance.percent})",
          ":",
          " ",
          combatStats.baseCritChance.percent,
        ], reverse: isRight),
      );
      textList.add(
        fb.ListString([
          "命中率(${config.maxAccuracy.percent})",
          ":",
          " ",
          combatStats.accuracy.percent,
        ], reverse: isRight),
      );
      textList.add(
        fb.ListString([
          "闪避率(${config.maxDodgeChance.percent})",
          ":",
          " ",
          combatStats.dodgeChance.percent,
        ], reverse: isRight),
      );
    }
    if (gameDifficulty > 2) {
      textList.add(
        fb.ListString([
          "穿透",
          ":",
          " ",
          combatStats.penetration.toInt(),
        ], reverse: isRight),
      );
      textList.add(
        fb.ListString([
          "吸血(${config.maxLifesteal.percent})",
          ":",
          " ",
          combatStats.lifesteal.percent,
        ], reverse: isRight),
      );
      textList.add(
        fb.ListString([
          "反伤(${config.maxReflect.percent})",
          ":",
          " ",
          combatStats.reflect.percent,
        ], reverse: isRight),
      );
    }
    _textComponent.text = textList.join('\n');
    size = _textComponent.size;
  }
}
