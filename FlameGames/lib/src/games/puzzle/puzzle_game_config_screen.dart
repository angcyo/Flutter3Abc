import 'package:flame_games/src/games/puzzle/puzzle_game_config.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter3_core/flutter3_core.dart';
import 'package:flutter3_flame/flutter3_flame.dart';

import '../../assets/game_assets.dart';
import '../../widgets/game_number.dart';
import '../../widgets/game_select_chip.dart';
import '../base_game_scroll_page.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/23
///
/// 拼图游戏配置选择界面
///
/// @return [PuzzleGameConfig]
class PuzzleGameConfigScreen extends StatefulWidget with TranslationTypeMixin {
  @override
  TranslationType get translationType => .none;

  const PuzzleGameConfigScreen({super.key});

  @override
  State<PuzzleGameConfigScreen> createState() => _PuzzleGameConfigScreenState();
}

class _PuzzleGameConfigScreenState extends State<PuzzleGameConfigScreen>
    with AbsScrollPage, BaseGameScrollPage {
  /// 拼图游戏配置
  static final puzzleGameConfig = PuzzleGameConfig();

  @override
  void initState() {
    puzzleGameConfig.seed = "seed_${nowTimestamp()}";
    super.initState();
  }

  @override
  WidgetList? buildScrollBody(BuildContext context) {
    return [
      //--
      SpriteWidget(sprite: $gameAssets.gameIcons.returnSprite)
          .inkWellCircle(() {
            buildContext?.pop();
          })
          .align(.topLeft)
          .safeArea(),
      //--
      [
        GameOutlineText(text: "选择游戏人数").center(),
        [
          GameSelectChip(
            isSelected: puzzleGameConfig.playerCount == 1,
            onSelected: (selected) {
              puzzleGameConfig.playerCount = selected ? 1 : 2;
              updateState();
              $gameAssets.playClickEffect();
            },
            child: GameOutlineText.item(text: "单人"),
          ),
          GameSelectChip(
            isSelected: puzzleGameConfig.playerCount == 2,
            onSelected: (selected) {
              puzzleGameConfig.playerCount = selected ? 2 : 1;
              updateState();
              $gameAssets.playClickEffect();
            },
            child: GameOutlineText.item(text: "双人"),
          ),
        ].row(mainAxisAlignment: .center, gap: 20)!,
        //--
        GameOutlineText(text: "选择游戏难度").center(),
        [
          for (final count in [3, 4, 5, 6, 7, 8, 9, 10])
            GameSelectChip(
              isSelected: puzzleGameConfig.gridCount == count,
              onSelected: (selected) {
                puzzleGameConfig.gridCount = count;
                updateState();
                $gameAssets.playClickEffect();
              },
              child: GameNumberWidget(
                "$count",
                usePersonalStyle: true,
              ).insets(all: 10),
            ),
        ].row(mainAxisAlignment: .center, gap: 0)!,
        //--
        GameOutlineText(text: "选择类型").center(),
        [
          GameSelectChip(
            isSelected: puzzleGameConfig.gameType == .number,
            onSelected: (selected) {
              puzzleGameConfig.gameType = .number;
              updateState();
              $gameAssets.playClickEffect();
            },
            child: GameOutlineText.item(text: "数字"),
          ),
          GameSelectChip(
            isSelected: puzzleGameConfig.gameType == .image,
            onSelected: (selected) {
              puzzleGameConfig.gameType = .image;
              updateState();
              $gameAssets.playClickEffect();
            },
            child: GameOutlineText.item(text: "图片"),
          ),
        ].row(mainAxisAlignment: .center, gap: 20)!,
        //--
        GameSelectChip(
          onSelected: (selected) {
            buildContext?.pop(result: puzzleGameConfig);
          },
          child: SpriteWidget(
            sprite: $gameAssets.shootingGalleryHud.textGoSprite,
          ).scaleAnimation(duration: 600.milliseconds),
        ).center(),
      ].column()!.rFill(),
    ];
  }
}
