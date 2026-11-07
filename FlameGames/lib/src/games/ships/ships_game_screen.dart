import 'dart:async';

import 'package:flame_games/src/games/game_hud_component.dart';
import 'package:flame_games/src/games/ships/ships_game_config.dart';
import 'package:flame_games/src/games/ships/ships_game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter3_basics/flutter3_basics.dart' as fb;
import 'package:flutter3_flame/flutter3_flame.dart';

import '../../assets/game_assets.dart';
import '../../assets/pixel_shmup_assets.dart';
import '../base_game_mixin.dart';
import 'component/ships_enemy_spawner.dart';
import 'component/ships_spirit.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/05
///
/// 飞船游戏 / 打飞机游戏
/// https://kenney.nl/assets/pixel-shmup
class ShipsGameScreen extends StatefulWidget with fb.TranslationTypeMixin {
  final ShipsGameConfig config;

  @override
  fb.TranslationType get translationType => .none;

  const ShipsGameScreen({super.key, required this.config});

  @override
  State<ShipsGameScreen> createState() => _ShipsGameScreenState();
}

class _ShipsGameScreenState extends State<ShipsGameScreen>
    with BaseGameStateMixin {
  @override
  void initGameScreenStyle() {
    super.initGameScreenStyle();
    if (widget.config.playerCount == 2) {
      fb.setScreenLandscape();
    } else {
      fb.setScreenPortrait();
    }
  }

  @override
  Game buildGame() => ShipsGame(world: ShipsWorld(config: widget.config));
}

//MARK: - Game

/// 游戏主体
class ShipsGame extends BaseFlameGame<ShipsWorld> {
  ShipsGame({super.world});

  @override
  FutureOr<void> onLoad() async {
    camera.viewfinder.anchor = .topLeft;
    await $pixelShmupAssets.loadFromAssets(this);
    return super.onLoad();
  }
}

//MARK: - World

/// 游戏世界
class ShipsWorld extends BaseFlameWorld with HasCollisionDetection {
  final ShipsGameConfig config;

  final ShipsGameController controller;

  ShipsWorld({required this.config})
    : controller = ShipsGameController(config: config);

  @override
  void onReloadWorld(Vector2 size) {
    super.onReloadWorld(size);
    add(ShipsEnemySpawner());
    for (var i = 0; i < config.playerCount; i++) {
      add(
        controller.allocatePlayerStartPosition(
          ShipsPlayerSpirit(playerIndex: i),
          size,
          i,
        ),
      );
    }
    add(ShipsHudComponent());

    //添加敌机测试
    if (isDebugMode) {
      /*controller.isEnemyFixed = true;

      add(
        ShipsEnemySpirit(
          shipsData: ShipsData(
            config: controller.randomEnemyConfig(10),
            position: size / 2,
          ),
        ),
      );*/

      /*add(
        ShipsEnemySpirit(
          shipsData: ShipsData(
            config: ShipsConfigData.level(0),
            position: size / 2,
          ),
        ),
      );
      add(
        ShipsEnemySpirit(
          shipsData: ShipsData(
            config: ShipsConfigData.level(1),
            position: size / 2 + Vector2(32, 0),
          ),
        ),
      );
      add(
        ShipsEnemySpirit(
          shipsData: ShipsData(
            config: ShipsConfigData.level(2),
            position: size / 2 + Vector2(64, 0),
          ),
        ),
      );
      add(
        ShipsEnemySpirit(
          shipsData: ShipsData(
            config: ShipsConfigData.level(3),
            position: size / 2 + Vector2(32 * 3, 0),
          ),
        ),
      );*/
    }
  }

  @override
  void destroyAllChildren() {
    removeAllChildren();
  }

  @override
  void update(double dt) {
    super.update(dt);
    int player1Hp = 0;
    int player2Hp = 0;
    findChild<ShipsPlayerSpirit>((e) {
      if (e is ShipsPlayerSpirit) {
        if (e.playerIndex == 0) {
          player1Hp = e.shipsData.hp;
        } else if (e.playerIndex == 1) {
          player2Hp = e.shipsData.hp;
        }
      }
      return false;
    });
    if (controller.config.playerCount == 2) {
      controller.playerHpText = "$player1Hp | $player2Hp";
    } else {
      controller.playerHpText = "$player1Hp";
    }
  }

  /// 玩家等级更新
  void onPlayerLevelUpdate(int playerIndex, int level) {
    findChild<ShipsPlayerSpirit>(
      (e) => e is ShipsPlayerSpirit && e.playerIndex == playerIndex,
    )?.updatePlayerLevel(level);
  }
}

//MARK: - Component

extension ShipsComponentEx on Component {
  /// - [ShipsGameController]
  ShipsGameController get shipsGameController => findGameController();

  /// - [ShipsWorld]
  ShipsWorld get shipsWorld => findParent<ShipsWorld>(includeSelf: true)!;
}

class ShipsHudComponent extends GameHudComponent {
  @override
  Future<Iterable<Component>?> loadControlComponent() async {
    final parent = findParent<ShipsWorld>();
    return [
      if (parent != null)
        SpriteComponent(
          sprite: $gameAssets.gameIcons.returnSprite,
          scale: Vector2(-1, 1),
        ).button(() {
          // 移除所有球
          //parent.world.removeAllChildren((e) => e is Archery);
          parent.reloadWorld();
        }),
      ...?(await super.loadControlComponent()),
    ];
  }
}
