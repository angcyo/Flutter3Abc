import 'package:flame_games/src/tiles/game_select_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter3_core/flutter3_core.dart';

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
    with AbsScrollPage {
  @override
  bool? enableAppBar(BuildContext context) => false;

  @override
  Color? getBackgroundColor(BuildContext context) => Colors.black;

  @override
  void initState() {
    setScreenLandscape();
    //setEnabledSystemUIMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return super.build(context).darkStatusBar(context);
  }

  @override
  WidgetList? buildScrollBody(BuildContext context) {
    final gridCount = 3;
    final childAspectRatio =
        (isMobile
            ? $screenMaxSize / $screenMinSize
            : $screenWidth / $screenHeight) /
        2;
    return [
      GameSelectTile(
        label: "拼图游戏",
      ).rGridTile(gridCount, childAspectRatio: childAspectRatio),
      if (isDebug) GameSelectTile(label: "拼图游戏").rGridTile(gridCount),
      if (isDebug) GameSelectTile(label: "拼图游戏").rGridTile(gridCount),
      if (isDebug) GameSelectTile(label: "拼图游戏").rGridTile(gridCount),
      if (isDebug) GameSelectTile(label: "拼图游戏").rGridTile(gridCount),
    ];
  }
}
