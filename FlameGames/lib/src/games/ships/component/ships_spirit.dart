import 'dart:async';

import 'package:flame_games/src/assets/pixel_shmup_assets.dart';
import 'package:flame_games/src/games/ships/component/ships_collision_mixin.dart';
import 'package:flame_games/src/games/ships/component/ships_move_mixin.dart';
import 'package:flutter3_flame/flutter3_flame.dart';

import '../data/ships_data.dart';
import '../ships_game_screen.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/05
///
/// 飞船玩家精灵
class ShipsPlayerSpirit extends SpriteComponent
    with
        TapCallbacks,
        DragCallbacks,
        TapMoveMixin,
        CollisionCallbacks,
        ShipsCollisionMixin {
  /// 玩家索引 0 or 1
  final int playerIndex;

  /// 玩家等级
  int level;

  /// 飞船数据
  final ShipsData shipsData;

  ShipsPlayerSpirit({this.playerIndex = 0, this.level = 0})
    : shipsData = ShipsData(
        config: ShipsConfigData.level(level, playerIndex: playerIndex),
        position: .zero(),
        playerIndex: playerIndex,
      ) {
    updatePlayerSprite();
    //rotateTo(180);
  }

  @override
  FutureOr<void> onLoad() {
    add(
      IntervalEffect(
        interval: shipsData.config.bulletInterval,
        onTrigger: () {
          shipsGameController.shootBullet(this, shipsData);
        },
      ),
    );
    return super.onLoad();
  }

  ///
  @override
  void render(Canvas canvas) {
    super.render(canvas);

    /*for (final sprite in [
      ...$pixelShmupAssets.allShipsSprites,
      ...$pixelShmupAssets.allShipsGraySprites,
    ]) {
      sprite.render(canvas, position: sprite.srcPosition);
    }
    for (final sprite in [
      $pixelShmupAssets.tilesBulletSprite,
      $pixelShmupAssets.tilesBulletDoubleSprite,
      $pixelShmupAssets.tilesBulletThinSprite,
      $pixelShmupAssets.tilesBulletBombSprite,
      $pixelShmupAssets.tilesBulletMissileSprite,
      $pixelShmupAssets.tilesBulletMissileDoubleSprite,
      $pixelShmupAssets.tilesBulletMissileDoubleType2Sprite,
      $pixelShmupAssets.tilesBulletMissileDoubleType3Sprite,
    ]) {
      //sprite.render(canvas, position: sprite.srcPosition);
    }*/
  }

  /// 根据等级 / 更新玩家精灵
  void updatePlayerSprite() {
    sprite = shipsData.config.type.sprite;
  }

  /// 更新玩家等级到
  void updatePlayerLevel(int level) {
    if (this.level == level) {
      return;
    }
    this.level = level;
    shipsData.config = ShipsConfigData.level(level, playerIndex: playerIndex);
    updatePlayerSprite();
  }

  ///
  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    /*world?.add(
      ShipsBombAnimation()
        ..position = center
        ..anchor = .center
        ..scale = Vector2.all(2),
    );*/
  }
}

/// 飞船敌人精灵
class ShipsEnemySpirit extends SpriteComponent
    with CollisionCallbacks, ShipsCollisionMixin, ShipsMoveMixin {
  /// 飞船敌人数据
  final ShipsData shipsData;

  ShipsEnemySpirit({required this.shipsData}) {
    position = shipsData.position;
    sprite = shipsData.config.type.sprite;
    //anchor = .center;
    //angle = 180.hd;
    rotateTo(180);
  }

  @override
  FutureOr<void> onLoad() {
    add(OffScreenRemoveEffect());
    add(
      IntervalEffect(
        interval: shipsData.config.bulletInterval,
        onTrigger: () {
          shipsGameController.shootBullet(this, shipsData);
        },
      ),
    );
    return super.onLoad();
  }
}

/// 飞船游戏子弹
class ShipsBulletSpirit extends SpriteComponent
    with CollisionCallbacks, ShipsCollisionMixin, ShipsBulletMoveMixin {
  /// 飞船数据
  final ShipsData shipsData;

  ShipsBulletSpirit(this.shipsData) {
    sprite = shipsData.config.type.bulletSprite;
    if (!shipsData.isPlayer) {
      rotateTo(180);
    }
  }
}

/// 飞船被攻击爆炸动画
class ShipsBombAnimation extends SpriteAnimationComponent {
  ShipsBombAnimation({super.removeOnFinish = true})
    : super(animation: $pixelShmupAssets.tilesBombAnimation);
}
