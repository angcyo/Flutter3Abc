import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter3_app/flutter3_app.dart' as f3;
import 'package:flutter3_flame/flutter3_flame.dart';

import '../../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/26
///
/// Flame forge2d测试
class FlameForge2dPage extends StatefulWidget {
  const FlameForge2dPage({super.key});

  @override
  State<FlameForge2dPage> createState() => _FlameForge2dPageState();
}

class _FlameForge2dPageState extends State<FlameForge2dPage>
    with BaseAbcStateMixin {
  @override
  f3.WidgetList buildBodyList(BuildContext context) {
    return [
      GameWidget(
        game: FlameForge2dGame(
          world: FlameForge2dWord(),
          gravity: Vector2(0, 0.1),
        ),
      ).size(height: 800),
    ];
  }
}

//MARK: - Game

///
class FlameForge2dGame extends Forge2DGame {
  FlameForge2dGame({
    super.world,
    super.gravity,
    super.lengthUnitsPerMeter,
    super.metersToPixels = 100, //Forge2DViewfinder.defaultMetersToPixels
  });

  /// 游戏背景颜色
  @override
  Color backgroundColor() {
    return super.backgroundColor();
  }

  @override
  Future<void> onLoad() {
    /*final ball = createBodyComponent();
    add(ball);*/
    addBoundariesWall(
      this,
      marginLeft: 1,
      marginTop: 0.5,
      marginRight: 1,
      marginBottom: 0.5,
      strokeWidth: 0.1,
    );
    return super.onLoad();
  }
}

class FlameForge2dWord extends Forge2DWorld with TapCallbacks {
  @override
  FutureOr<void> onLoad() {
    //final ball = createBodyComponent();
    add(createBodyComponent());
    add(createBodyComponent(position: Vector2(0.1, 0.1)));
    add(Ball(position: Vector2(0.1, 0.1)));
    add(TappableBall(position: Vector2(0.2, -0.2), color: f3.randomColor()));
    add(
      Bucket(position: Vector2(0.5, 2), color: Colors.blueAccent, angle: -0.3)
        ..debugMode = true,
    );
    add(SensorComponent(size: Vector2(2, 2)));
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    add(TappableBall(position: event.localPosition, color: f3.randomColor()));
  }
}

/// 可点击的球
class TappableBall extends Ball with TapCallbacks {
  TappableBall({super.position, super.color});

  @override
  void onTapDown(TapDownEvent event) {
    body.applyLinearImpulseEx(Vector2.random() / 5, point: Vector2(0, 0));
  }
}

/// 传感器组件测试
class SensorComponent extends BodyComponent with FContactCallbacks {
  final Vector2 bodyPosition;
  final Vector2 size;

  SensorComponent({
    Vector2? position,
    required this.size,
    super.renderBody = true,
    super.priority,
  }) : bodyPosition = position ?? Vector2.zero() {
    paint.color = Colors.white10;
  }

  @override
  FBody createBody() {
    final sensorBody = world.createBody(
      FBodyDef(position: bodyPosition, userData: this),
    );
    final shapeDef = FShapeDef(
      isSensor: true,
      enableContactEvents: false,
      enableSensorEvents: true,
    );
    return sensorBody
      ..createShape(FPolygon.box(size.x / 2, size.y / 2), shapeDef);
  }

  @override
  void beginContact(Object other, FContact contact) {
    final isSensor1 = contact.shapeA.isSensor;
    final isSensor2 = contact.shapeB.isSensor;
    final isSensorEvent = contact.isSensorEvent;
    final userDatas = contact.userDatas;
    assert(() {
      f3.l.i(
        'beginContact isSensor1: $isSensor1 isSensor2: $isSensor2 isSensorEvent: $isSensorEvent '
        'this:$this other:$other',
      );
      return true;
    }());
  }
}
