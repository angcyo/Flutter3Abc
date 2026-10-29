import 'dart:async';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_games/src/games/pinball/pinball_game_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter3_basics/flutter3_basics.dart' as fb;
import 'package:flutter3_flame/flutter3_flame.dart' hide Circle;

import '../../assets/game_assets.dart';
import '../ball/throw_ball_game_config.dart';
import '../ball/trajectory_ball.dart';
import '../base_game_mixin.dart';
import '../game_hud_component.dart';
import 'pinball_game_controller.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/28
///
/// 弹球乐游戏
class PinballGameScreen extends StatefulWidget with fb.TranslationTypeMixin {
  final PinballGameConfig config;

  @override
  fb.TranslationType get translationType => .none;

  const PinballGameScreen({required this.config, super.key});

  @override
  State<PinballGameScreen> createState() => _PinballGameScreenState();
}

class _PinballGameScreenState extends State<PinballGameScreen>
    with BaseGameStateMixin {
  @override
  Game buildGame() => PinballGame(world: PinballWorld(), config: widget.config);
}
//MARK: - Game

class PinballGame extends BaseForge2DGame {
  final PinballGameConfig config;

  PinballGame({
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
    super.onReloadGame(size);
    clearGameChildren();
    //添加游戏墙体
    addBoundariesWall(this);
  }
}

//MARK: - World

class PinballWorld extends BaseForge2DWorld with HasGameReference<PinballGame> {
  @override
  void onReloadWorld(Vector2 size) {
    super.onReloadWorld(size);
    removeAllChildren();
    /*add(PinballBoardComponent()..size = size);*/
    final playerCount = game.config.playerCount;
    final w = size.x / playerCount * pixelsScale;
    final h = size.y * pixelsScale;
    for (var i = 1; i <= playerCount; i++) {
      add(
        PinballBoardComponent(
          index: i,
          bounds: Rect.fromLTWH(w * (i - 1), 0, w, h),
        )..size = Vector2(size.x * pixelsScale, size.y * pixelsScale),
      );
    }
    /*add(
      SplitLayout(
        positionScale: Vector2.all(pixelsScale),
        sizeScale: Vector2.all(pixelsScale),
        children: [
          for (var i = 1; i <= game.config.playerCount; i++)
            PinballBoardComponent(index: i),
        ],
      ),
    );*/
  }
}

/// 弹球乐游戏板
/// - 包含游戏面板
/// - hud
class PinballBoardComponent extends PositionComponent
    with HasGameReference<PinballGame>, TapCallbacks, DragCallbacks {
  PinballGameController controller = PinballGameController();
  int index = 0;

  /// 多个玩家时操作的边界
  Rect bounds = Rect.zero;

  PinballBoardComponent({this.index = 0, Rect? bounds})
    : bounds = bounds ?? Rect.zero;

  /// 发射器
  final _pinballEmitter = PinballEmitter();

  @override
  FutureOr<void> onLoad() {
    controller.config = game.config;
    add(_pinballEmitter..radius = game.config.ballRadius);
    add(PinballBoardBody()..bounds = bounds);
    add(PinballHudComponent()..position = bounds.topLeft.toVector2());
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    /*if (index > 1) {
      canvas.drawRect(
        worldRect.inflate(0),
        Paint()
          ..color = Colors.red
          ..strokeWidth = 0.1
          ..style = .stroke,
      );
    }*/
    /*final points = generateArcPoints(
      start: worldRect.center.toVector2(),
      center: worldRect.center.toVector2() + Vector2(2, 1),
      sweepAngle: -45.hd,
    );
    canvas.drawPoints(
      .polygon,
      points.map((e) => e.toOffset()).toList(),
      Paint()..color = Colors.blueGrey,
    );*/
    super.render(canvas);
  }

  //MARK: event

  /// 手指按下
  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    event.continuePropagation = true;
    if (controller.launchAreaBounds.contains(event.localPosition.toOffset()) ==
        true /*||
        isDebugMode*/ ) {
      event.handled = true;
      _pinballEmitter.ballDownPosition(event.localPosition);
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    if (!isDragged) {
      _pinballEmitter.cancelLaunch();
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
    event.continuePropagation = true;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    _pinballEmitter.ballMoveToPosition(event.localEndPosition);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    _pinballEmitter.launchBall();
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    super.onDragCancel(event);
    _pinballEmitter.cancelLaunch();
  }
}

/// 物理实体
class PinballBoardBody extends FBodyComponent<PinballGame> {
  /// 多个玩家时左上的偏移
  Rect bounds = Rect.zero;

  @override
  Future<void> onLoad() {
    //
    return super.onLoad();
  }

  @override
  FBody createBody() {
    final config = game.config;
    //在这个边界中创建游戏刚体
    final bounds = this.bounds;
    final isMinScreen = bounds.height < 5; // 是否是小屏幕
    final archRadius = config.boardArchRadius; // 顶部弧形半径, 在高度范围内
    final center = Vector2(
      bounds.x + bounds.width / 2,
      bounds.y +
          bounds.height / 2 +
          (isMinScreen ? archRadius / 2 : archRadius),
    );
    final maxHeight = fb.minOf(bounds.height * 3 / 4, config.boardHeight);
    final maxWidth = maxHeight * 3 / 4;
    config.boardHeight = maxHeight;
    config.boardWidth = maxWidth;

    final launchAreaWidth = config.ballRadius * 2 + 0.05; //发射区的宽度, 在宽度范围内
    final wardSize = config.boardWardSize; // 挡板的大小

    final left = center.x - maxWidth / 2;
    final top = center.y - maxHeight / 2;
    final right = center.x + maxWidth / 2;
    final bottom = center.y + maxHeight / 2;

    final body = worldCreateBody();
    //外轮廓几何形状
    final outlinePoints = <Vector2>[
      Vector2(left, bottom),
      Vector2(right, bottom),
      Vector2(right, top + archRadius),
      ...generateArcPoints(
        start: Vector2(right, top + archRadius),
        center: Vector2(center.x, top + archRadius),
        sweepAngle: -180.hd,
        segments: 180,
      ),
      Vector2(left, bottom),
    ];
    body.createSegmentGeometry(outlinePoints /*friction: 0, restitution: 1*/);

    //发射区的几何形状
    final launchAreaBounds = Rect.fromLTWH(
      right - launchAreaWidth,
      top + archRadius + archRadius / 2,
      launchAreaWidth,
      bottom - (top + archRadius + archRadius / 2),
    );
    final launchAreaPoints = <Vector2>[
      Vector2(launchAreaBounds.left, launchAreaBounds.bottom),
      Vector2(launchAreaBounds.left, launchAreaBounds.top),
      ...generateArcPoints(
        start: Vector2(launchAreaBounds.left, launchAreaBounds.top),
        center: Vector2(
          center.x /*- launchAreaWidth*/,
          launchAreaBounds.top /*+ launchAreaWidth*/,
        ),
        sweepAngle: -25.hd,
        segments: 20,
      ),
    ];
    body.createSegmentGeometry(
      launchAreaPoints /*friction: 0, restitution: 1*/,
    );
    findGameController<PinballGameController>()?.launchAreaBounds =
        launchAreaBounds;

    //创建顶部2个挡板
    body.createSegmentGeometry([
      Vector2(left, top + archRadius),
      Vector2(left + wardSize, top + archRadius + wardSize / 2),
    ]);

    //创建中间障碍点
    final controller = findGameController<PinballGameController>();
    if (controller != null) {
      for (final obstacleInfo in controller.createObstaclePoints(
        left: left,
        right: launchAreaBounds.left,
        top: launchAreaBounds.top - wardSize,
        bottom: bottom,
        isMinScreen: isMinScreen,
      )) {
        final isScoringBucket = obstacleInfo.type == .bottom;
        //debugger(when: isScoringBucket);
        add(
          isScoringBucket
              ? ScoringBucket(obstacleInfo: obstacleInfo)
              : ObstacleCircle(obstacleInfo: obstacleInfo),
        );
      }
    }

    return body;
  }

  ///
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    /*canvas.drawRect(
      bodySize.toRect().inflate(0),
      Paint()
        ..color = Colors.red
        ..strokeWidth = 0.1
        ..style = .stroke,
    );*/
  }
}

/// 障碍物(中间的圆)
class ObstacleCircle extends FBodyComponent<PinballGame> {
  final ObstacleInfo obstacleInfo;

  ObstacleCircle({
    super.tag = "障碍物",
    super.position,
    super.color = Colors.grey,
    super.material,
    required this.obstacleInfo,
  }) {
    bodyPosition = obstacleInfo.position;
  }

  @override
  ShapeGeometry? createGeometry(Body body) =>
      Circle(radius: obstacleInfo.size.x);
}

/// 得分收集桶
class ScoringBucket extends FBodyComponent<PinballGame> {
  final ObstacleInfo obstacleInfo;

  ScoringBucket({
    super.tag = "得分收集桶",
    /*super.debugLabel = "得分收集桶",*/
    super.position,
    super.color = Colors.white,
    super.material,
    required this.obstacleInfo,
  }) {
    bodyPosition = obstacleInfo.position;
  }

  @override
  ShapeGeometry? createGeometry(Body body) {
    final w = obstacleInfo.size.x;
    final h = obstacleInfo.size.y;
    if (obstacleInfo.type == .bottom && w > 0 && h > 0) {
      //感应区域
      final controller = findGameController<PinballGameController>();
      double margin = controller?.config?.obstacleBallRadius ?? 0.02;
      body.createShape(
        FPolygon([
          Vector2(0 + margin, 0),
          Vector2(0 + margin, h),
          Vector2(w - margin, h),
          Vector2(w - margin, 0),
        ]),
        ShapeDef(
          isSensor: true,
          enableContactEvents: false,
          enableSensorEvents: obstacleInfo.isScoringPoint,
          density: density,
        ),
      );
      //U 形
      margin = 0;
      body.createSegmentGeometry(
        [
          Vector2(0 + margin, 0),
          Vector2(0 + margin, h),
          Vector2(w - margin, h),
          /*Vector2(w - margin, 0),*/
        ],
        shapeDef: ShapeDef(
          material: SurfaceMaterial(friction: 0, restitution: 0.2),
          enableContactEvents: false,
          enableSensorEvents: false,
          density: density,
        ),
      );
    }
    return null;
  }

  ///
  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void renderShape(Canvas canvas, FShape shape) {
    if (shape.geometry is FPolygon) {
      if (shape.isSensor && shape.sensorEventsEnabled) {
        final color = paint.color;
        paint.color = Colors.redAccent.withAlpha(60);
        super.renderShape(canvas, shape);
        paint.color = color;
      }
    } else {
      super.renderShape(canvas, shape);
    }
  }

  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);
    if (other is Ball) {
      /*if (isDebugMode && contact.isSensorEvent) {
        final controller = findGameController<PinballGameController>();
        controller?.innerScore++;
        fb.l.i(
          "[${classHash()}][${controller?.classHash()}]->${controller?.innerScore} ${contact.isSensorEvent}",
        );
      }*/

      if (obstacleInfo.isScoringPoint && contact.isSensorEvent) {
        final controller = findGameController<PinballGameController>();
        controller?.innerScore++;
      }
    }
  }

  @override
  void endContact(Object other, Contact contact) {
    super.endContact(other, contact);
    if (other is Ball) {
      /*if (isDebugMode && contact.isSensorEvent) {
        final controller = findGameController<PinballGameController>();
        controller?.innerScore++;
      }*/

      if (obstacleInfo.isScoringPoint && contact.isSensorEvent) {
        final controller = findGameController<PinballGameController>();
        controller?.innerScore--;
      }
    }
  }
}

/// 发射器
class PinballEmitter extends TrajectoryBall {
  PinballEmitter({
    super.tag = "发射器",
    super.density = 2,
    super.restitution = 0.6,
    super.collectHistoryTrajectories = false,
  });

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    //canvas.drawColor(Colors.redAccent, .src);
    final controller = findGameController<PinballGameController>();
    if (controller != null) {
      if (!controller.canLaunchNext /*|| isDebugMode*/ ) {
        canvas.drawRect(
          Rect.fromLTWH(
            controller.launchAreaBounds.left - position.x,
            controller.launchAreaBounds.top - position.y,
            controller.launchAreaBounds.width,
            controller.launchAreaBounds.height,
          ),
          Paint()
            ..color = Colors.grey.withAlpha(60)
            ..style = .fill,
        );
      }
    }
  }

  /// 投手按下的位置
  @override
  void ballDownPosition(Vector2 position) {
    final controller = findGameController<PinballGameController>();
    if (controller == null || !controller.canLaunchNext) {
      return;
    }
    final pos = Vector2(controller.launchAreaBounds.centerX, position.y);
    currentTrajectory = BallTrajectory()..startWith(pos);
    body.setTransform(pos, body.rotation);
  }

  /// 移动到指定位置
  @override
  void ballMoveToPosition(Vector2 position) {
    final controller = findGameController<PinballGameController>();
    if (controller == null || currentTrajectory == null) {
      return;
    }
    final pos = Vector2(
      controller.launchAreaBounds.centerX,
      fb.clamp(
        position.y,
        currentTrajectory!.start!.y,
        controller.launchAreaBounds.bottom,
      ),
    );
    currentTrajectory?.endWith(pos);
    body.setTransform(pos, body.rotation);
  }
}

class PinballHudComponent extends GameHudComponent {
  @override
  Future<Iterable<Component>?> loadControlComponent() async {
    final parent = findParent<PinballBoardComponent>();
    return [
      if ( /*isDebugMode &&*/ parent != null)
        SpriteComponent(
          sprite: $gameAssets.gameIcons.returnSprite,
          scale: Vector2(-1, 1),
        ).button(() {
          // 移除所有球
          findGame()?.world.removeAllChildren((e) => e is Ball && e is! PinballEmitter);
          //重新加载刚体
          parent.findChild<PinballBoardBody>((e) => e is PinballBoardBody)
            ?..removeAllChildren()
            ..reloadBody();
          parent.controller.isLaunchBallStopped = true;
        }),
      if ((parent?.index ?? 0) <= 1) ...?(await super.loadControlComponent()),
    ];
  }
}
