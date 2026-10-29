import 'dart:async';

import 'package:flame_games/src/assets/game_assets.dart';
import 'package:flame_games/src/games/ball/throw_ball_game_config.dart';
import 'package:flame_games/src/games/ball/trajectory_ball.dart';
import 'package:flutter/material.dart';
import 'package:flutter3_basics/flutter3_basics.dart' as fb;
import 'package:flutter3_flame/flutter3_flame.dart';

import '../base_game_mixin.dart';
import '../game_hud_component.dart';
import 'throw_ball_game_controller.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/26
///
/// 掷球游戏
class ThrowBallGameScreen extends StatefulWidget with fb.TranslationTypeMixin {
  final ThrowBallGameConfig config;

  @override
  fb.TranslationType get translationType => .none;

  const ThrowBallGameScreen({required this.config, super.key});

  @override
  State<ThrowBallGameScreen> createState() => _ThrowBallGameScreenState();
}

class _ThrowBallGameScreenState extends State<ThrowBallGameScreen>
    with BaseGameStateMixin {
  @override
  Game buildGame() =>
      ThrowBallGame(world: ThrowBallWorld(), config: widget.config);
}

//MARK: - Game

/// 投球游戏
class ThrowBallGame extends BaseForge2DGame {
  ThrowBallGameController controller = ThrowBallGameController();
  final ThrowBallGameConfig config;

  ThrowBallGame({
    super.world,
    super.gravity,
    super.lengthUnitsPerMeter,
    super.metersToPixels = 100, //Forge2DViewfinder.defaultMetersToPixels
    required this.config,
  });

  @override
  Future<void> onLoad() {
    camera.viewfinder.anchor = .topLeft;
    return super.onLoad();
  }

  @override
  void onReloadGame(Vector2 size) {
    clearGameChildren();
    //添加游戏墙体
    addBoundariesWall(
      this,
      /*marginLeft: visibleWorldRect.width * config.launchAreaRatio,*/
    );
    add(ThrowBallHudComponent());
  }
}

//MARK: - World

/// 投球游戏世界
class ThrowBallWorld extends BaseForge2DWorld
    with HasGameReference<ThrowBallGame>, TapCallbacks, DragCallbacks {
  final Pitcher _pitcher = Pitcher();

  @override
  FutureOr<void> onLoad() {
    add(_pitcher..radius = game.config.ballRadius);
    /*debugMode = true;*/
    return super.onLoad();
  }

  /// 投掷区域
  Rect? launchAreaRect;

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final visibleWorldRect = game.visibleWorldRect;
    launchAreaRect ??= Rect.fromLTWH(
      visibleWorldRect.left,
      visibleWorldRect.top,
      visibleWorldRect.width * game.config.launchAreaRatio,
      visibleWorldRect.height,
    );

    //绘制投掷区域
    canvas.drawRect(launchAreaRect!, Paint()..color = Colors.white12);

    //绘制预测轨迹
    final controller = findGameController<ThrowBallGameController>();
    if (controller != null &&
        controller.innerScore < 5 &&
        controller.gameScore > 20 &&
        _pitcher.currentTrajectory != null) {
      final mass = _pitcher.ballMass;
      final points = predictTrajectory(
        start: _pitcher.currentTrajectory!.end!,
        velocity: controller.getBallVelocity(
          _pitcher.currentTrajectory!.start!,
          _pitcher.currentTrajectory!.end!,
          mass,
        ),
        gravity: gravity.y,
        min: Vector2(visibleWorldRect.left, visibleWorldRect.top),
        max: Vector2(visibleWorldRect.right, visibleWorldRect.bottom),
      );
      canvas.drawPoints(
        .polygon,
        points.map((e) => e.toOffset()).toList(),
        Paint()..color = Colors.blueGrey,
      );
    }
  }

  @override
  void onReloadWorld(Vector2 size) {
    super.onReloadWorld(size);
    removeAllChildren((e) => e is! Pitcher);
    launchAreaRect = null;
    final config = game.config;
    final visibleWorldRect = game.visibleWorldRect;
    fb.l.d("世界坐标->$visibleWorldRect");
    //添加一个测试小球
    //world.add(Ball(position: visibleWorldRect.center.toVector2()));
    //添加一个收集小球的桶
    final bucketRotateRect = config.bucketRotateRect;
    add(
      Bucket(
        position: Vector2(
          visibleWorldRect.right -
              config.bucketOffsetX -
              bucketRotateRect.left -
              bucketRotateRect.width,
          visibleWorldRect.bottom -
              config.bucketOffsetY -
              bucketRotateRect.top -
              bucketRotateRect.height,
        ),
        width: config.bucketWidth,
        height: config.bucketHeight,
        angle: config.bucketAngle,
        onBucketBodyChanged: (values) {
          findGameController<ThrowBallGameController>()?.innerScore =
              values.length;
        },
      )..debugMode = false,
    );
  }

  //MARK: event

  /// 手指按下
  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    event.continuePropagation = true;
    if (launchAreaRect?.contains(event.localPosition.toOffset()) == true ||
        isDebugMode) {
      event.handled = true;
      _pitcher.ballDownPosition(event.localPosition);
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    if (!isDragged) {
      _pitcher.cancelLaunch();
    }
  }

  ///
  @override
  void onTapCancel(TapCancelEvent event) {
    super.onTapCancel(event);
  }

  /// 手指拖动开始, 比手指按下事件来的慢
  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    _pitcher.ballMoveToPosition(event.localEndPosition);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    _pitcher.launchBall();
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    super.onDragCancel(event);
    _pitcher.cancelLaunch();
  }
}

/// 投手
class Pitcher extends TrajectoryBall {
  Pitcher({super.tag = "投手"});
}

class ThrowBallHudComponent extends GameHudComponent {
  @override
  Future<Iterable<Component>?> loadControlComponent() async {
    final throwBallGame = findParent<ThrowBallGame>();
    return [
      if (throwBallGame != null)
        SpriteComponent(
          sprite: $gameAssets.gameIcons.returnSprite,
          scale: Vector2(-1, 1),
        ).button(() {
          // 移除所有球
          throwBallGame.world.removeAllChildren(
            (e) => e is Ball && e is! Pitcher,
          );
        }),
      ...?(await super.loadControlComponent()),
    ];
  }
}
