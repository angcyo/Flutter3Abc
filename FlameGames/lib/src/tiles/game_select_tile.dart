import 'package:flame_games/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter3_basics/flutter3_basics.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/21
///
/// 选择对应的游戏tile
class GameSelectTile extends StatefulWidget {
  /// 标签
  final String label;

  /// 点击事件
  final GestureTapCallback? onTap;

  const GameSelectTile({required this.label, this.onTap, super.key});

  @override
  State<GameSelectTile> createState() => _GameSelectTileState();
}

class _GameSelectTileState extends State<GameSelectTile> {
  @override
  Widget build(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    final size = (isMobile ? $screenMinSize : $screenHeight) / 3;
    return [
          loadAssetImageWidget(Assets.png.logo.keyName, size: size)!,
          widget.label.text(textColor: globalTheme.whiteColor),
        ]
        .column(mainAxisAlignment: .center, gap: kX)!
        /*.bounds()*/
        .inkWell(widget.onTap /*splashColor: Colors.black12*/);
  }
}
