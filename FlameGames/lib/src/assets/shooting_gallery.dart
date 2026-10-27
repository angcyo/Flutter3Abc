import 'package:flutter3_flame/flutter3_flame.dart';

import '../../gen/assets.gen.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/22
///
///
/// https://kenney.nl/assets/shooting-gallery
class ShootingGalleryHud {
  /// 加载的图片资源
  late Image image;

  /// 从资源中加载图片
  Future<Image> loadFromAssets(Game? game, {String? prefix = ""}) async {
    final images = game?.images ?? Flame.images;
    if (prefix != null) {
      images.prefix = prefix;
    }
    image = await images.load(
      Assets.sprite.shootingGalleryHud.keyName,
      /*package: "flame_games",*/
    );
    return image;
  }

  //MARK: Sprite

  Sprite get crosshairBlueLargeSprite =>
      Sprite(image, srcPosition: Vector2(169, 278), srcSize: Vector2(50, 50));

  Sprite get crosshairBlueSmallSprite =>
      Sprite(image, srcPosition: Vector2(113, 375), srcSize: Vector2(42, 42));

  Sprite get crosshairOutlineLargeSprite =>
      Sprite(image, srcPosition: Vector2(113, 319), srcSize: Vector2(54, 54));

  Sprite get crosshairOutlineSmallSprite =>
      Sprite(image, srcPosition: Vector2(221, 323), srcSize: Vector2(46, 46));

  Sprite get crosshairRedLargeSprite =>
      Sprite(image, srcPosition: Vector2(169, 330), srcSize: Vector2(50, 50));

  Sprite get crosshairRedSmallSprite =>
      Sprite(image, srcPosition: Vector2(294, 202), srcSize: Vector2(42, 42));

  Sprite get crosshairWhiteLargeSprite =>
      Sprite(image, srcPosition: Vector2(195, 212), srcSize: Vector2(50, 50));

  Sprite get crosshairWhiteSmallSprite =>
      Sprite(image, srcPosition: Vector2(296, 73), srcSize: Vector2(42, 42));

  Sprite get iconBulletEmptyLongSprite =>
      Sprite(image, srcPosition: Vector2(390, 271), srcSize: Vector2(21, 44));

  Sprite get iconBulletEmptyShortSprite =>
      Sprite(image, srcPosition: Vector2(372, 195), srcSize: Vector2(21, 36));

  Sprite get iconBulletGoldLongSprite =>
      Sprite(image, srcPosition: Vector2(395, 79), srcSize: Vector2(21, 44));

  Sprite get iconBulletGoldShortSprite =>
      Sprite(image, srcPosition: Vector2(390, 317), srcSize: Vector2(21, 36));

  Sprite get iconBulletSilverLongSprite =>
      Sprite(image, srcPosition: Vector2(372, 149), srcSize: Vector2(21, 44));

  Sprite get iconBulletSilverShortSprite =>
      Sprite(image, srcPosition: Vector2(193, 382), srcSize: Vector2(21, 36));

  Sprite get iconDuckSprite =>
      Sprite(image, srcPosition: Vector2(157, 382), srcSize: Vector2(34, 33));

  Sprite get iconTargetSprite =>
      Sprite(image, srcPosition: Vector2(268, 382), srcSize: Vector2(33, 33));

  Sprite get text0Sprite =>
      Sprite(image, srcPosition: Vector2(221, 264), srcSize: Vector2(47, 57));

  Sprite get text0SmallSprite =>
      Sprite(image, srcPosition: Vector2(303, 382), srcSize: Vector2(32, 37));

  Sprite get text1Sprite =>
      Sprite(image, srcPosition: Vector2(338, 175), srcSize: Vector2(32, 56));

  Sprite get text1SmallSprite =>
      Sprite(image, srcPosition: Vector2(382, 0), srcSize: Vector2(23, 36));

  Sprite get text2Sprite =>
      Sprite(image, srcPosition: Vector2(279, 144), srcSize: Vector2(43, 56));

  Sprite get text2SmallSprite =>
      Sprite(image, srcPosition: Vector2(359, 271), srcSize: Vector2(29, 37));

  Sprite get text3Sprite =>
      Sprite(image, srcPosition: Vector2(316, 246), srcSize: Vector2(41, 56));

  Sprite get text3SmallSprite =>
      Sprite(image, srcPosition: Vector2(365, 111), srcSize: Vector2(28, 36));

  Sprite get text4Sprite =>
      Sprite(image, srcPosition: Vector2(232, 144), srcSize: Vector2(45, 56));

  Sprite get text4SmallSprite =>
      Sprite(image, srcPosition: Vector2(359, 233), srcSize: Vector2(30, 36));

  Sprite get text5Sprite =>
      Sprite(image, srcPosition: Vector2(315, 319), srcSize: Vector2(42, 57));

  Sprite get text5SmallSprite =>
      Sprite(image, srcPosition: Vector2(359, 310), srcSize: Vector2(29, 36));

  Sprite get text6Sprite =>
      Sprite(image, srcPosition: Vector2(324, 117), srcSize: Vector2(39, 56));

  Sprite get text6SmallSprite =>
      Sprite(image, srcPosition: Vector2(370, 378), srcSize: Vector2(28, 36));

  Sprite get text7Sprite =>
      Sprite(image, srcPosition: Vector2(270, 262), srcSize: Vector2(44, 55));

  Sprite get text7SmallSprite =>
      Sprite(image, srcPosition: Vector2(340, 73), srcSize: Vector2(30, 36));

  Sprite get text8Sprite =>
      Sprite(image, srcPosition: Vector2(247, 202), srcSize: Vector2(45, 58));

  Sprite get text8SmallSprite =>
      Sprite(image, srcPosition: Vector2(337, 378), srcSize: Vector2(31, 37));

  Sprite get text9Sprite =>
      Sprite(image, srcPosition: Vector2(269, 323), srcSize: Vector2(44, 57));

  Sprite get text9SmallSprite =>
      Sprite(image, srcPosition: Vector2(350, 0), srcSize: Vector2(30, 36));

  Sprite get textCrossSprite =>
      Sprite(image, srcPosition: Vector2(221, 371), srcSize: Vector2(45, 46));

  Sprite get textCrossSmallSprite =>
      Sprite(image, srcPosition: Vector2(0, 387), srcSize: Vector2(32, 32));

  /// : 冒号
  Sprite get textDotsSprite =>
      Sprite(image, srcPosition: Vector2(372, 38), srcSize: Vector2(23, 39));

  /// : 冒号 小
  Sprite get textDotsSmallSprite =>
      Sprite(image, srcPosition: Vector2(34, 387), srcSize: Vector2(21, 32));

  Sprite get textGameoverSprite =>
      Sprite(image, srcPosition: Vector2(0, 0), srcSize: Vector2(348, 71));

  Sprite get textGoSprite =>
      Sprite(image, srcPosition: Vector2(0, 319), srcSize: Vector2(111, 66));

  Sprite get textPlusSprite =>
      Sprite(image, srcPosition: Vector2(118, 278), srcSize: Vector2(39, 38));

  Sprite get textPlusSmallSprite =>
      Sprite(image, srcPosition: Vector2(359, 348), srcSize: Vector2(28, 28));

  Sprite get textReadySprite =>
      Sprite(image, srcPosition: Vector2(0, 144), srcSize: Vector2(230, 66));

  Sprite get textScoreSprite =>
      Sprite(image, srcPosition: Vector2(0, 212), srcSize: Vector2(193, 64));

  Sprite get textScoreSmallSprite =>
      Sprite(image, srcPosition: Vector2(0, 278), srcSize: Vector2(116, 39));

  Sprite get textTimeupSprite =>
      Sprite(image, srcPosition: Vector2(0, 73), srcSize: Vector2(294, 69));
}
