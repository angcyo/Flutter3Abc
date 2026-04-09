import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter3_basics/flutter3_basics.dart' hide Vector2;
import 'package:flutter3_flame/flutter3_flame.dart';

import '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/04/03
///
class FlameAbc extends StatefulWidget {
  const FlameAbc({super.key});

  @override
  State<FlameAbc> createState() => _FlameAbcState();
}

class _FlameAbcState extends State<FlameAbc> with BaseAbcStateMixin {
  @override
  void initState() {
    Flame.images.prefix = "assets/flame/";
    super.initState();
  }

  @override
  WidgetList buildBodyList(BuildContext context) {
    //return [GameWidget(game: FlameGame()).size(height: $screenHeight / 2)];
    return [
      createGameWorld(FlameAbcWorld()).size(height: 100).bounds(),
      createGameWorld(
        FlameAbcWorld(),
        debugMode: kDebugMode,
      ).size(height: $screenHeight / 2).bounds(),
      createGameWorld(
        null,
        game: FlameAbcGame(),
      ).size(height: $screenHeight / 2).bounds(),
    ];
  }
}

/// - [FlameGame]
/// - [SingleGameInstance]
/// - [HasTimeScale]
/// - [HasPerformanceTracker]
class FlameAbcGame extends FlameGame with HasCollisionDetection {
  FlameAbcGame() {
    world = FlameAbcWorld();
    pauseWhenBackgrounded;
  }

  @override
  FutureOr<void> onLoad() {
    add(ScreenHitbox());
    final paint = BasicPalette.gray.paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    add(
      CircleComponent(
        position: canvasSize / 2,
        radius: 30,
        paint: paint,
        children: [CircleHitbox()],
      ),
    );
    //--
    add(
      /*ParticleSystemComponent(
        particle: CircleParticle(paint: Paint()..color = Colors.white),
      ),*/
      ParticleSystemComponent(
        position: canvasSize / 2,
        particle: Particle.generate(
          count: 1000,
          lifespan: 10,
          generator: (i) => AcceleratedParticle(
            acceleration: randomVector2(),
            child: CircleParticle(
              paint: Paint()..color = Colors.red.withAlpha(100),
            ),
          ),
        ),
      ),
    );
    return super.onLoad();
  }

  //MARK: - *

  ///
  @override
  bool get debugMode => super.debugMode;

  ///
  @override
  Color backgroundColor() {
    return super.backgroundColor();
  }

  //MARK: - *

  final TextPaint textPaint = TextPaint(
    style: const TextStyle(color: Colors.white, fontSize: 20),
  );

  final countdown = Timer(2);

  //MARK: - *

  final origin = Vector2(20, 20);
  RaycastResult<ShapeHitbox>? result;
  Paint paint = Paint()..color = Colors.red.withValues(alpha: 0.6);
  final velocity = 60;

  double get resetPosition => -canvasSize.y;

  //MARK: - *

  Vector2 randomVector2() => (Vector2.random(rnd) - Vector2.random(rnd)) * 200;

  @override
  void update(double dt) {
    super.update(dt);
    //--
    countdown.update(dt);
    if (countdown.finished) {
      // Prefer the timer callback, but this is better in some cases
    }
    //--https://docs.flame-engine.org/latest/flame/collision_detection.html
    final ray = Ray2(origin: origin, direction: Vector2(1, 0));
    result = collisionDetection.raycast(ray);
    origin.y += velocity * dt;

    if (origin.y > canvasSize.y) {
      origin.y += resetPosition;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    textPaint.render(
      canvas,
      "Countdown: ${countdown.current.toString()}",
      Vector2(10, 100),
    );
    //--
    if (result != null && result!.isActive) {
      final originOffset = origin.toOffset();
      final intersectionPoint = result!.intersectionPoint!.toOffset();
      if ((intersectionPoint.y - originOffset.y).abs() < 10) {
        canvas.drawLine(originOffset, intersectionPoint, paint);
      }

      canvas.drawCircle(originOffset, 10, paint);
    }
  }
}

/// - [ComponentPool]
class FlameAbcWorld extends World with TapCallbacks {
  @override
  Future<void> onLoad() async {
    add(Player(position: Vector2(0, 0)));
    //add(FpsComponent());
    add(FpsTextComponent(position: Vector2(0, -150)));
    add(
      ChildCounterComponent<PositionComponent>(
        target: this,
        position: Vector2(200, -180),
      ),
    );
    add(
      ChildCounterComponent<Effect>(target: this, position: Vector2(200, -160)),
    );
    add(TimeTrackComponent());

    /*add(Square(Vector2.zero()));
    add(Square(Vector2(100, 100)));
    add(Square(Vector2(-100, -100)));*/

    add(
      ParticleSystemComponent(
        particle: CircleParticle(
          radius: 10,
          paint: Paint()..color = Colors.red.withValues(alpha: .5),
        ),
      ),
    );
  }

  /// [FlameGame.dispose]
  @override
  void onHotReload() {
    //findGame()?.dispose();
    super.onHotReload();
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    //debugger();
    if (!event.handled) {
      final touchPoint = event.localPosition;
      add(Square(touchPoint));
    }
  }
}

class Player extends SpriteComponent with TapCallbacks {
  Player({super.position, super.anchor = Anchor.center})
    : super(size: Vector2.all(40));

  @override
  Future<void> onLoad() async {
    //packages/flutter3_abc/assets/images/player.png
    sprite = await Sprite.load('player.png', package: Assets.package);

    add(ChildCounterComponent<Effect>(target: this));
    final effect = GlowEffect(10.0, EffectController(duration: 3));
    //add(effect);
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (isCtrlPressed) {
      //size -= Vector2.all(50);
      final effect = ScaleEffect.by(
        Vector2.all(0.5),
        EffectController(duration: 0.5),
      );
      add(effect);
    } else {
      //size += Vector2.all(50);
      final effect = ScaleEffect.by(
        Vector2.all(1.5),
        EffectController(duration: 0.5),
      );
      add(effect);
    }
  }

  /// 绘制
  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }
}

class Square extends RectangleComponent with TapCallbacks {
  static const speed = 3;
  static const squareSize = 128.0;
  static const indicatorSize = 6.0;

  static final Paint red = BasicPalette.red.paint();
  static final Paint blue = BasicPalette.blue.paint();

  Square(Vector2 position)
    : super(
        position: position,
        size: Vector2.all(squareSize),
        anchor: Anchor.center,
      );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    //debugger();
    add(RectangleComponent(size: Vector2.all(indicatorSize), paint: blue));
    add(
      RectangleComponent(
        position: size / 2,
        size: Vector2.all(indicatorSize),
        anchor: Anchor.center,
        paint: red,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    //debugger();
    l.v("delta:$dt");
    angle += speed * dt;
    angle %= 2 * math.pi;
  }

  @override
  void onTapDown(TapDownEvent event) {
    //debugger();
    removeFromParent();
    event.handled = true;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }
}
