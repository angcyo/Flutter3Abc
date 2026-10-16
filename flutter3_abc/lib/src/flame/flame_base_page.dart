import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter3_app/flutter3_app.dart' as f3;
import 'package:flutter3_flame/flutter3_flame.dart';

import '../../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/16
///
/// Flame 基础信息
class FlameBasePage extends StatefulWidget {
  const FlameBasePage({super.key});

  @override
  State<FlameBasePage> createState() => _FlameBasePageState();
}

class _FlameBasePageState extends State<FlameBasePage> with BaseAbcStateMixin {
  @override
  f3.WidgetList buildBodyList(BuildContext context) {
    return [
      GameWidget(
        game: BaseGame(
          world: BaseWorld(),
          camera: BaseCameraComponent(viewport: LeftTopViewport()),
        ),
      ).size(height: 400),
    ];
  }
}

/// 加载abc的精灵动画
Future<SpriteAnimation> loadAbcSpriteAnimation(
  String path,
  SpriteAnimationData data,
) {
  return SpriteAnimation.load(path, data, package: Assets.package);
}

//MARK: - Camera

class BaseCameraComponent extends CameraComponent {
  BaseCameraComponent({super.viewport}) {
    //
  }
}

/// 左上角对齐的视口
class LeftTopViewport extends MaxViewport {
  ///
  @override
  set position(Vector2 value) {
    super.position = value;
  }

  @override
  void onLoad() {
    super.onLoad();
    position = -findGame()!.canvasSize / 2;
    //position = Vector2(100, 100);
  }

  @override
  void onGameResize(Vector2 size) {
    position = -size / 2;
    super.onGameResize(size);
  }
}

//MARK: - Game

/// -[Game.pauseEngine] 暂停引擎
/// -[Game.resumeEngine] 恢复引擎
/// -[Game.mouseCursor]
///
/// -[ComponentTreeRoot.findByKey]
///
/// [SingleGameInstance]
/// [HasGameReference]
/// [HasPerformanceTracker]
class BaseGame extends FlameGame<BaseWorld> {
  BaseGame({required super.world, super.camera});

  @override
  Color backgroundColor() {
    //return super.backgroundColor();
    return Colors.grey;
  }

  //MARK: callback

  /// -> 1 [onGameResize]->[onLoad]->[onMount]->[update]->[onAttach]
  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  /// -> 2
  @override
  void onMount() {
    super.onMount();
  }

  /// -> 3
  @override
  void onAttach() {
    super.onAttach();
  }

  /// [onMount] -> [update]
  /// - [dt] delta time
  ///   - 0.150115
  ///   - 0.500382
  @override
  void update(double dt) {
    super.update(dt);
  }

  /// [update] -> [updateTree]
  @override
  void updateTree(double dt) {
    super.updateTree(dt);
  }

  /// [onAttach] -> [render]
  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  /// [render] -> [renderTree]
  @override
  void renderTree(Canvas canvas) {
    super.renderTree(canvas);
  }

  /// <- 1 [onDetach]->[onRemove]->[onDispose]
  @override
  void onDetach() {
    super.onDetach();
  }

  /// <- 2
  @override
  void onRemove() {
    super.onRemove();
  }

  /// <- 3
  @override
  void onDispose() {
    super.onDispose();
  }

  //MARK: size

  ///
  @override
  Vector2 get size => super.size;

  ///
  @override
  Vector2 get canvasSize => super.canvasSize;

  ///[onGameResize]->[onLoad]
  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    assert(() {
      f3.l.i("[${classHash()}]onGameResize: $size");
      return true;
    }());
  }
}

//MARK: - World

/// - [Component.add]
/// - [Component.addToParent]
/// - [Component.remove]
/// - [Component.removeFromParent]
///
/// - [Component.contains]
/// - [Component.children]
///
/// - [Component.findGame]
/// - [Component.findRootGame]
///
/// [HasWorldReference]
class BaseWorld extends World {
  /// -> 1 [onParentResize]->[onLoad]->[onGameResize]->[onMount]->[update]->[onAttach]
  @override
  FutureOr<void> onLoad() {
    add(CenterCrossComponent());
    add(BaseTextComponent(text: "Text"));
    return super.onLoad();
  }

  /// -> 2
  @override
  void onMount() {
    super.onMount();
  }

  ///
  @override
  void update(double dt) {
    super.update(dt);
  }

  ///
  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  ///
  @override
  void onRemove() {
    super.onRemove();
  }

  /// [onParentResize]->[onLoad]->[onGameResize]
  @override
  void onParentResize(Vector2 maxSize) {
    super.onParentResize(maxSize);
  }

  /// [onLoad]->[onGameResize]
  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
  }
}

//MARK: - Component

/// # 组件
/// https://docs.flame-engine.org/latest/flame/components/components.html
///
/// ## 精灵组件
/// https://docs.flame-engine.org/latest/flame/components/sprite_components.html
///
/// ## 视差组件
/// https://docs.flame-engine.org/latest/flame/components/parallax_component.html
///
/// - [Component]
///   - [TimerComponent]
///   - [Effect]
///   - [PositionComponent] https://docs.flame-engine.org/latest/flame/components/position_component.html
///     - [PositionComponent.toRect]
///   - [FlameGame]
///     - [Game]
///
/// 默认文本左上角对齐0,0位置绘制
///
/// [HasVisibility]
class BaseTextComponent extends TextComponent with HasGameReference {
  BaseTextComponent({super.text, super.scale});

  @override
  FutureOr<void> onLoad() {
    scale = Vector2(0.5, 0.5);
    return super.onLoad();
  }

  ///
  @override
  void updateBounds() {
    super.updateBounds();
  }

  @override
  void update(double dt) {
    final game = this.game;
    final camera = game.camera;
    final viewfinder = camera.viewfinder;
    final viewport = camera.viewport;
    text =
        "visibleWorldRect:${camera.visibleWorldRect}\n"
        "visibleGameSize:${viewfinder.visibleGameSize}\n"
        "viewportPosition:${viewport.position}\n"
        "viewportSize:${viewport.size}\n"
        "gameSize:${game.size}\n"
        "canvasSize:${game.canvasSize}\n"
        "position:$position\n"
        "size:$size\n"
        "scale:$scale\n";
    super.update(dt);
  }

  ///
  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }
}

/// 原点十字架组件
class OriginCrossComponent extends Component with HasGameReference {
  @override
  void render(Canvas canvas) {
    final game = this.game;
    final offset = 20.0;
    canvas.drawLine(
      Offset(offset - game.canvasSize.x / 2, 0),
      Offset(game.canvasSize.x / 2 - offset, 0),
      Paint()..color = Colors.red,
    );
    canvas.drawLine(
      Offset(0, offset - game.canvasSize.y / 2),
      Offset(0, game.canvasSize.y / 2 - offset),
      Paint()..color = Colors.red,
    );
    super.render(canvas);
  }
}

/// 中心点十字架组件
class CenterCrossComponent extends Component with HasGameReference {
  @override
  void render(Canvas canvas) {
    final game = this.game;
    final offset = 20.0;
    canvas.drawLine(
      Offset(offset, game.canvasSize.y / 2),
      Offset(game.canvasSize.x - offset, game.canvasSize.y / 2),
      Paint()..color = Colors.red,
    );
    canvas.drawLine(
      Offset(game.canvasSize.x / 2, offset),
      Offset(game.canvasSize.x / 2, game.canvasSize.y - offset),
      Paint()..color = Colors.red,
    );
    super.render(canvas);
  }
}
