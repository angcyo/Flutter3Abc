import 'dart:async';

import 'package:flame_games/src/games/ball/trajectory_ball.dart';
import 'package:flutter/material.dart';
import 'package:flutter3_basics/flutter3_basics.dart' as fb;
import 'package:flutter3_flame/flutter3_flame.dart';

import '../../assets/game_assets.dart';
import '../ball/throw_ball_game_config.dart';
import '../base_game_mixin.dart';
import '../game_hud_component.dart';
import 'archery_game_config.dart';
import 'archery_game_controller.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/03
///
/// 射箭游戏界面
class ArcheryGameScreen extends StatefulWidget with fb.TranslationTypeMixin {
  final ArcheryGameConfig config;

  @override
  fb.TranslationType get translationType => .none;

  const ArcheryGameScreen({super.key, required this.config});

  @override
  State<ArcheryGameScreen> createState() => _ArcheryGameScreenState();
}

class _ArcheryGameScreenState extends State<ArcheryGameScreen>
    with BaseGameStateMixin {
  @override
  Game buildGame() => ArcheryGame(world: ArcheryWorld(), config: widget.config);
}

//MARK: - Game

/// 射箭游戏
class ArcheryGame extends BaseForge2DGame {
  final ArcheryGameController controller = ArcheryGameController();
  final ArcheryGameConfig config;

  ArcheryGame({
    super.world,
    super.gravity,
    super.lengthUnitsPerMeter,
    super.metersToPixels = 100, //Forge2DViewfinder.defaultMetersToPixels
    required this.config,
  });

  @override
  Future<void> onLoad() {
    controller.config = config;
    camera.viewfinder.anchor = .topLeft;
    return super.onLoad();
  }

  @override
  void onReloadGame(Vector2 size) {
    clearGameChildren();
    //添加游戏墙体
    addBoundariesWall(this, marginLeft: -visibleWorldRect.width / 2);
    add(ArcheryHudComponent());
  }
}

//MARK: - World

/// 投球游戏世界
class ArcheryWorld extends BaseForge2DWorld
    with HasGameReference<ArcheryGame>, TapCallbacks, DragCallbacks {
  final _archeryPlayer = ArcheryPlayer(isEnabled: false);

  @override
  FutureOr<void> onLoad() {
    add(_archeryPlayer);
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    //绘制投掷区域
    canvas.drawRect(
      archeryController.playerAreaRect!,
      Paint()..color = Colors.white12,
    );

    //绘制预测轨迹
    /*if (archeryController != null &&
        archeryController.innerScore < 5 &&
        archeryController.gameScore > 20 &&
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
    }*/
  }

  @override
  void onReloadWorld(Vector2 size) {
    super.onReloadWorld(size);
    final visibleWorldRect = game.visibleWorldRect;
    fb.l.d("世界坐标->$visibleWorldRect");
    archeryController.playerAreaRect = Rect.fromLTWH(
      visibleWorldRect.left,
      visibleWorldRect.top,
      visibleWorldRect.width * archeryController.config.playerAreaRatio,
      visibleWorldRect.height,
    );
    removeAllChildren((e) => e is! ArcheryPlayer);
    //添加一个靶子
    add(ArcheryTarget()..debugMode = false);
  }

  //MARK: event

  /// 手指按下
  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    event.continuePropagation = true;
    if (archeryController.isInPlayerArea(event.localPosition) == true) {
      event.handled = true;
      _archeryPlayer.ballDownPosition(event.localPosition);
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    if (!isDragged) {
      _archeryPlayer.cancelLaunch();
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
    _archeryPlayer.ballMoveToPosition(event.localEndPosition);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    _archeryPlayer.launchBall();
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    super.onDragCancel(event);
    _archeryPlayer.cancelLaunch();
  }
}

/// 箭手
class ArcheryPlayer extends Archery {
  ArcheryPlayer({
    super.tag = "箭手",
    super.isEnabled = true,
    super.alwaysRenderBody = false,
    super.bodyType = .static,
  });

  @override
  FShapeGeometry? createBallGeometry(FBody body) {
    /*width = archeryController.config.archeryMaxWidth.minOf(
      (currentTrajectory?.distanceX.abs() ?? 0).maxOf(0.01),
    );*/
    width = (currentTrajectory?.distanceX.abs() ?? 0).maxOf(0.01);
    height = archeryController.config.archeryHeight;
    //fb.l.d("width:$width");
    return super.createBallGeometry(body);
  }

  @override
  void renderArrow(Canvas canvas) {
    if (currentTrajectory != null) {
      super.renderArrow(canvas);
    }
  }

  @override
  void ballDownPosition(Vector2 position) {
    currentTrajectory = BallTrajectory()..startWith(position);
    reloadBody();
    body.setTransform(
      position - Vector2(0, archeryController.config.archeryHeight / 2),
      body.rotation,
    );
  }

  @override
  void ballMoveToPosition(Vector2 position) {
    //只能水平移动
    position.y = currentTrajectory?.start?.y ?? position.y;
    currentTrajectory?.endWith(position);
    reloadBody();
    body.setTransform(
      position - Vector2(0, archeryController.config.archeryHeight / 2),
      body.rotation,
    );
  }

  @override
  Future<dynamic> launchBall() async {
    final ct = currentTrajectory;
    if (ct == null) {
      return;
    }
    final world = this.world;
    final parent = this.parent;
    final startPosition = world != parent ? parent?.componentPosition : null;
    final target = parent ?? world;
    //debugger();
    // 创建一把剑
    late Archery archery;
    archery =
        Archery(
            position:
                ct.end! -
                Vector2(0, height / 2) +
                (startPosition ?? Vector2.zero()),
            width: width,
            height: height,
            tag: "发送的",
          )
          ..onBeginContact = (other, contact) {
            if (!contact.isSensorEvent &&
                archery.body.linearVelocity.length > 1) {
              //音效
              if (other is ArcheryTarget) {
                $gameAssets.playImpactBucketEffect();
              } else if (other is Wall) {
                $gameAssets.playImpactEffect();
              }
            }
          };
    // 添加球到世界
    await target.add(archery);
    // 给球一个初始速度
    final controller = archeryController;
    final impulse = controller.getBallImpulse(ct.start!, ct.end!);
    archery.onStoppedAction = (value) {
      controller.didBallStopped(value);
    };
    archery.body.applyLinearImpulseEx(
      impulse,
      /*point: archery.bodyPosition,*/
      wake: false,
    );
    if (collectHistoryTrajectories) {
      trajectories.add(ct);
    }
    currentTrajectory = null;
    //--
    controller.didLaunchBall(archery);
  }
}

/// 箭
class Archery extends TrajectoryBall {
  /// 箭的宽度
  double width = 0;

  /// 箭的高度
  double height = 0;

  Archery({
    super.tag = "箭",
    super.enableContactEvents = true,
    super.enableSensorEvents = true,
    super.isEnabled = true,
    super.isSensor = false,
    super.renderCurrentTrajectory = false,
    super.position,
    super.rotation,
    super.linearVelocity,
    super.angularVelocity,
    super.alwaysRenderBody = false,
    super.bodyType = .dynamic,
    super.density = 1,
    this.width = 0,
    this.height = 0,
  });

  @override
  FShapeGeometry? createBallGeometry(FBody body) {
    //final points = generateArrowPoints(width: width, height: height);
    //body.createSegmentGeometry([...points, points.first]);
    /*//每5个点创建一个多边形
    final c = 3;
    for (var i = 0; i < points.length; i += c) {
      final polygonPoints = points.sublist(
        (i).maxOf(0),
        (i + c).minOf(points.length),
      );
      if (polygonPoints.length > 2) {
        body.createPolygonGeometry([...polygonPoints]);
      }
    }*/
    body.createShape(FPolygon.box(width / 2, height / 2));
    return null;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    renderArrow(canvas);
  }

  /// 箭的绘制
  @fb.overridePoint
  void renderArrow(Canvas canvas) {
    final points = generateArrowPoints(
      width: width,
      height: height,
      maxTailWidth: height / 4,
      maxHeadWidth: height / 4,
      headLength: height * 2,
      tailLength: height,
    );
    canvas.drawPoints(
      .polygon,
      [...points, points.first].map((e) => e.toOffset()).toList(),
      paint,
    );
  }

  /// 是否已经碰撞过
  bool _hasCollided = false;

  @override
  void beginContact(Object other, FContact contact) {
    if (_hasCollided) {
      return;
    }
    super.beginContact(other, contact);
    if (other is ArcheryTarget && !contact.isSensorEvent) {
      //箭击中了靶, 则立即停止
      _hasCollided = true;
      archeryController.innerScore++;
      body.stopBody(enable: false);
    } else if (other is Wall && !contact.isSensorEvent) {
      final archery =
          Archery(
              isSensor: true,
              bodyType: .kinematic,
              position: body.position,
              rotation: body.rotation,
              linearVelocity: Vector2(
                body.linearVelocity.x,
                body.linearVelocity.y * 4,
              ),
              angularVelocity: body.angularVelocity,
            )
            ..width = width
            ..height = height
            ..add(RemoveEffect(delay: 3));
      removeFromParent();
      world.add(archery);
      /*isSensor = true;
      enableContactEvents = false;
      enableSensorEvents = false;
      bodyPosition = body.position;
      reloadBody();*/
    }
  }
}

/// 靶
class ArcheryTarget extends FBodyComponent {
  ArcheryTarget({super.tag = "靶", super.position, super.debugLabel = "靶"});

  Vector2? _archeryTargetCenter;

  @override
  FShapeGeometry? createGeometry(FBody body, FShapeDef shapeDef) {
    final controller = archeryController;
    final bounds = worldVisibleRect;
    final w = controller.config.archeryTargetWidth;
    final h = controller.config.archeryTargetHeight;
    final offsetX = controller.config.archeryTargetOffset.x;
    final offsetY = controller.config.archeryTargetOffset.y;
    final center = Vector2(
      bounds.right - w / 2 + offsetX,
      bounds.bottom / 2 + offsetY,
    );
    _archeryTargetCenter = center;
    final points = generateEllipsePoints(
      center: center,
      rx: w / 2,
      ry: h / 2,
      segments: 90,
    );
    //每8个点创建一个多边形
    final c = 4;
    for (var i = 0; i < points.length; i += c) {
      final polygonPoints = points.sublist(
        (i - 2).maxOf(0),
        (i + c).minOf(points.length),
      );
      if (polygonPoints.length > 2) {
        body.createShape(FPolygon([...polygonPoints, center]), shapeDef);
      }
    }
    body.createShape(
      FPolygon([points[1], points[points.lastIndex - 1], center]),
      shapeDef,
    );
    return null;
  }

  final List<Color> colors = const [
    Color(0xFF222222),
    Color(0xFFFFFFFF),
    Color(0xFF1976D2),
    Color(0xFFD32F2F),
    Color(0xFFFFEB3B),
  ];

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()
      ..color = Colors.black
      ..style = .stroke;
    final step = archeryController.config.archeryTargetCircleGap;
    double w = archeryController.config.archeryTargetWidth;
    double h = archeryController.config.archeryTargetHeight;
    while (w > 0 && h > 0) {
      canvas.drawPath(
        Path()..addOval(
          Rect.fromLTWH(
            _archeryTargetCenter!.x - w / 2,
            _archeryTargetCenter!.y - h / 2,
            w,
            h,
          ),
        ),
        paint,
      );
      w -= step;
      h -= step;
    }
  }
}

class ArcheryHudComponent extends GameHudComponent {
  @override
  Future<Iterable<Component>?> loadControlComponent() async {
    final parent = findParent<ArcheryGame>();
    return [
      if (parent != null)
        SpriteComponent(
          sprite: $gameAssets.gameIcons.returnSprite,
          scale: Vector2(-1, 1),
        ).button(() {
          // 移除所有球
          parent.world.removeAllChildren((e) => e is Archery);
        }),
      ...?(await super.loadControlComponent()),
    ];
  }
}

/// 扩展
extension _ComponentEx on Component {
  ArcheryGameController get archeryController =>
      findGameController<ArcheryGameController>()!;
}
