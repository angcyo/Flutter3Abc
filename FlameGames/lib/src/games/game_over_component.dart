import 'dart:async';
import 'dart:ui';

import 'package:flame_games/src/assets/game_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter3_flame/flutter3_flame.dart';

import 'game_hud_component.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/10
///
/// 游戏结束组件
class GameOverComponent extends PositionComponent {
  /// 蒙层颜色
  final Color? maskColor;

  /// 模糊半径
  final double maskBlurSigma;

  /// 游戏结束文字缩放
  final Vector2 gameOverScale;

  /// GameOver
  /// !gap!
  /// Go
  final double gap;

  GameOverComponent({
    Vector2? gameOverScale,
    super.position,
    super.size,
    super.scale,
    super.angle,
    this.maskColor = Colors.black26,
    this.maskBlurSigma = 10,
    this.gap = 0,
  }) : gameOverScale = gameOverScale ?? Vector2.all(1.2);

  @override
  FutureOr<void> onLoad() {
    if (size.isZero()) {
      size = findGame()?.size ?? Vector2.zero();
    }
    final onRestartGameFn = baseGameController?.onRestartGame;
    double offsetY = 0;
    if (onRestartGameFn != null) {
      //go
      offsetY = $gameAssets.shootingGalleryHud.textGoSprite.srcSize.y;
      add(
        SpriteComponent(
            sprite: $gameAssets.shootingGalleryHud.textGoSprite,
          ).button(() {
            onRestartGameFn.call(this);
          })
          ..center = Vector2(size.x / 2, size.y / 2 + offsetY + gap / 2),
      );
    }
    //game over
    add(
      SpriteComponent(sprite: $gameAssets.shootingGalleryHud.textGameOverSprite)
        ..scaleTo(gameOverScale)
        ..center = Vector2(size.x / 2, size.y / 2 - offsetY - gap / 2)
        ..add(
          ScaleEffect.by(
            Vector2.all(1.2),
            EffectController(duration: 0.6, infinite: true, alternate: true),
          ),
        ),
    );

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    if (maskColor != null) {
      final paint = Paint()
        ..color = maskColor!
        ..style = .fill
        ..imageFilter = ImageFilter.blur(
          sigmaX: maskBlurSigma,
          sigmaY: maskBlurSigma,
        );
      canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), paint);
    }
    super.render(canvas);
  }
}
