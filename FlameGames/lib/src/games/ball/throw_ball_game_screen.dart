import 'dart:async';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_games/src/assets/game_assets.dart';
import 'package:flame_games/src/games/ball/throw_ball_game_config.dart';
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
class ThrowBallGame extends Forge2DGame {
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
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    if (isMounted) {
      clearGameChildren();
      //添加游戏墙体
      addBoundariesWall(
        this,
        /*marginLeft: visibleWorldRect.width * config.launchAreaRatio,*/
      );
      add(ThrowBallHudComponent());
    }
  }
}

//MARK: - World

/// 投球游戏世界
class ThrowBallWorld extends Forge2DWorld
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
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    if (isMounted) {
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
      _pitcher.downPosition(event.localPosition);
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    if (!isDragged) {
      _pitcher.cancelThrow();
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
    _pitcher.moveToPosition(event.localEndPosition);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    _pitcher.throwBall();
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    super.onDragCancel(event);
    _pitcher.cancelThrow();
  }
}

/// 投手
class Pitcher extends Ball {
  /// 历史投掷轨迹
  final List<ThrowBallTrajectory> _trajectories = [];

  /// 当前投掷轨迹
  ThrowBallTrajectory? currentTrajectory;

  Pitcher({
    super.bodyType = .static,
    super.color = Colors.blue,
    super.tag = "投手",
    super.enableContactEvents = false,
    super.isEnabled = false,
    super.density = 1,
  });

  @override
  Body createBody() {
    //bodyPosition = Vector2(2, 2);
    bodyPosition.setFrom(Vector2(2, 2));
    return super.createBody();
  }

  @override
  void update(double dt) {
    //super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    //绘制历史轨迹
    for (final trajectory in _trajectories) {
      canvas.drawDashedLine(
        (trajectory.start! - position).toOffset(),
        (trajectory.end! - position).toOffset(),
        dashLength: 0.08,
        gapLength: 0.05,
        paint: Paint()..color = Colors.grey,
      );
    }
    if (currentTrajectory != null) {
      canvas.drawLine(
        (currentTrajectory!.start! - position).toOffset(),
        (currentTrajectory!.end! - position).toOffset(),
        Paint()..color = Colors.grey,
      );
      super.render(canvas);
    }
  }

  //--

  /// 投手按下的位置
  void downPosition(Vector2 position) {
    currentTrajectory = ThrowBallTrajectory()..startWith(position);
    body.setTransform(position, body.rotation);
  }

  /// 移动到指定位置
  void moveToPosition(Vector2 position) {
    currentTrajectory?.endWith(position);
    body.setTransform(position, body.rotation);
  }

  /// 取消投掷
  void cancelThrow() {
    currentTrajectory = null;
  }

  /// 投手投球
  void throwBall() async {
    final ct = currentTrajectory;
    if (ct == null) {
      return;
    }
    // 创建一个球
    late Ball ball;
    ball =
        Ball(
            position: ct.end!,
            color: originalPaint.color,
            radius: radius,
            density: density,
            tag: "投球",
          )
          ..onBeginContact = (other, contact) {
            if (!contact.isSensorEvent && ball.body.linearVelocity.length > 1) {
              if (other is Bucket) {
                $gameAssets.playImpactBucketEffect();
              } else if (other is Wall) {
                $gameAssets.playImpactEffect();
              }
            }
          };
    // 添加球到世界
    await world.add(ball);
    // 给球一个初始速度
    final impulse = calculateImpulse(
      ct.start!,
      ct.end!,
      strength: 1,
    ) /*Vector2(1, -1)*/;
    ball.body.applyLinearImpulseEx(
      impulse,
      /*point: ball.bodyPosition,*/
      wake: false,
    );
    _trajectories.add(ct);
    currentTrajectory = null;
    //--
    baseGameController?.gameScore++;
  }
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
