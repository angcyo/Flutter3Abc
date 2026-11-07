import 'package:flame_games/src/games/base_game_controller.dart';
import 'package:flame_games/src/games/ships/ships_game_config.dart';
import 'package:flame_games/src/games/ships/ships_game_screen.dart';
import 'package:flutter3_basics/flutter3_basics.dart' as fb;
import 'package:flutter3_flame/flutter3_flame.dart';

import 'component/ships_spirit.dart';
import 'data/ships_data.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/05
///
/// 飞船游戏控制器
class ShipsGameController extends BaseGameController {
  /// 游戏配置
  final ShipsGameConfig config;

  /// 飞船的大小
  final double shipsSize = 32;

  /// 是否定住了敌机?
  @fb.configProperty
  bool isEnemyFixed = false;

  /// 玩家2的分数
  /// - [gameScore]
  @fb.configProperty
  int gameScore2 = 0;

  @override
  String get scoreText =>
      config.playerCount == 2 ? "$gameScore | $gameScore2" : "$gameScore";

  /// 玩家的HP文本
  @fb.configProperty
  String playerHpText = "";

  @override
  String? get otherLabel => "HP: ";

  @override
  String get otherText => playerHpText;

  ShipsGameController({required this.config});

  //MARK: - method

  /// 分配玩家的起始位置
  /// - [player] 玩家
  /// - [gameSize] 游戏大小
  /// - [playerIndex] 玩家索引[0]or[1]
  PositionComponent allocatePlayerStartPosition(
    PositionComponent player,
    Vector2 gameSize,
    int playerIndex,
  ) {
    final bottom = gameSize.y - player.height - player.height;
    if (config.playerCount == 1) {
      // 单人模式，玩家在中间
      player.position = Vector2(gameSize.x / 2 + player.width / 2, bottom);
    } else if (config.playerCount == 2) {
      // 双人模式，玩家在两侧中间
      player.position = Vector2(
        playerIndex == 0
            ? gameSize.x / 4 - player.width / 2
            : gameSize.x * 3 / 4 - player.width / 2,
        bottom,
      );
    }
    return player;
  }

  /// 发射一颗子弹
  void shootBullet(PositionComponent from, ShipsData data) {
    final isPlayer = data.isPlayer;
    from.world?.add(
      ShipsBulletSpirit(data)
        ..anchor = isPlayer ? .bottomCenter : .topCenter
        ..position =
            from.positionOfAnchor(isPlayer ? .topCenter : .bottomCenter) +
            Vector2(0, isPlayer ? from.size.y / 2 : from.size.y),
    );
  }

  /// 玩家子弹命中敌机
  /// - [bullet] 玩家的子弹
  /// - [enemy] 敌机
  void playerBulletHitEnemy(ShipsBulletSpirit bullet, ShipsEnemySpirit enemy) {
    // 删除子弹和敌机
    enemy.shipsData.hp -= bullet.shipsData.config.bulletDamage.round();
    bullet.removeFromParent();
    if (enemy.shipsData.hp <= 0) {
      enemy.removeFromParent();
      enemy.world?.add(
        ShipsBombAnimation()
          ..position = enemy.center
          ..anchor = .center
          ..scale = Vector2.all(2),
      );
      //增加分数
      final playerIndex = bullet.shipsData.playerIndex;
      if (playerIndex != null) {
        if (playerIndex == 1) {
          gameScore2 += enemy.shipsData.config.score;
        } else {
          gameScore += enemy.shipsData.config.score;
        }
        checkPlayerUpdateLevel(enemy.world as ShipsWorld?, playerIndex);
      }
    } else {
      /*enemy.removeAllEffect(test: (e) => e is OpacityEffect);
      enemy.add(OpacityEffect.to(0.2, EffectController(duration: 0.75)));*/
      if (!enemy.hasChild(test: (e) => e is BlinkEffect)) {
        enemy.add(BlinkEffect());
      }
    }
  }

  /// 玩家被击中
  /// - 被子弹
  /// - 被敌机
  void playerHitByBullet(ShipsPlayerSpirit player, ShipsData enemy) {
    player.shipsData.hp -= enemy.config.bulletDamage.round();
    if (player.shipsData.hp <= 0) {
      player.removeFromParent();
      player.world?.add(
        ShipsBombAnimation()
          ..position = player.center
          ..anchor = .center
          ..scale = Vector2.all(2),
      );
    } else {
      if (!player.hasChild(test: (e) => e is BlinkEffect)) {
        player.add(BlinkEffect());
      }
    }
  }

  /// 检查玩家等级更新
  void checkPlayerUpdateLevel(ShipsWorld? world, int playerIndex) {
    final score = playerIndex == 1 ? gameScore2 : gameScore;
    int level = 0;
    if (score > 1000 || (isDebugMode && score > 100)) {
      level = 2;
    } else if (score > 300 || (isDebugMode && score > 30)) {
      level = 1;
    }
    world?.onPlayerLevelUpdate(playerIndex, level);
  }

  //MARK: - random

  /// 随机敌人配置
  /// - [level] 游戏等级
  ShipsConfigData randomEnemyConfig(int level) {
    final shipsEnemyConfigs = switch (level) {
      0 => shipsEnemyLevel0Configs,
      1 => shipsEnemyLevel1Configs,
      2 => shipsEnemyLevel2Configs,
      _ => [...shipsEnemyLevel2Configs, ShipsConfigData.level(level)],
    };
    final totalWeight = shipsEnemyConfigs.fold<int>(
      0,
      (sum, config) => sum + config.weight,
    );
    var value = fb.nextInt(totalWeight);
    for (final config in shipsEnemyConfigs) {
      value -= config.weight;

      if (value < 0) {
        return config;
      }
    }
    return shipsEnemyConfigs.last;
  }

  /// 随机敌人位置
  Vector2 randomEnemyPosition({required Vector2 gameSize}) {
    final minX = -shipsSize / 2;
    final maxX = gameSize.x + shipsSize / 2;
    final x = minX + fb.nextDouble() * (maxX - minX);
    return Vector2(x, -shipsSize);
  }

  Vector2? randomEnemyPositionWithSpacing({
    required Vector2 gameSize,
    required List<Vector2> existingPositions,
    double minSpacing = 60,
    int maxAttempts = 20,
  }) {
    final minX = -shipsSize / 2;
    final maxX = gameSize.x + shipsSize / 2;

    for (var i = 0; i < maxAttempts; i++) {
      final x = minX + fb.nextDouble() * (maxX - minX);
      final position = Vector2(x, -shipsSize);
      final valid = existingPositions.every((other) {
        return (position.x - other.x).abs() >= minSpacing;
      });

      if (valid) {
        return position;
      }
    }

    // 多次尝试仍找不到合适位置
    // 返回 null，表示本次不生成
    return null;
  }
}
