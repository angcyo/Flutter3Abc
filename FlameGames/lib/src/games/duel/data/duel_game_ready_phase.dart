import 'dart:async';
import 'dart:ui';

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
    //-- 添加倒计时组件
    world.add(
      CountdownComponent(
          duration: config.phase1Duration * config.gameDifficulty,
          fontSize: 80,
          onComplete: onComplete,
        )
        /*..debugMode = isDebugMode*/
        ..anchor = .center
        ..position = world.findGame()!.canvasSize / 2,
    );
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
          onChanged: () {
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
          onChanged: () {
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

  final void Function()? onChanged;

  /// 游戏难度
  int get gameDifficulty => controller.config.gameDifficulty;

  DuelCombatStatsTapEditComponent(
    this.controller,
    this.combatStats, {
    this.isRight = false,
    this.onChanged,
  }) : super();

  @override
  FutureOr<void> onLoad() {
    final startLeft = size.x / 3;
    final startTop =
        size.y /
        (gameDifficulty > 2
            ? 5
            : gameDifficulty > 1
            ? 4
            : 3);
    final fontSize = fb.isMobile ? 14.0 : 24.0;
    final padding = fb.isMobile
        ? fb.insets(h: 16, v: 2)
        : fb.insets(h: 16, v: 8);
    append(
      GameButtonComponent(
        text: '攻击 +${controller.config.baseAttackStep}',
        color: GameAttributeColors.attack,
        onPressed: () {
          combatStats.baseAttack += controller.config.baseAttackStep;
          onChanged?.call();
        },
        fontSize: fontSize,
        padding: padding,
      )..position = Vector2(isRight ? size.x - startLeft : startLeft, startTop),
    );
    append(
      GameButtonComponent(
        text: '防御 +${controller.config.baseDefenseStep}',
        color: GameAttributeColors.defense,
        onPressed: () {
          combatStats.baseDefense += controller.config.baseDefenseStep;
          onChanged?.call();
        },
        fontSize: fontSize,
        padding: padding,
      ),
      offset: Vector2(0, 10),
    );
    append(
      GameButtonComponent(
        text: '血量 +${controller.config.baseHPStep}',
        color: GameAttributeColors.health,
        onPressed: () {
          combatStats.baseHP += controller.config.baseHPStep;
          onChanged?.call();
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
          text: '暴击率 +${controller.config.baseCritChanceStep.percent}',
          color: GameAttributeColors.criticalRate,
          onPressed: () {
            combatStats.baseCritChance += controller.config.baseCritChanceStep;
            combatStats.baseCritChance = combatStats.baseCritChance.clamp(
              0,
              controller.config.maxDodgeChance,
            );
            onChanged?.call();
          },
          fontSize: fontSize,
          padding: padding,
        ),
        offset: Vector2(0, 10),
      );
      append(
        GameButtonComponent(
          text: '命中率 +${controller.config.accuracyStep.percent}',
          color: GameAttributeColors.hitRate,
          onPressed: () {
            combatStats.accuracy += controller.config.accuracyStep;
            combatStats.accuracy = combatStats.accuracy.clamp(0, 1);
            onChanged?.call();
          },
          fontSize: fontSize,
          padding: padding,
        ),
        offset: Vector2(0, 10),
      );
      append(
        GameButtonComponent(
          text: '闪避率 +${controller.config.dodgeChanceStep.percent}',
          color: GameAttributeColors.dodgeRate,
          onPressed: () {
            combatStats.dodgeChance += controller.config.dodgeChanceStep;
            combatStats.dodgeChance = combatStats.dodgeChance.clamp(
              0,
              controller.config.maxDodgeChance,
            );
            onChanged?.call();
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
          text: '穿透 +${controller.config.penetrationStep.toInt()}',
          color: GameAttributeColors.defensePenetration,
          onPressed: () {
            combatStats.penetration += controller.config.penetrationStep;
            onChanged?.call();
          },
          fontSize: fontSize,
          padding: padding,
        ),
        offset: Vector2(0, 10),
      );
      append(
        GameButtonComponent(
          text: '吸血 +${controller.config.lifestealStep.percent}',
          color: GameAttributeColors.lifesteal,
          onPressed: () {
            combatStats.lifesteal += controller.config.lifestealStep;
            combatStats.lifesteal = combatStats.lifesteal.clamp(
              0,
              controller.config.maxLifesteal,
            );
            onChanged?.call();
          },
          fontSize: fontSize,
          padding: padding,
        ),
        offset: Vector2(0, 10),
      );
      append(
        GameButtonComponent(
          text: '反伤 +${controller.config.reflectStep.percent}',
          color: GameAttributeColors.reflectDamage,
          onPressed: () {
            combatStats.reflect += controller.config.reflectStep;
            combatStats.reflect = combatStats.reflect.clamp(
              0,
              controller.config.maxReflect,
            );
            onChanged?.call();
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
      fontSize: fb.isMobile ? 14 : 18,
    ),
  );

  /// 游戏难度
  int get gameDifficulty => controller.config.gameDifficulty;

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
    if (isRight) {
      _textComponent.text =
          '${hp ?? combatStats.baseHP.toInt()} :血量\n'
          '${combatStats.baseAttack.toInt()} :攻击\n'
          '${combatStats.baseDefense.toInt()} :防御';
      if (gameDifficulty > 1) {
        _textComponent.text +=
            '\n${combatStats.baseCritChance.percent} :暴击率\n'
            '${combatStats.accuracy.percent} :命中率\n'
            '${combatStats.dodgeChance.percent} :闪避率';
      }
      if (gameDifficulty > 2) {
        _textComponent.text +=
            '\n${combatStats.penetration.toInt()} :穿透\n'
            '${combatStats.lifesteal.percent} :吸血\n'
            '${combatStats.reflect.percent} :反伤';
      }
    } else {
      _textComponent.text =
          '血量: ${hp ?? combatStats.baseHP.toInt()}\n'
          '攻击: ${combatStats.baseAttack.toInt()}\n'
          '防御: ${combatStats.baseDefense.toInt()}';
      if (gameDifficulty > 1) {
        _textComponent.text +=
            '\n暴击率: ${combatStats.baseCritChance.percent}\n'
            '命中率: ${combatStats.accuracy.percent}\n'
            '闪避率: ${combatStats.dodgeChance.percent}';
      }
      if (gameDifficulty > 2) {
        _textComponent.text +=
            '\n穿透: ${combatStats.penetration.toInt()}\n'
            '吸血: ${combatStats.lifesteal.percent}\n'
            '反伤: ${combatStats.reflect.percent}';
      }
    }
    size = _textComponent.size;
  }
}
