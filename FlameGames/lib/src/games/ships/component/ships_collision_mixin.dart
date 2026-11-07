import 'dart:async';

import 'package:flame_games/src/games/ships/component/ships_spirit.dart';
import 'package:flutter3_flame/flutter3_flame.dart';

import '../ships_game_screen.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/06
///
/// 碰撞混入
///
/// # 碰撞使用流程
///
/// - 1. 外壳组件使用 [HasCollisionDetection]
/// - 2. 碰撞组件使用 [CollisionCallbacks]
///   - 碰撞组件添加一个碰撞检测器[ShapeHitbox]
///
mixin ShipsCollisionMixin on SpriteComponent, CollisionCallbacks {
  @override
  FutureOr<void> onLoad() {
    add(CircleHitbox());
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    /*assert(() {
      fb.l.d("[${classHash()}]碰撞->${other.classHash()}");
      return true;
    }());*/
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    /*assert(() {
      fb.l.d("[${classHash()}]碰撞开始->${other.classHash()}");
      return true;
    }());*/
    final that = this;
    if (that is ShipsBulletSpirit) {
      if (that.shipsData.isPlayer) {
        if (other is ShipsEnemySpirit) {
          // 玩家子弹击中敌人
          shipsGameController.playerBulletHitEnemy(that, other);
        }
      }
    } else if (that is ShipsPlayerSpirit) {
      if (other is ShipsEnemySpirit) {
        // 玩家被敌机撞击
        shipsGameController.playerHitByBullet(that, other.shipsData);
      } else if (other is ShipsBulletSpirit && !other.shipsData.isPlayer) {
        // 玩家被敌机子弹命中
        shipsGameController.playerHitByBullet(that, other.shipsData);
      }
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    /*assert(() {
      fb.l.v("[${classHash()}]碰撞结束->${other.classHash()}");
      return true;
    }());*/
  }
}
