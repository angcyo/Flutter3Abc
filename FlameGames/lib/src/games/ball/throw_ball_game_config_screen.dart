import 'package:flutter/widgets.dart';
import 'package:flutter3_core/flutter3_core.dart';
import 'package:flutter3_flame/flutter3_flame.dart';

import '../../assets/game_assets.dart';
import '../../widgets/game_number.dart';
import '../../widgets/game_select_chip.dart';
import '../base_game_scroll_page.dart';
import 'throw_ball_game_config.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/27
///
/// 掷球游戏配置界面
class ThrowBallGameConfigScreen extends StatefulWidget
    with TranslationTypeMixin {
  @override
  TranslationType get translationType => .none;

  const ThrowBallGameConfigScreen({super.key});

  @override
  State<ThrowBallGameConfigScreen> createState() =>
      _ThrowBallGameConfigScreenState();
}

class _ThrowBallGameConfigScreenState extends State<ThrowBallGameConfigScreen>
    with AbsScrollPage, BaseGameScrollPage {
  /// 掷球游戏配置
  static final throwBallGameConfig = ThrowBallGameConfig();

  @override
  WidgetList? buildScrollBody(BuildContext context) {
    return [

      //--
      [
        GameOutlineText(text: "选择球的半径").center(),
        [
          for (final value in [0.05, 0.1, 0.15, 0.2, 0.25, 0.3])
            GameSelectChip(
              isSelected: throwBallGameConfig.ballRadius == value,
              onSelected: (selected) {
                throwBallGameConfig.ballRadius = value;
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
              isSelected: throwBallGameConfig.bucketWidth == value,
              onSelected: (selected) {
                throwBallGameConfig.bucketWidth = value;
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
              isSelected: throwBallGameConfig.bucketHeight == value,
              onSelected: (selected) {
                throwBallGameConfig.bucketHeight = value;
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
              isSelected: throwBallGameConfig.bucketAngle.jd.round() == -value,
              onSelected: (selected) {
                throwBallGameConfig.bucketAngle = -value.hd;
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
              isSelected: throwBallGameConfig.launchAreaRatio == value,
              onSelected: (selected) {
                throwBallGameConfig.launchAreaRatio = value;
                updateState();
                $gameAssets.playClickEffect();
              },
              child: GameNumberWidget("$value", usePersonalStyle: true),
            ),
        ].row(mainAxisAlignment: .center, gap: 0)!,
        //--
        GameSelectChip(
          onSelected: (selected) {
            buildContext?.pop(result: throwBallGameConfig);
          },
          child: SpriteWidget(
            sprite: $gameAssets.shootingGalleryHud.textGoSprite,
          ).scaleAnimation(duration: 600.milliseconds),
        ).center(),
      ].column()!.rFill(),
    ];
  }
}
