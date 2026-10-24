import 'package:flutter/material.dart';
import 'package:flutter3_basics/flutter3_basics.dart';
import 'package:flutter3_flame/flutter3_flame.dart';

import '../assets/game_assets.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/23
///
/// 游戏数据小部件
class GameNumberWidget extends StatefulWidget {
  /// 数字
  /// - [usePersonalStyle]=false 时支持小数
  /// - 不支持负数
  final String? number;

  /// 是否使用个性样式
  /// - true: shooting_gallery_hud.png
  /// - false: pixel_platformer.png
  final bool usePersonalStyle;

  /// 字体大小
  final double fontSize;

  const GameNumberWidget(
    this.number, {
    this.usePersonalStyle = false,
    this.fontSize = 18.0,
    super.key,
  });

  @override
  State<GameNumberWidget> createState() => _GameNumberWidgetState();
}

class _GameNumberWidgetState extends State<GameNumberWidget> {
  @override
  Widget build(BuildContext context) {
    final number = widget.number ?? "";
    final body = widget.usePersonalStyle
        ? [
            for (var i = 0; i < number.length; i++)
              wrapSpriteWidget(
                context,
                SpriteWidget(
                  renderSize: Size(widget.fontSize, widget.fontSize),
                  sprite: switch (number[i]) {
                    '0' => $gameAssets.shootingGalleryHud.text0Sprite,
                    '1' => $gameAssets.shootingGalleryHud.text1Sprite,
                    '2' => $gameAssets.shootingGalleryHud.text2Sprite,
                    '3' => $gameAssets.shootingGalleryHud.text3Sprite,
                    '4' => $gameAssets.shootingGalleryHud.text4Sprite,
                    '5' => $gameAssets.shootingGalleryHud.text5Sprite,
                    '6' => $gameAssets.shootingGalleryHud.text6Sprite,
                    '7' => $gameAssets.shootingGalleryHud.text7Sprite,
                    '8' => $gameAssets.shootingGalleryHud.text8Sprite,
                    '9' => $gameAssets.shootingGalleryHud.text9Sprite,
                    _ => null,
                  },
                ),
              ),
          ].row()!
        : [
            for (var i = 0; i < number.length; i++)
              wrapSpriteWidget(
                context,
                SpriteWidget(
                  renderSize: Size(widget.fontSize, widget.fontSize),
                  sprite: switch (number[i]) {
                    '0' => $gameAssets.pixelPlatformer.text0BigSprite,
                    '1' => $gameAssets.pixelPlatformer.text1BigSprite,
                    '2' => $gameAssets.pixelPlatformer.text2BigSprite,
                    '3' => $gameAssets.pixelPlatformer.text3BigSprite,
                    '4' => $gameAssets.pixelPlatformer.text4BigSprite,
                    '5' => $gameAssets.pixelPlatformer.text5BigSprite,
                    '6' => $gameAssets.pixelPlatformer.text6BigSprite,
                    '7' => $gameAssets.pixelPlatformer.text7BigSprite,
                    '8' => $gameAssets.pixelPlatformer.text8BigSprite,
                    '9' => $gameAssets.pixelPlatformer.text9BigSprite,
                    '.' => $gameAssets.pixelPlatformer.dotSprite,
                    _ => null,
                  },
                ),
              ),
          ].row()!;
    return body;
  }

  Widget wrapSpriteWidget(BuildContext context, SpriteWidget spriteWidget) {
    return spriteWidget;
  }
}
