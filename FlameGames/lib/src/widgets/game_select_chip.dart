import 'package:flutter/material.dart';
import 'package:flutter3_basics/flutter3_basics.dart';
import 'package:flutter3_flame/flutter3_flame.dart';

import '../assets/game_assets.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/23
///
/// - [SelectChip]
class GameSelectChip extends StatefulWidget {
  final Widget child;
  final bool isSelected;
  final ValueChanged<bool>? onSelected;

  const GameSelectChip({
    super.key,
    required this.child,
    this.isSelected = false,
    this.onSelected,
  });

  @override
  State<GameSelectChip> createState() => _GameSelectChipState();
}

class _GameSelectChipState extends State<GameSelectChip> {
  @override
  Widget build(BuildContext context) {
    final shapeCharacters = $gameAssets.shapeCharacters;
    return SelectChip(
      isSelected: true,
      enableSelectedTap: true,
      onSelected: (value) {
        if (widget.isSelected) {
          return;
        }
        widget.onSelected?.call(!widget.isSelected);
      },
      selected: SpriteWidget(sprite: shapeCharacters.purpleHandPointSprite)
          .transform(createScaleMatrix(scale: 0.8))
          .opacity(opacity: widget.isSelected ? 0.8 : 0, anim: true)
          .position(left: 0, bottom: 10),
      child: widget.child.insets(all: 20),
    );
  }
}
