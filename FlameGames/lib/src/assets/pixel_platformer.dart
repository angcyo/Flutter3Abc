import 'package:flutter3_flame/flutter3_flame.dart';

import '../../gen/assets.gen.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/22
///
/// https://kenney.nl/assets/pixel-platformer
class PixelPlatformer {
  /// 加载的图片资源
  late Image image;

  /// 从资源中加载图片
  Future<Image> loadFromAssets(Game? game, {String? prefix = ""}) async {
    final images = game?.images ?? Flame.images;
    if (prefix != null) {
      images.prefix = prefix;
    }
    image = await images.load(
      Assets.sprite.pixelPlatformer.keyName,
      /*package: "flame_games",*/
    );
    return image;
  }

  //MARK: Sprite

  Sprite get text0Sprite =>
      Sprite(image, srcPosition: Vector2(0, 152), srcSize: Vector2(18, 18));

  Sprite get text1Sprite => Sprite(
    image,
    srcPosition: Vector2(18 + 1, 152),
    srcSize: Vector2(18, 18),
  );

  Sprite get text2Sprite => Sprite(
    image,
    srcPosition: Vector2(36 + 2, 152),
    srcSize: Vector2(18, 18),
  );

  Sprite get text3Sprite => Sprite(
    image,
    srcPosition: Vector2(54 + 3, 152),
    srcSize: Vector2(18, 18),
  );

  Sprite get text4Sprite => Sprite(
    image,
    srcPosition: Vector2(72 + 4, 152),
    srcSize: Vector2(18, 18),
  );

  Sprite get text5Sprite => Sprite(
    image,
    srcPosition: Vector2(90 + 5, 152),
    srcSize: Vector2(18, 18),
  );

  Sprite get text6Sprite => Sprite(
    image,
    srcPosition: Vector2(108 + 6, 152),
    srcSize: Vector2(18, 18),
  );

  Sprite get text7Sprite => Sprite(
    image,
    srcPosition: Vector2(126 + 7, 152),
    srcSize: Vector2(18, 18),
  );

  Sprite get text8Sprite => Sprite(
    image,
    srcPosition: Vector2(144 + 8, 152),
    srcSize: Vector2(18, 18),
  );

  Sprite get text9Sprite => Sprite(
    image,
    srcPosition: Vector2(162 + 9, 152),
    srcSize: Vector2(18, 18),
  );

  Sprite get text0BigSprite => Sprite(
    image,
    srcPosition: Vector2(180 + 10, 152),
    srcSize: Vector2(18, 18),
  );

  Sprite get text1BigSprite => Sprite(
    image,
    srcPosition: Vector2(198 + 11, 152),
    srcSize: Vector2(18, 18),
  );

  Sprite get text2BigSprite => Sprite(
    image,
    srcPosition: Vector2(216 + 12, 152),
    srcSize: Vector2(18, 18),
  );

  Sprite get text3BigSprite => Sprite(
    image,
    srcPosition: Vector2(234 + 13, 152),
    srcSize: Vector2(18, 18),
  );

  Sprite get text4BigSprite => Sprite(
    image,
    srcPosition: Vector2(252 + 14, 152),
    srcSize: Vector2(18, 18),
  );

  Sprite get text5BigSprite => Sprite(
    image,
    srcPosition: Vector2(270 + 15, 152),
    srcSize: Vector2(18, 18),
  );

  Sprite get text6BigSprite => Sprite(
    image,
    srcPosition: Vector2(288 + 16, 152),
    srcSize: Vector2(18, 18),
  );

  Sprite get text7BigSprite => Sprite(
    image,
    srcPosition: Vector2(306 + 17, 152),
    srcSize: Vector2(18, 18),
  );

  Sprite get text8BigSprite => Sprite(
    image,
    srcPosition: Vector2(324 + 18, 152),
    srcSize: Vector2(18, 18),
  );

  Sprite get text9BigSprite => Sprite(
    image,
    srcPosition: Vector2(342 + 19, 152),
    srcSize: Vector2(18, 18),
  );

  //--

  /// 小数点
  Sprite get dotSprite => Sprite(
    image,
    srcPosition: Vector2(306 + 17, 152 - 18 - 1),
    srcSize: Vector2(18, 18),
  );

  /// 乘号
  Sprite get multiplySprite => Sprite(
    image,
    srcPosition: Vector2(324 + 18, 152 - 18 - 1),
    srcSize: Vector2(18, 18),
  );

  /// 除号
  Sprite get divideSprite => Sprite(
    image,
    srcPosition: Vector2(342 + 19, 152 - 18 - 1),
    srcSize: Vector2(18, 18),
  );

  //--

  /// 满血
  Sprite get heartFullSprite => Sprite(
    image,
    srcPosition: Vector2(72 + 4, 18 * 2 + 2),
    srcSize: Vector2(18, 18),
  );

  /// 空血
  Sprite get heartEmptySprite => Sprite(
    image,
    srcPosition: Vector2(90 + 5, 18 * 2 + 2),
    srcSize: Vector2(18, 18),
  );

  /// 半血
  Sprite get heartHalfSprite => Sprite(
    image,
    srcPosition: Vector2(108 + 6, 18 * 2 + 2),
    srcSize: Vector2(18, 18),
  );
}
