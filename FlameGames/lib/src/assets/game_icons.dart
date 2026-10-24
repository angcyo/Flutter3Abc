import 'package:flutter3_flame/flutter3_flame.dart';

import '../../gen/assets.gen.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/22
///
/// 加载`game_icons_sheet.png`图片资源
///
/// 第1行: x="450" y="0"
/// 第2行: x="350" y="50"
/// 第9行: x="400" y="400"
/// 第10行: x="100" y="450"
///
/// https://kenney.nl/assets/game-icons
class GameIcons {
  /// 加载的图片资源
  late Image image;

  /// 从资源中加载图片
  Future<Image> loadFromAssets(Game? game, {String? prefix = ""}) async {
    final images = game?.images ?? Flame.images;
    if (prefix != null) {
      images.prefix = prefix;
    }
    image = await images.load(
      Assets.sprite.gameIconsSheet.keyName,
      /*package: "flame_games",*/
    );
    return image;
  }

  //MARK: Sprite

  /// 向左箭头
  Sprite get arrowLeftSprite =>
      Sprite(image, srcPosition: Vector2(50, 0), srcSize: Vector2(50, 50));

  /// 向下箭头
  Sprite get arrowDownSprite =>
      Sprite(image, srcPosition: Vector2(50, 50), srcSize: Vector2(50, 50));

  /// 向右箭头
  Sprite get arrowRightSprite =>
      Sprite(image, srcPosition: Vector2(0, 450), srcSize: Vector2(50, 50));

  /// 向上箭头
  Sprite get arrowUpSprite =>
      Sprite(image, srcPosition: Vector2(0, 400), srcSize: Vector2(50, 50));

  /// 返回按钮
  Sprite get returnSprite =>
      Sprite(image, srcPosition: Vector2(200, 50), srcSize: Vector2(50, 50));

  /// 暂停按钮
  Sprite get pauseSprite =>
      Sprite(image, srcPosition: Vector2(200, 350), srcSize: Vector2(50, 50));

  /// 主页按钮
  Sprite get homeSprite =>
      Sprite(image, srcPosition: Vector2(350, 0), srcSize: Vector2(50, 50));

  /// 前进按钮 / 播放按钮
  Sprite get forwardSprite =>
      Sprite(image, srcPosition: Vector2(350, 350), srcSize: Vector2(50, 50));

  /// 后退按钮
  Sprite get backwardSprite =>
      Sprite(image, srcPosition: Vector2(0, 250), srcSize: Vector2(50, 50));

  /// 星星
  Sprite get starSprite =>
      Sprite(image, srcPosition: Vector2(100, 450), srcSize: Vector2(50, 50));

  /// 交叉按钮 x ❌
  Sprite get crossSprite =>
      Sprite(image, srcPosition: Vector2(400, 400), srcSize: Vector2(50, 50));

  /// 勾选按钮 √
  Sprite get checkmarkSprite =>
      Sprite(image, srcPosition: Vector2(450, 0), srcSize: Vector2(50, 50));

  /// 齿轮按钮 ⚙️
  Sprite get gearSprite =>
      Sprite(image, srcPosition: Vector2(350, 50), srcSize: Vector2(50, 50));
}
