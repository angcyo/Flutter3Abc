import 'package:flutter/widgets.dart';
import 'package:flutter3_core/flutter3_core.dart';
import 'package:flutter3_flame/flutter3_flame.dart';

import '../../assets/game_assets.dart';
import '../../widgets/game_select_chip.dart';
import '../base_game_scroll_page.dart';
import 'pinball_game_config.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/28
///
/// 弹球乐游戏配置页面
class PinballGameConfigScreen extends StatefulWidget with TranslationTypeMixin {
  @override
  TranslationType get translationType => .none;

  const PinballGameConfigScreen({super.key});

  @override
  State<PinballGameConfigScreen> createState() =>
      _PinballGameConfigScreenState();
}

class _PinballGameConfigScreenState extends State<PinballGameConfigScreen>
    with AbsScrollPage, BaseGameScrollPage {
  /// 游戏配置
  static final pinballGameConfig = PinballGameConfig();

  @override
  WidgetList? buildScrollBody(BuildContext context) {
    return [
      //--
      [
        /*GameOutlineText(text: "选择球的半径").center(),
        [
          for (final value in [0.05, 0.1, 0.15, 0.2, 0.25, 0.3])
            GameSelectChip(
              isSelected: pinballGameConfig.ballRadius == value,
              onSelected: (selected) {
                pinballGameConfig.ballRadius = value;
                updateState();
                $gameAssets.playClickEffect();
              },
              child: GameNumberWidget("$value", usePersonalStyle: true),
            ),
        ].row(mainAxisAlignment: .center, gap: 0)!,
        //--
        GameOutlineText(text: "选择桶的宽度").center(),
        [
          for (final value in [0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 3.0])
            GameSelectChip(
              isSelected: pinballGameConfig.bucketWidth == value,
              onSelected: (selected) {
                pinballGameConfig.bucketWidth = value;
                updateState();
                $gameAssets.playClickEffect();
              },
              child: GameNumberWidget("$value", usePersonalStyle: true),
            ),
        ].row(mainAxisAlignment: .center, gap: 0)!,
        //--
        GameOutlineText(text: "选择桶的高度").center(),
        [
          for (final value in [0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 3.0])
            GameSelectChip(
              isSelected: pinballGameConfig.bucketHeight == value,
              onSelected: (selected) {
                pinballGameConfig.bucketHeight = value;
                updateState();
                $gameAssets.playClickEffect();
              },
              child: GameNumberWidget("$value", usePersonalStyle: true),
            ),
        ].row(mainAxisAlignment: .center, gap: 0)!,
        //--
        GameOutlineText(text: "选择桶的旋转角度").center(),
        [
          for (final value in [0, 15, 30, 45, 60, 75, 90])
            GameSelectChip(
              isSelected: pinballGameConfig.bucketAngle.jd.round() == -value,
              onSelected: (selected) {
                pinballGameConfig.bucketAngle = -value.hd;
                updateState();
                $gameAssets.playClickEffect();
              },
              child: GameNumberWidget("$value", usePersonalStyle: true),
            ),
        ].row(mainAxisAlignment: .center, gap: 0)!,
        //--
        GameOutlineText(text: "选择投掷区域大小").center(),
        [
          for (final value in [0.1, 0.2, 0.3, 0.4, 0.5, 0.6])
            GameSelectChip(
              isSelected: pinballGameConfig.launchAreaRatio == value,
              onSelected: (selected) {
                pinballGameConfig.launchAreaRatio = value;
                updateState();
                $gameAssets.playClickEffect();
              },
              child: GameNumberWidget("$value", usePersonalStyle: true),
            ),
        ].row(mainAxisAlignment: .center, gap: 0)!,*/
        GameOutlineText(text: "选择游戏人数").center(),
        [
          GameSelectChip(
            isSelected: pinballGameConfig.playerCount == 1,
            onSelected: (selected) {
              pinballGameConfig.playerCount = selected ? 1 : 2;
              updateState();
              $gameAssets.playClickEffect();
            },
            child: GameOutlineText.item(text: "单人"),
          ),
          GameSelectChip(
            isSelected: pinballGameConfig.playerCount == 2,
            onSelected: (selected) {
              pinballGameConfig.playerCount = selected ? 2 : 1;
              updateState();
              $gameAssets.playClickEffect();
            },
            child: GameOutlineText.item(text: "双人"),
          ),
        ].row(mainAxisAlignment: .center, gap: 20)!,
        //--
        GameSelectChip(
          onSelected: (selected) {
            buildContext?.pop(result: pinballGameConfig);
          },
          child: SpriteWidget(
            sprite: $gameAssets.shootingGalleryHud.textGoSprite,
          ).scaleAnimation(duration: 600.milliseconds),
        ).center(),
      ].column()!.rFill(),
    ];
  }
}
