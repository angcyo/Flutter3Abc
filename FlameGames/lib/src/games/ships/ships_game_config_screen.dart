import 'package:flame_games/src/games/ships/ships_game_config.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter3_core/flutter3_core.dart';
import 'package:flutter3_flame/flutter3_flame.dart';

import '../../assets/game_assets.dart';
import '../../widgets/game_select_chip.dart';
import '../base_game_scroll_page.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/05
///
/// 游戏配置界面
class ShipsGameConfigScreen extends StatefulWidget with TranslationTypeMixin {
  @override
  TranslationType get translationType => .none;

  const ShipsGameConfigScreen({super.key});

  @override
  State<ShipsGameConfigScreen> createState() => _ShipsGameConfigScreenState();
}

class _ShipsGameConfigScreenState extends State<ShipsGameConfigScreen>
    with AbsScrollPage, BaseGameScrollPage {
  /// 游戏配置
  static final shipsGameConfig = ShipsGameConfig();

  @override
  WidgetList? buildScrollBody(BuildContext context) {
    return [
      //--
      [
        GameOutlineText(text: "选择游戏人数").center(),
        [
          GameSelectChip(
            isSelected: shipsGameConfig.playerCount == 1,
            onSelected: (selected) {
              shipsGameConfig.playerCount = selected ? 1 : 2;
              updateState();
              $gameAssets.playClickEffect();
            },
            child: GameOutlineText.item(text: "单人"),
          ),
          GameSelectChip(
            isSelected: shipsGameConfig.playerCount == 2,
            onSelected: (selected) {
              shipsGameConfig.playerCount = selected ? 2 : 1;
              updateState();
              $gameAssets.playClickEffect();
            },
            child: GameOutlineText.item(text: "双人"),
          ),
        ].row(mainAxisAlignment: .center, gap: 20)!,
        //--
        GameSelectChip(
          onSelected: (selected) {
            buildContext?.pop(result: shipsGameConfig);
          },
          child: SpriteWidget(
            sprite: $gameAssets.shootingGalleryHud.textGoSprite,
          ).scaleAnimation(duration: 600.milliseconds),
        ).center(),
      ].column()!.rFill(),
    ];
  }
}
