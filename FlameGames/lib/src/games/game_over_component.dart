import 'dart:async';

import 'package:flame_games/src/assets/game_assets.dart';
import 'package:flutter3_flame/flutter3_flame.dart';

import 'game_hud_component.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/10
///
/// 游戏结束组件
class GameOverComponent extends PositionComponent {
  final Vector2 gameOverScale;

  GameOverComponent({
    Vector2? gameOverScale,
    super.position,
    super.size,
    super.scale,
    super.angle,
  }) : gameOverScale = gameOverScale ?? Vector2.all(1.2);

  @override
  FutureOr<void> onLoad() {
    if (size.isZero()) {
      size = findGame()?.size ?? Vector2.zero();
    }
    final onRestartGameFn = baseGameController?.onRestartGame;
    double offsetY = 0;
    if (onRestartGameFn != null) {
      offsetY = $gameAssets.shootingGalleryHud.textGoSprite.srcSize.y;
      add(
        SpriteComponent(
            sprite: $gameAssets.shootingGalleryHud.textGoSprite,
          ).button(() {
            onRestartGameFn.call(this);
          })
          ..center = Vector2(size.x / 2, size.y / 2 + offsetY),
      );
    }
    add(
      SpriteComponent(sprite: $gameAssets.shootingGalleryHud.textGameOverSprite)
        ..scaleTo(gameOverScale)
        ..center = Vector2(size.x / 2, size.y / 2 - offsetY)
        ..add(
          ScaleEffect.by(
            Vector2.all(1.2),
            EffectController(duration: 0.6, infinite: true, alternate: true),
          ),
        ),
    );

    return super.onLoad();
  }
}
