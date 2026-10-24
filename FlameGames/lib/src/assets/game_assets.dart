import 'package:flame_games/src/assets/shape_characters.dart';
import 'package:flutter3_basics/flutter3_basics.dart';
import 'package:flutter3_flame/flutter3_flame.dart';

import 'game_icons.dart';
import 'pixel_platformer.dart';
import 'shooting_gallery.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/23
///
/// 游戏资产
class GameAssets {
  final gameIcons = GameIcons();
  final pixelPlatformer = PixelPlatformer();
  final shapeCharacters = ShapeCharacters();
  final shootingGalleryHud = ShootingGalleryHud();

  /// 初始化游戏图片资产
  Future initGameImageAssets({Game? game, String? prefix = ""}) async {
    await gameIcons.loadFromAssets(game, prefix: prefix);
    await shootingGalleryHud.loadFromAssets(game, prefix: prefix);
    await shapeCharacters.loadFromAssets(game, prefix: prefix);
    await pixelPlatformer.loadFromAssets(game, prefix: prefix);
  }
}

@globalInstance
final $gameAssets = GameAssets();
