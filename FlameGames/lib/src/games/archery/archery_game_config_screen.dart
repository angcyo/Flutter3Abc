import 'package:flutter/widgets.dart';
import 'package:flutter3_core/flutter3_core.dart';
import 'package:flutter3_flame/flutter3_flame.dart';

import '../../assets/game_assets.dart';
import '../../widgets/game_select_chip.dart';
import '../base_game_scroll_page.dart';
import 'archery_game_config.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/03
///
/// 射箭游戏配置界面
class ArcheryGameConfigScreen extends StatefulWidget with TranslationTypeMixin {
  @override
  TranslationType get translationType => .none;

  const ArcheryGameConfigScreen({super.key});

  @override
  State<ArcheryGameConfigScreen> createState() =>
      _ArcheryGameConfigScreenState();
}

class _ArcheryGameConfigScreenState extends State<ArcheryGameConfigScreen>
    with AbsScrollPage, BaseGameScrollPage {
  /// 游戏配置
  static final archeryGameConfig = ArcheryGameConfig();

  @override
  WidgetList? buildScrollBody(BuildContext context) {
    return [
      //--
      [
        //--
        GameSelectChip(
          onSelected: (selected) {
            buildContext?.pop(result: archeryGameConfig);
          },
          child: SpriteWidget(
            sprite: $gameAssets.shootingGalleryHud.textGoSprite,
          ).scaleAnimation(duration: 600.milliseconds),
        ).center(),
      ].column()!.rFill(),
    ];
  }
}
