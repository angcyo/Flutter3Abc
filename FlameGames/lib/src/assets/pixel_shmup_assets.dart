import 'package:flutter3_basics/flutter3_basics.dart' hide Vector2;
import 'package:flutter3_flame/flutter3_flame.dart';

import '../../gen/assets.gen.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/05
///
/// 游戏资产
/// https://kenney.nl/assets/pixel-shmup
class PixelShmupAssets {
  /// 加载的图片资源
  late Image shipsImage;
  late Image tilesImage;

  /// 从资源中加载图片
  Future loadFromAssets(Game? game, {String? prefix = ""}) async {
    final images = game?.images ?? Flame.images;
    if (prefix != null) {
      images.prefix = prefix;
    }
    shipsImage = await images.load(
      Assets.sprite.pixelShmupShips.keyName,
      /*package: "flame_games",*/
    );
    tilesImage = await images.load(
      Assets.sprite.pixelShmupTiles.keyName,
      /*package: "flame_games",*/
    );
  }

  //MARK: Ships

  /// 蓝色飞船 / 大
  Sprite get shipsBlueBigSprite =>
      Sprite(shipsImage, srcPosition: Vector2(0, 0), srcSize: Vector2(32, 32));

  /// 蓝色飞船 / 大 / 灰
  Sprite get shipsBlueBigGraySprite => Sprite(
    shipsImage,
    srcPosition: Vector2(0, 32 * 3 + 1 * 3),
    srcSize: Vector2(32, 32),
  );

  /// 蓝色飞船
  Sprite get shipsBlueSprite => Sprite(
    shipsImage,
    srcPosition: Vector2(0, 32 + 1),
    srcSize: Vector2(32, 32),
  );

  /// 蓝色飞船 / 灰
  Sprite get shipsBlueGraySprite => Sprite(
    shipsImage,
    srcPosition: Vector2(0, 32 * 4 + 1 * 4),
    srcSize: Vector2(32, 32),
  );

  /// 蓝色飞船 / 双
  Sprite get shipsBlueDoubleSprite => Sprite(
    shipsImage,
    srcPosition: Vector2(0, 32 * 2 + 1 * 2),
    srcSize: Vector2(32, 32),
  );

  /// 蓝色飞船 / 双 / 灰
  Sprite get shipsBlueDoubleGraySprite => Sprite(
    shipsImage,
    srcPosition: Vector2(0, 32 * 5 + 1 * 5),
    srcSize: Vector2(32, 32),
  );

  /// 红色飞船 / 大
  Sprite get shipsRedBigSprite => Sprite(
    shipsImage,
    srcPosition: Vector2(32 + 1, 0),
    srcSize: Vector2(32, 32),
  );

  /// 红色飞船 / 大 / 灰
  Sprite get shipsRedBigGraySprite => Sprite(
    shipsImage,
    srcPosition: Vector2(32 + 1, 32 * 3 + 1 * 3),
    srcSize: Vector2(32, 32),
  );

  /// 红色飞船 / 中
  Sprite get shipsRedMediumSprite => Sprite(
    shipsImage,
    srcPosition: Vector2(32 + 1, 32 + 1),
    srcSize: Vector2(32, 32),
  );

  /// 红色飞船 / 中 / 灰
  Sprite get shipsRedMediumGraySprite => Sprite(
    shipsImage,
    srcPosition: Vector2(32 + 1, 32 * 4 + 1 * 4),
    srcSize: Vector2(32, 32),
  );

  /// 红色飞船
  Sprite get shipsRedSprite => Sprite(
    shipsImage,
    srcPosition: Vector2(32 + 1, 32 * 2 + 1 * 2),
    srcSize: Vector2(32, 32),
  );

  /// 红色飞船 / 灰
  Sprite get shipsRedGraySprite => Sprite(
    shipsImage,
    srcPosition: Vector2(32 + 1, 32 * 5 + 1 * 5),
    srcSize: Vector2(32, 32),
  );

  /// 绿色非常 / 大
  Sprite get shipsGreenBigSprite => Sprite(
    shipsImage,
    srcPosition: Vector2(32 * 2 + 1 * 2, 0),
    srcSize: Vector2(32, 32),
  );

  /// 绿色飞船 / 大 / 灰
  Sprite get shipsGreenBigGraySprite => Sprite(
    shipsImage,
    srcPosition: Vector2(32 * 2 + 1 * 2, 32 * 3 + 1 * 3),
    srcSize: Vector2(32, 32),
  );

  /// 绿色飞船 / 中
  Sprite get shipsGreenMediumSprite => Sprite(
    shipsImage,
    srcPosition: Vector2(32 * 2 + 1 * 2, 32 + 1),
    srcSize: Vector2(32, 32),
  );

  /// 绿色飞船 / 中 / 灰
  Sprite get shipsGreenMediumGraySprite => Sprite(
    shipsImage,
    srcPosition: Vector2(32 * 2 + 1 * 2, 32 * 4 + 1 * 4),
    srcSize: Vector2(32, 32),
  );

  /// 绿色飞船
  Sprite get shipsGreenSprite => Sprite(
    shipsImage,
    srcPosition: Vector2(32 * 2 + 1 * 2, 32 * 2 + 1 * 2),
    srcSize: Vector2(32, 32),
  );

  /// 绿色飞船 / 灰
  Sprite get shipsGreenGraySprite => Sprite(
    shipsImage,
    srcPosition: Vector2(32 * 2 + 1 * 2, 32 * 5 + 1 * 5),
    srcSize: Vector2(32, 32),
  );

  /// 黄色飞船 / 大
  Sprite get shipsYellowBigSprite => Sprite(
    shipsImage,
    srcPosition: Vector2(32 * 3 + 1 * 3, 0),
    srcSize: Vector2(32, 32),
  );

  /// 黄色飞船 / 大 / 灰
  Sprite get shipsYellowBigGraySprite => Sprite(
    shipsImage,
    srcPosition: Vector2(32 * 3 + 1 * 3, 32 * 3 + 1 * 3),
    srcSize: Vector2(32, 32),
  );

  /// 黄色飞船 / 中
  Sprite get shipsYellowMediumSprite => Sprite(
    shipsImage,
    srcPosition: Vector2(32 * 3 + 1 * 3, 32 + 1),
    srcSize: Vector2(32, 32),
  );

  /// 黄色飞船 / 中 / 灰
  Sprite get shipsYellowMediumGraySprite => Sprite(
    shipsImage,
    srcPosition: Vector2(32 * 3 + 1 * 3, 32 * 4 + 1 * 4),
    srcSize: Vector2(32, 32),
  );

  /// 黄色飞船
  Sprite get shipsYellowSprite => Sprite(
    shipsImage,
    srcPosition: Vector2(32 * 3 + 1 * 3, 32 * 2 + 1 * 2),
    srcSize: Vector2(32, 32),
  );

  /// 黄色飞船 / 灰
  Sprite get shipsYellowGraySprite => Sprite(
    shipsImage,
    srcPosition: Vector2(32 * 3 + 1 * 3, 32 * 5 + 1 * 5),
    srcSize: Vector2(32, 32),
  );

  /// 所有飞船集合
  List<Sprite> get allShipsSprites => [
    shipsBlueBigSprite,
    shipsBlueSprite,
    shipsBlueDoubleSprite,
    shipsRedBigSprite,
    shipsRedMediumSprite,
    shipsRedSprite,
    shipsGreenBigSprite,
    shipsGreenMediumSprite,
    shipsGreenSprite,
    shipsYellowBigSprite,
    shipsYellowMediumSprite,
    shipsYellowSprite,
  ];

  /// 所有飞船集合 / 灰
  List<Sprite> get allShipsGraySprites => [
    shipsBlueBigGraySprite,
    shipsBlueGraySprite,
    shipsBlueDoubleGraySprite,
    shipsRedBigGraySprite,
    shipsRedMediumGraySprite,
    shipsRedGraySprite,
    shipsGreenBigGraySprite,
    shipsGreenMediumGraySprite,
    shipsGreenGraySprite,
    shipsYellowBigGraySprite,
    shipsYellowMediumGraySprite,
    shipsYellowGraySprite,
  ];

  //MARK: Tiles

  /// 普通子弹
  Sprite get tilesBulletSprite =>
      Sprite(tilesImage, srcPosition: Vector2(0, 0), srcSize: Vector2(17, 17));

  /// 普通双发子弹
  Sprite get tilesBulletDoubleSprite => Sprite(
    tilesImage,
    srcPosition: Vector2(16 * 1 + 1 * 1, 0),
    srcSize: Vector2(17, 17),
  );

  /// 细弹
  Sprite get tilesBulletThinSprite => Sprite(
    tilesImage,
    srcPosition: Vector2(16 * 2 + 1 * 2, 0),
    srcSize: Vector2(17, 17),
  );

  /// 炮弹
  Sprite get tilesBulletBombSprite => Sprite(
    tilesImage,
    srcPosition: Vector2(16 * 3 + 1 * 3, 0),
    srcSize: Vector2(17, 17),
  );

  //--

  /// 普通导弹
  Sprite get tilesBulletMissileSprite => Sprite(
    tilesImage,
    srcPosition: Vector2(0, 16 + 1),
    srcSize: Vector2(17, 17),
  );

  /// 双发导弹
  Sprite get tilesBulletMissileDoubleSprite => Sprite(
    tilesImage,
    srcPosition: Vector2(16 + 1, 16 + 1),
    srcSize: Vector2(17, 17),
  );

  /// 双发导弹2型
  Sprite get tilesBulletMissileDoubleType2Sprite => Sprite(
    tilesImage,
    srcPosition: Vector2(16 * 2 + 1 * 2, 16 + 1),
    srcSize: Vector2(17, 17),
  );

  /// 双发导弹3型
  Sprite get tilesBulletMissileDoubleType3Sprite => Sprite(
    tilesImage,
    srcPosition: Vector2(16 * 3 + 1 * 3, 16 + 1),
    srcSize: Vector2(17, 17),
  );

  //--

  /// 炸弹效果
  SpriteAnimation get tilesBombAnimation => SpriteAnimation.fromFrameData(
    tilesImage,
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.15,
      texturePosition: Vector2(16 * 4 + 1 * 3, 0),
      textureSize: Vector2(17, 17),
      loop: false,
    ),
  );
}

@globalInstance
final $pixelShmupAssets = PixelShmupAssets();
