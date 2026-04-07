import 'dart:developer';
import 'dart:math' as math;

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
  WidgetList buildBodyList(BuildContext context) {
    //return [GameWidget(game: FlameGame()).size(height: $screenHeight / 2)];
    return [
      createGameWorld(FlameAbcWorld()).size(height: 100).bounds(),
      createGameWorld(FlameAbcWorld()).size(height: $screenHeight / 2).bounds(),
    ];
  }
}

class FlameAbcWorld extends World with TapCallbacks {
  @override
  Future<void> onLoad() async {
    add(Square(Vector2.zero()));
    add(Square(Vector2(100, 100)));
    add(Square(Vector2(-100, -100)));

    //add(Player(position: Vector2(0, 0)));
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
    debugger();
    removeFromParent();
    event.handled = true;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }
}
