import 'dart:async';

import 'package:flame_games/src/games/ships/component/ships_spirit.dart';
import 'package:flutter3_flame/flutter3_flame.dart';

import '../ships_game_screen.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/07
///
/// 飞船移动 mixin
mixin ShipsMoveMixin on PositionComponent {
  @override
  void update(double dt) {
    super.update(dt);

    final that = this;
    if (that is ShipsEnemySpirit) {
      if (!shipsGameController.isEnemyFixed) {
        position.y += that.shipsData.speed * dt;
      }
    }
  }
}

/// 子弹移动 mixin
mixin ShipsBulletMoveMixin on PositionComponent {
  @override
  FutureOr<void> onLoad() {
    add(OffScreenRemoveEffect());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    final that = this;
    if (that is ShipsBulletSpirit) {
      if (that.shipsData.isPlayer) {
        position.y -= that.shipsData.bulletSpeed * dt;
      } else {
        position.y += that.shipsData.bulletSpeed * dt;
      }
      // 子弹速度增加
      that.shipsData.bulletSpeed +=
          that.shipsData.config.bulletAcceleration * dt;
    }
  }
}
