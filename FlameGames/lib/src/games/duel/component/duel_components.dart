import 'dart:async';

import 'package:flame_games/src/games/duel/duel_game_screen.dart';
import 'package:flutter3_flame/flutter3_flame.dart';

import '../../../assets/game_assets.dart';
import '../../../assets/soldier_orc_assets.dart';
import '../../game_hud_component.dart';
import '../duel_game_config.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/09
///
/// Duel game components
/// 士兵精灵组件
class SoldierSprite extends SpriteAnimationComponent
    with
        TapCallbacks,
        DragCallbacks,
        TapMoveMixin,
        SpriteAnimationComponentStateMixin {
  /// 战斗角色
  final Combatant combatant;

  SoldierSprite(this.combatant)
    : super(animation: $soldierOrcAssets.soliderIdleAnimation) {
    /*debugMode = isDebugMode;*/
    scaleTo(Vector2.all(DuelGameConfig.soldierScale));
    spriteState = {
      SpriteState.idle.name: $soldierOrcAssets.soliderIdleAnimation,
      SpriteState.walk.name: $soldierOrcAssets.soliderWalkAnimation,
      SpriteState.attack.name: $soldierOrcAssets.soliderAttackAnimation,
      SpriteState.hurt.name: $soldierOrcAssets.soliderHurtAnimation,
      SpriteState.death.name: $soldierOrcAssets.soliderDeathAnimation,
    };
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (isDebugMode) {
      nextState();
      /*add(
      DamageTextComponent(text: "200", fontSizeScale: 0.5, position: size / 2),
    );*/
      world?.add(
        DamageTextComponent(
          type: .shield,
          text: "-100",
          /*fontSizeScale: 0.5,*/
          position: center,
        ),
      );
    }
    super.onTapDown(event);
  }
}

/// 兽人精灵组件
class OrcSprite extends SpriteAnimationComponent
    with
        TapCallbacks,
        DragCallbacks,
        TapMoveMixin,
        SpriteAnimationComponentStateMixin {
  /// 战斗角色
  final Combatant combatant;

  OrcSprite(this.combatant)
    : super(animation: $soldierOrcAssets.orcIdleAnimation) {
    /*debugMode = isDebugMode;*/
    scaleTo(Vector2(-DuelGameConfig.orcScale, DuelGameConfig.orcScale));
    //flipHorizontallyAroundCenter();
    //flipHorizontally();
    spriteState = {
      SpriteState.idle.name: $soldierOrcAssets.orcIdleAnimation,
      SpriteState.walk.name: $soldierOrcAssets.orcWalkAnimation,
      SpriteState.attack.name: $soldierOrcAssets.orcAttackAnimation,
      SpriteState.hurt.name: $soldierOrcAssets.orcHurtAnimation,
      SpriteState.death.name: $soldierOrcAssets.orcDeathAnimation,
    };
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (isDebugMode) {
      nextState();
      world?.add(
        DamageTextComponent(
          type: .critical,
          text: "200",
          /*fontSizeScale: 0.5,*/
          position: center,
        ),
      );
    }
    super.onTapDown(event);
  }
}

class DuelHudComponent extends GameHudComponent {
  @override
  FutureOr<void> initHudComponents() async {
    add(
      FlowComponent(
        position: Vector2(game.size.x / 2 - 50, 10),
        rowCrossAxisAlignment: .center,
        children: [
          FlameTextComponent(text: baseGameController?.durationLabel ?? "用时: "),
          durationTextComponent,
        ],
      ),
    );
    //--控制
    add(
      FlowComponent(
        position: Vector2(10, 10),
        crossAxisAlignment: .end,
        maxChildrenPerRow: 1,
        children: [
          SpriteComponent(
            sprite: $gameAssets.gameIcons.returnSprite,
            scale: Vector2(-1, 1),
          ).button(() {
            // 重新开始
            final world = findGameWorld<DuelWorld>();
            world?.controller.startGame(world);
          }),
          ...?(await loadControlComponent()),
        ],
      )..debugMode = false,
    );
    //return super.initHudComponents();
  }
}
