import 'package:flutter3_flame/flutter3_flame.dart';

import '../../gen/assets.gen.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/23
///
/// https://kenney.nl/assets/shape-characters
class ShapeCharacters {
  /// 加载的图片资源
  late Image image;

  /// 从资源中加载图片
  Future<Image> loadFromAssets(Game? game, {String? prefix = ""}) async {
    final images = game?.images ?? Flame.images;
    if (prefix != null) {
      images.prefix = prefix;
    }
    image = await images.load(
      Assets.sprite.shapeCharacters.keyName,
      /*package: "flame_games",*/
    );
    return image;
  }

  //MARK: Sprite

  Sprite get blueBodyCircleSprite =>
      Sprite(image, srcPosition: Vector2(0, 147), srcSize: Vector2(80, 80));

  Sprite get blueBodyRhombusSprite =>
      Sprite(image, srcPosition: Vector2(240, 480), srcSize: Vector2(80, 80));

  Sprite get blueBodySquareSprite =>
      Sprite(image, srcPosition: Vector2(176, 0), srcSize: Vector2(80, 80));

  Sprite get blueBodySquircleSprite =>
      Sprite(image, srcPosition: Vector2(240, 240), srcSize: Vector2(80, 80));

  Sprite get blueHandClosedSprite =>
      Sprite(image, srcPosition: Vector2(480, 143), srcSize: Vector2(35, 34));

  Sprite get blueHandOpenSprite =>
      Sprite(image, srcPosition: Vector2(508, 211), srcSize: Vector2(34, 38));

  Sprite get blueHandPeaceSprite =>
      Sprite(image, srcPosition: Vector2(542, 182), srcSize: Vector2(28, 40));

  Sprite get blueHandPointSprite =>
      Sprite(image, srcPosition: Vector2(493, 538), srcSize: Vector2(34, 36));

  Sprite get blueHandRockSprite =>
      Sprite(image, srcPosition: Vector2(472, 278), srcSize: Vector2(36, 38));

  Sprite get blueHandThumbSprite =>
      Sprite(image, srcPosition: Vector2(525, 386), srcSize: Vector2(32, 38));

  Sprite get faceASprite =>
      Sprite(image, srcPosition: Vector2(109, 547), srcSize: Vector2(50, 29));

  Sprite get faceBSprite =>
      Sprite(image, srcPosition: Vector2(59, 547), srcSize: Vector2(50, 24));

  Sprite get faceCSprite =>
      Sprite(image, srcPosition: Vector2(0, 547), srcSize: Vector2(59, 30));

  Sprite get faceDSprite =>
      Sprite(image, srcPosition: Vector2(400, 531), srcSize: Vector2(53, 33));

  Sprite get faceESprite =>
      Sprite(image, srcPosition: Vector2(400, 350), srcSize: Vector2(55, 40));

  Sprite get faceFSprite =>
      Sprite(image, srcPosition: Vector2(400, 422), srcSize: Vector2(55, 33));

  Sprite get faceGSprite =>
      Sprite(image, srcPosition: Vector2(400, 390), srcSize: Vector2(55, 32));

  Sprite get faceHSprite =>
      Sprite(image, srcPosition: Vector2(400, 455), srcSize: Vector2(55, 36));

  Sprite get faceISprite =>
      Sprite(image, srcPosition: Vector2(96, 80), srcSize: Vector2(59, 42));

  Sprite get faceJSprite =>
      Sprite(image, srcPosition: Vector2(416, 37), srcSize: Vector2(50, 39));

  Sprite get faceKSprite =>
      Sprite(image, srcPosition: Vector2(400, 491), srcSize: Vector2(55, 40));

  Sprite get faceLSprite =>
      Sprite(image, srcPosition: Vector2(416, 0), srcSize: Vector2(53, 37));

  Sprite get facialPartEyeClosedDownSprite =>
      Sprite(image, srcPosition: Vector2(224, 564), srcSize: Vector2(23, 11));

  Sprite get facialPartEyeClosedUpSprite =>
      Sprite(image, srcPosition: Vector2(247, 564), srcSize: Vector2(23, 11));

  Sprite get facialPartEyeHalfBottomSprite =>
      Sprite(image, srcPosition: Vector2(290, 567), srcSize: Vector2(20, 10));

  Sprite get facialPartEyeHalfTopSprite =>
      Sprite(image, srcPosition: Vector2(270, 564), srcSize: Vector2(20, 10));

  Sprite get facialPartEyeHalfTopWingSprite =>
      Sprite(image, srcPosition: Vector2(199, 564), srcSize: Vector2(25, 10));

  Sprite get facialPartEyeOpenSprite =>
      Sprite(image, srcPosition: Vector2(480, 211), srcSize: Vector2(20, 20));

  Sprite get facialPartEyebrowASprite =>
      Sprite(image, srcPosition: Vector2(59, 571), srcSize: Vector2(20, 5));

  Sprite get facialPartEyebrowBSprite =>
      Sprite(image, srcPosition: Vector2(350, 564), srcSize: Vector2(20, 7));

  Sprite get facialPartEyebrowCSprite =>
      Sprite(image, srcPosition: Vector2(310, 572), srcSize: Vector2(15, 5));

  Sprite get facialPartEyebrowDSprite =>
      Sprite(image, srcPosition: Vector2(310, 564), srcSize: Vector2(20, 8));

  Sprite get facialPartMouthAngrySprite =>
      Sprite(image, srcPosition: Vector2(159, 564), srcSize: Vector2(40, 10));

  Sprite get facialPartMouthHappySprite =>
      Sprite(image, srcPosition: Vector2(330, 564), srcSize: Vector2(20, 7));

  Sprite get facialPartMouthSadSprite =>
      Sprite(image, srcPosition: Vector2(290, 560), srcSize: Vector2(20, 7));

  Sprite get facialPartMouthSmirkSprite =>
      Sprite(image, srcPosition: Vector2(144, 122), srcSize: Vector2(14, 7));

  Sprite get greenBodyCircleSprite =>
      Sprite(image, srcPosition: Vector2(336, 0), srcSize: Vector2(80, 80));

  Sprite get greenBodyRhombusSprite =>
      Sprite(image, srcPosition: Vector2(240, 320), srcSize: Vector2(80, 80));

  Sprite get greenBodySquareSprite =>
      Sprite(image, srcPosition: Vector2(240, 160), srcSize: Vector2(80, 80));

  Sprite get greenBodySquircleSprite =>
      Sprite(image, srcPosition: Vector2(160, 480), srcSize: Vector2(80, 80));

  Sprite get greenHandClosedSprite =>
      Sprite(image, srcPosition: Vector2(469, 0), srcSize: Vector2(35, 34));

  Sprite get greenHandOpenSprite =>
      Sprite(image, srcPosition: Vector2(491, 464), srcSize: Vector2(34, 38));

  Sprite get greenHandPeaceSprite =>
      Sprite(image, srcPosition: Vector2(536, 0), srcSize: Vector2(28, 40));

  Sprite get greenHandPointSprite =>
      Sprite(image, srcPosition: Vector2(491, 390), srcSize: Vector2(34, 36));

  Sprite get greenHandRockSprite =>
      Sprite(image, srcPosition: Vector2(472, 240), srcSize: Vector2(36, 38));

  Sprite get greenHandThumbSprite =>
      Sprite(image, srcPosition: Vector2(525, 424), srcSize: Vector2(32, 38));

  Sprite get handYellowClosedSprite =>
      Sprite(image, srcPosition: Vector2(480, 109), srcSize: Vector2(35, 34));

  Sprite get handYellowOpenSprite =>
      Sprite(image, srcPosition: Vector2(491, 426), srcSize: Vector2(34, 38));

  Sprite get handYellowPeaceSprite =>
      Sprite(image, srcPosition: Vector2(549, 40), srcSize: Vector2(28, 40));

  Sprite get handYellowPointSprite =>
      Sprite(image, srcPosition: Vector2(493, 502), srcSize: Vector2(34, 36));

  Sprite get handYellowRockSprite =>
      Sprite(image, srcPosition: Vector2(455, 466), srcSize: Vector2(36, 38));

  Sprite get handYellowThumbSprite =>
      Sprite(image, srcPosition: Vector2(515, 144), srcSize: Vector2(32, 38));

  Sprite get pinkBodyCircleSprite =>
      Sprite(image, srcPosition: Vector2(240, 400), srcSize: Vector2(80, 80));

  Sprite get pinkBodyRhombusSprite =>
      Sprite(image, srcPosition: Vector2(160, 240), srcSize: Vector2(80, 80));

  Sprite get pinkBodySquareSprite =>
      Sprite(image, srcPosition: Vector2(320, 80), srcSize: Vector2(80, 80));

  Sprite get pinkBodySquircleSprite =>
      Sprite(image, srcPosition: Vector2(320, 240), srcSize: Vector2(80, 80));

  Sprite get pinkHandClosedSprite =>
      Sprite(image, srcPosition: Vector2(480, 177), srcSize: Vector2(35, 34));

  Sprite get pinkHandOpenSprite =>
      Sprite(image, srcPosition: Vector2(502, 34), srcSize: Vector2(34, 38));

  Sprite get pinkHandPeaceSprite =>
      Sprite(image, srcPosition: Vector2(529, 325), srcSize: Vector2(28, 40));

  Sprite get pinkHandPointSprite =>
      Sprite(image, srcPosition: Vector2(515, 72), srcSize: Vector2(34, 36));

  Sprite get pinkHandRockSprite =>
      Sprite(image, srcPosition: Vector2(455, 390), srcSize: Vector2(36, 38));

  Sprite get pinkHandThumbSprite =>
      Sprite(image, srcPosition: Vector2(527, 538), srcSize: Vector2(32, 38));

  Sprite get purpleBodyCircleSprite =>
      Sprite(image, srcPosition: Vector2(320, 160), srcSize: Vector2(80, 80));

  Sprite get purpleBodyRhombusSprite =>
      Sprite(image, srcPosition: Vector2(400, 160), srcSize: Vector2(80, 80));

  Sprite get purpleBodySquareSprite =>
      Sprite(image, srcPosition: Vector2(400, 80), srcSize: Vector2(80, 80));

  Sprite get purpleBodySquircleSprite =>
      Sprite(image, srcPosition: Vector2(320, 480), srcSize: Vector2(80, 80));

  /// 紫色 握拳
  Sprite get purpleHandClosedSprite =>
      Sprite(image, srcPosition: Vector2(480, 75), srcSize: Vector2(35, 34));

  /// 紫色 打开
  Sprite get purpleHandOpenSprite =>
      Sprite(image, srcPosition: Vector2(508, 249), srcSize: Vector2(34, 38));

  /// 紫色 招手 耶
  Sprite get purpleHandPeaceSprite =>
      Sprite(image, srcPosition: Vector2(542, 222), srcSize: Vector2(28, 40));

  /// 紫色 指着
  Sprite get purpleHandPointSprite =>
      Sprite(image, srcPosition: Vector2(515, 108), srcSize: Vector2(34, 36));

  /// 紫色 击掌 6
  Sprite get purpleHandRockSprite =>
      Sprite(image, srcPosition: Vector2(455, 428), srcSize: Vector2(36, 38));

  /// 紫色大拇指
  Sprite get purpleHandThumbSprite =>
      Sprite(image, srcPosition: Vector2(525, 462), srcSize: Vector2(32, 38));

  Sprite get redBodyCircleSprite =>
      Sprite(image, srcPosition: Vector2(320, 400), srcSize: Vector2(80, 80));

  Sprite get redBodyRhombusSprite =>
      Sprite(image, srcPosition: Vector2(320, 320), srcSize: Vector2(80, 80));

  Sprite get redBodySquareSprite =>
      Sprite(image, srcPosition: Vector2(256, 0), srcSize: Vector2(80, 80));

  Sprite get redBodySquircleSprite =>
      Sprite(image, srcPosition: Vector2(160, 400), srcSize: Vector2(80, 80));

  Sprite get redHandClosedSprite =>
      Sprite(image, srcPosition: Vector2(472, 316), srcSize: Vector2(35, 34));

  Sprite get redHandOpenSprite =>
      Sprite(image, srcPosition: Vector2(508, 287), srcSize: Vector2(34, 38));

  Sprite get redHandPeaceSprite =>
      Sprite(image, srcPosition: Vector2(542, 262), srcSize: Vector2(28, 40));

  Sprite get redHandPointSprite =>
      Sprite(image, srcPosition: Vector2(495, 350), srcSize: Vector2(34, 36));

  Sprite get redHandRockSprite =>
      Sprite(image, srcPosition: Vector2(466, 37), srcSize: Vector2(36, 38));

  Sprite get redHandThumbSprite =>
      Sprite(image, srcPosition: Vector2(527, 500), srcSize: Vector2(32, 38));

  Sprite get shadowSprite =>
      Sprite(image, srcPosition: Vector2(96, 122), srcSize: Vector2(48, 20));

  Sprite get tileSprite =>
      Sprite(image, srcPosition: Vector2(240, 80), srcSize: Vector2(80, 80));

  Sprite get tileBackgroundGrassSprite =>
      Sprite(image, srcPosition: Vector2(455, 504), srcSize: Vector2(32, 18));

  Sprite get tileBackgroundTreeLargeSprite =>
      Sprite(image, srcPosition: Vector2(0, 0), srcSize: Vector2(96, 147));

  Sprite get tileBackgroundTreeSmallSprite =>
      Sprite(image, srcPosition: Vector2(400, 240), srcSize: Vector2(72, 110));

  Sprite get tileCenterSprite =>
      Sprite(image, srcPosition: Vector2(160, 320), srcSize: Vector2(80, 80));

  Sprite get tileCloudSprite =>
      Sprite(image, srcPosition: Vector2(455, 350), srcSize: Vector2(40, 40));

  Sprite get tileCoinSprite =>
      Sprite(image, srcPosition: Vector2(453, 531), srcSize: Vector2(40, 40));

  Sprite get tileExclamationSprite =>
      Sprite(image, srcPosition: Vector2(160, 80), srcSize: Vector2(80, 80));

  Sprite get tileGreySprite =>
      Sprite(image, srcPosition: Vector2(96, 0), srcSize: Vector2(80, 80));

  Sprite get tileHalfSprite =>
      Sprite(image, srcPosition: Vector2(80, 507), srcSize: Vector2(80, 40));

  Sprite get tileHalfCenterSprite =>
      Sprite(image, srcPosition: Vector2(80, 467), srcSize: Vector2(80, 40));

  Sprite get tileHalfLeftSprite =>
      Sprite(image, srcPosition: Vector2(80, 427), srcSize: Vector2(80, 40));

  Sprite get tileHalfRightSprite =>
      Sprite(image, srcPosition: Vector2(80, 387), srcSize: Vector2(80, 40));

  Sprite get tileLeftSprite =>
      Sprite(image, srcPosition: Vector2(80, 307), srcSize: Vector2(80, 80));

  Sprite get tileRampLeftSprite =>
      Sprite(image, srcPosition: Vector2(160, 160), srcSize: Vector2(80, 80));

  Sprite get tileRampRightSprite =>
      Sprite(image, srcPosition: Vector2(80, 147), srcSize: Vector2(80, 80));

  Sprite get tileRightSprite =>
      Sprite(image, srcPosition: Vector2(0, 467), srcSize: Vector2(80, 80));

  Sprite get yellowBodyCircleSprite =>
      Sprite(image, srcPosition: Vector2(0, 387), srcSize: Vector2(80, 80));

  Sprite get yellowBodyRhombusSprite =>
      Sprite(image, srcPosition: Vector2(80, 227), srcSize: Vector2(80, 80));

  Sprite get yellowBodySquareSprite =>
      Sprite(image, srcPosition: Vector2(0, 227), srcSize: Vector2(80, 80));

  Sprite get yellowBodySquircleSprite =>
      Sprite(image, srcPosition: Vector2(0, 307), srcSize: Vector2(80, 80));
}
