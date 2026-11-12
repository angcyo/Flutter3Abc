import 'package:flame_games/src/games/duel/duel_game_config.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter3_core/flutter3_core.dart';
import 'package:flutter3_flame/flutter3_flame.dart';

import '../../assets/game_assets.dart';
import '../../widgets/game_select_chip.dart';
import '../base_game_scroll_page.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/09
///
/// 游戏配置界面
class DuelGameConfigScreen extends StatefulWidget with TranslationTypeMixin {
  @override
  TranslationType get translationType => .none;

  const DuelGameConfigScreen({super.key});

  @override
  State<DuelGameConfigScreen> createState() => _DuelGameConfigScreenState();
}

class _DuelGameConfigScreenState extends State<DuelGameConfigScreen>
    with AbsScrollPage, BaseGameScrollPage {
  /// 游戏配置
  static final duelGameConfig = DuelGameConfig();

  @override
  WidgetList? buildScrollBody(BuildContext context) {
    return [
      //--
      [
        //--
        GameOutlineText(text: "选择游戏难度").center(),
        [
          GameSelectChip(
            isSelected: duelGameConfig.gameDifficulty == 1,
            onSelected: (selected) {
              duelGameConfig.gameDifficulty = selected ? 1 : 2;
              updateState();
              $gameAssets.playClickEffect();
            },
            child: GameOutlineText.item(text: "简单"),
          ),
          GameSelectChip(
            isSelected: duelGameConfig.gameDifficulty == 2,
            onSelected: (selected) {
              duelGameConfig.gameDifficulty = selected ? 2 : 1;
              updateState();
              $gameAssets.playClickEffect();
            },
            child: GameOutlineText.item(text: "中等"),
          ),
          GameSelectChip(
            isSelected: duelGameConfig.gameDifficulty == 3,
            onSelected: (selected) {
              duelGameConfig.gameDifficulty = selected ? 3 : 1;
              updateState();
              $gameAssets.playClickEffect();
            },
            child: GameOutlineText.item(text: "困难"),
          ),
        ].row(mainAxisAlignment: .center, gap: 20)!,
        //--
        GameOutlineText(text: "选择游戏模式").center(),
        [
          GameSelectChip(
            isSelected: duelGameConfig.gameMode == .speed,
            onSelected: (selected) {
              duelGameConfig.gameMode = selected ? .speed : .fixed;
              updateState();
              $gameAssets.playClickEffect();
            },
            child: GameOutlineText.item(text: "竞速"),
          ),
          GameSelectChip(
            isSelected: duelGameConfig.gameMode == .fixed,
            onSelected: (selected) {
              duelGameConfig.gameMode = selected ? .fixed : .speed;
              updateState();
              $gameAssets.playClickEffect();
            },
            child: GameOutlineText.item(text: "固定"),
          ),
        ].row(mainAxisAlignment: .center, gap: 20)!,
        if (duelGameConfig.gameMode == .fixed) ...[
          //--
          GameOutlineText(text: "固定操作基数").center(),
          [
            GameSelectChip(
              isSelected:
                  duelGameConfig.phase1TapCount ==
                  DuelGameConfig.kTapCountList[0],
              onSelected: (selected) {
                duelGameConfig.phase1TapCount = selected
                    ? DuelGameConfig.kTapCountList[0]
                    : 0;
                updateState();
                $gameAssets.playClickEffect();
              },
              child: GameOutlineText.item(
                text: "${DuelGameConfig.kTapCountList[0]}",
              ),
            ),
            GameSelectChip(
              isSelected:
                  duelGameConfig.phase1TapCount ==
                  DuelGameConfig.kTapCountList[1],
              onSelected: (selected) {
                duelGameConfig.phase1TapCount = selected
                    ? DuelGameConfig.kTapCountList[1]
                    : 0;
                updateState();
                $gameAssets.playClickEffect();
              },
              child: GameOutlineText.item(
                text: "${DuelGameConfig.kTapCountList[1]}",
              ),
            ),
            GameSelectChip(
              isSelected:
                  duelGameConfig.phase1TapCount ==
                  DuelGameConfig.kTapCountList[2],
              onSelected: (selected) {
                duelGameConfig.phase1TapCount = selected
                    ? DuelGameConfig.kTapCountList[2]
                    : 0;
                updateState();
                $gameAssets.playClickEffect();
              },
              child: GameOutlineText.item(
                text: "${DuelGameConfig.kTapCountList[2]}",
              ),
            ),
          ].row(mainAxisAlignment: .center, gap: 20)!,
        ],
        //--
        GameSelectChip(
          onSelected: (selected) {
            buildContext?.pop(result: duelGameConfig);
          },
          child: SpriteWidget(
            sprite: $gameAssets.shootingGalleryHud.textGoSprite,
          ).scaleAnimation(duration: 600.milliseconds),
        ).center(),
      ].column()!.rFill(),
    ];
  }
}
