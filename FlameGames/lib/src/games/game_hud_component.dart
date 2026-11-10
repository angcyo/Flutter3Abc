import 'dart:async';

import 'package:flutter3_basics/flutter3_basics.dart' as fb;
import 'package:flutter3_flame/flutter3_flame.dart';

import '../assets/game_assets.dart';
import 'base_game_controller.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/27
///
/// 游戏通用HUD显示组件
class GameHudComponent extends PositionComponent with HasGameReference {
  /// 对应的文本组件
  final FlameTextComponent durationTextComponent = FlameTextComponent(
    text: "00:00",
  );
  final FlameTextComponent scoreTextComponent = FlameTextComponent(text: "0");
  final FlameTextComponent otherTextComponent = FlameTextComponent(text: "");

  @override
  FutureOr<void> onLoad() async {
    await initHudComponents();
    return super.onLoad();
  }

  /// 初始化HUD组件
  FutureOr<void> initHudComponents() async {
    //TextComponent
    scale = Vector2.all(pixelsScale);
    add(
      FlowComponent(
        position: Vector2(10, 10),
        rowCrossAxisAlignment: .center,
        children: [
          FlameTextComponent(text: baseGameController?.durationLabel ?? "用时: "),
          durationTextComponent,
        ],
      ),
    );
    add(
      FlowComponent(
        position: Vector2(10, 40),
        rowCrossAxisAlignment: .center,
        children: [
          FlameTextComponent(text: baseGameController?.scoreLabel ?? "分数: "),
          scoreTextComponent,
        ],
      ),
    );
    add(
      FlowComponent(
        position: Vector2(10, 70),
        rowCrossAxisAlignment: .center,
        children: [
          FlameTextComponent(text: baseGameController?.otherLabel),
          otherTextComponent,
        ],
      ),
    );
    //--控制
    add(
      FlowComponent(
        position: Vector2(10, 10),
        crossAxisAlignment: .end,
        maxChildrenPerRow: 1,
        children: await loadControlComponent(),
      )..debugMode = false,
    );
  }

  /// 加载控制组件列表
  @fb.overridePoint
  Future<Iterable<Component>?> loadControlComponent() async {
    return [
      if (isDebugMode)
        SpriteComponent(sprite: $gameAssets.gameIcons.pauseSprite).button(() {
          game.pauseEngine();
        }),
      //--
      SpriteComponent(
        sprite: $gameAssets.isGameMute
            ? $gameAssets.gameIcons.audioOffSprite
            : $gameAssets.gameIcons.audioOnSprite,
      ).toggleSprite(() {
        $gameAssets.isGameMute = !$gameAssets.isGameMute;
        return $gameAssets.isGameMute
            ? $gameAssets.gameIcons.audioOffSprite
            : $gameAssets.gameIcons.audioOnSprite;
      }),
      //--
      SpriteComponent(sprite: $gameAssets.gameIcons.returnSprite).button(() {
        game.resumeEngine();
        game.pop();
      }),
    ];
  }

  /// 更新游戏数据
  @override
  void update(double dt) {
    super.update(dt);
    final controller = baseGameController;
    if (controller == null || controller.isGameSolved) {
      return;
    }
    controller.gameDuration += (dt * 1000).toInt();
    durationTextComponent.text = controller.durationText;
    scoreTextComponent.text = controller.scoreText;
    otherTextComponent.text = controller.otherText;
  }

  ///
  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }
}

extension GameHudComponentExtension on Component {
  /// 获取游戏控制器
  BaseGameController? get baseGameController {
    try {
      final parent = findParent<PositionComponent>();
      if (parent != null) {
        return (parent as dynamic).controller;
      }
    } catch (e) {
      //no op
    }
    try {
      final world = findParent<World>();
      if (world != null) {
        return (world as dynamic).controller;
      }
    } catch (e) {
      //no op
    }
    try {
      final game = findGame();
      if (game != null) {
        try {
          return (game as dynamic).controller;
        } catch (e) {
          return (game.world as dynamic).controller;
        }
      }
    } catch (e) {
      //no op
    }
    return null;
  }

  /// 获取游戏控制器
  T? findGameController<T>() {
    final controller = baseGameController;
    return controller is T ? controller as T : null;
  }

  /// 获取游戏世界
  T? findGameWorld<T>() {
    try {
      final world = findParent<World>();
      if (world is T) {
        return world as T;
      }
    } catch (e) {
      //no op
    }
    try {
      final game = findGame();
      if (game != null) {
        if (game.world is T) {
          return game.world as T;
        }
      }
    } catch (e) {
      //no op
    }
    return null;
  }
}
