import 'dart:async';

import 'package:flutter3_flame/flutter3_flame.dart';

import '../assets/game_assets.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/12
///
/// 游戏Go组件
class GameGoComponent extends PositionComponent {
  /// Go点击回调
  final void Function()? onGoTapAction;

  GameGoComponent({
    super.position,
    super.size,
    super.scale,
    super.angle,
    this.onGoTapAction,
  });

  @override
  FutureOr<void> onLoad() {
    final child =
        SpriteComponent(
          sprite: $gameAssets.shootingGalleryHud.textGoSprite,
        ).button(() {
          onGoTapAction?.call();
        });
    add(child);
    if (size.isZero()) {
      size = child.size;
    }
    return super.onLoad();
  }
}
