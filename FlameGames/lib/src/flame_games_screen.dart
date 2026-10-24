import 'package:flame_games/src/games/puzzle/puzzle_game_config.dart';
import 'package:flame_games/src/tiles/game_select_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter3_core/flutter3_core.dart';

import 'games/base_game_scroll_page.dart';
import 'games/puzzle/puzzle_game_config_screen.dart';
import 'games/puzzle/puzzle_game_screen.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/21
///
/// 游戏列表界面
class FlameGamesScreen extends StatefulWidget {
  const FlameGamesScreen({super.key});

  @override
  State<FlameGamesScreen> createState() => _FlameGamesScreenState();
}

class _FlameGamesScreenState extends State<FlameGamesScreen>
    with AbsScrollPage, BaseGameScrollPage {
  @override
  WidgetList? buildScrollBody(BuildContext context) {
    final gridCount = 3;
    final childAspectRatio = isMobile
        ? $screenMaxSize / $screenMinSize / 1.5
        : 1.0;
    return [
      GameSelectTile(
        label: "拼图游戏",
        onTap: () async {
          final config = await buildContext?.pushWidget(
            PuzzleGameConfigScreen(),
          );
          if (config is PuzzleGameConfig) {
            buildContext?.pushWidget(PuzzleGameScreen(config: config));
          }
        },
      ).rGridTile(gridCount, childAspectRatio: childAspectRatio),
      if (isDebug) GameSelectTile(label: "拼图游戏").rGridTile(gridCount),
      if (isDebug) GameSelectTile(label: "拼图游戏").rGridTile(gridCount),
      if (isDebug) GameSelectTile(label: "拼图游戏").rGridTile(gridCount),
      if (isDebug) GameSelectTile(label: "拼图游戏").rGridTile(gridCount),
    ];
  }
}
