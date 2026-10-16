import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter3_app/flutter3_app.dart' as f3;
import 'package:flutter3_flame/flutter3_flame.dart';

import '../../flutter3_abc.dart';
import 'flame_base_page.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/16
///
/// Flame 精灵
class FlameSpritePage extends StatefulWidget {
  const FlameSpritePage({super.key});

  @override
  State<FlameSpritePage> createState() => _FlameSpritePageState();
}

class _FlameSpritePageState extends State<FlameSpritePage>
    with BaseAbcStateMixin {
  @override
  f3.WidgetList buildBodyList(BuildContext context) {
    return [
      GameWidget(game: FlameGame(world: SpriteWorld())).size(height: 400),
    ];
  }
}

//MARK: - World

/// - [Sprite] 精灵组件
/// - [SpriteComponent] 精灵组件, 渲染[Sprite]
/// - [SpriteAnimationComponent] 精灵动画组件, 渲染[SpriteAnimation]
/// - [SpriteAnimationGroupComponent] 精灵动画组组件, 渲染一组[SpriteAnimation]
class SpriteWorld extends World with HasGameReference {
  @override
  FutureOr<void> onLoad() async {
    // Base
    add(OriginCrossComponent());
    add(BaseTextComponent());

    // FPS
    add(FpsTextComponent()..position = Vector2(10, 10));

    final chopper = await loadAbcSpriteAnimation(
      SpriteState.chopper.path,
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.15,
        textureSize: Vector2(48, 48),
      ),
    );
    add(SpriteAnimationComponent(animation: chopper)..position = Vector2(0, 0));

    final creature = await loadAbcSpriteAnimation(
      SpriteState.creature.path,
      SpriteAnimationData.sequenced(
        amount: 18,
        amountPerRow: 10,
        stepTime: 0.15,
        textureSize: Vector2(291, 178),
        loop: false,
      ),
    );
    add(
      SpriteAnimationComponent(animation: creature)..position = Vector2(48, 0),
      /*..debugMode = true,*/
    );

    final ember = await loadAbcSpriteAnimation(
      SpriteState.ember.path,
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.12,
        textureSize: Vector2(16, 16),
      ),
    );
    add(
      SpriteAnimationComponent(animation: ember)
        ..position = Vector2(48 + 291, 0),
    );

    final robot = await loadAbcSpriteAnimation(
      SpriteState.robot.path,
      SpriteAnimationData.sequenced(
        amount: 8,
        stepTime: 0.2,
        textureSize: Vector2(16, 18),
      ),
    );
    add(
      SpriteAnimationComponent(animation: robot)
        ..position = Vector2(48 + 291 + 16, 0),
    );

    final robotIdle = await loadAbcSpriteAnimation(
      SpriteState.robotIdle.path,
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.4,
        textureSize: Vector2(16, 18),
      ),
    );
    add(
      SpriteAnimationComponent(animation: robotIdle)
        ..position = Vector2(48 + 291 + 16 + 16, 0),
    );

    //Group
    final functionEffect =
        FunctionEffect<SpriteAnimationGroupComponent<SpriteState>>(
          (target, progress) {
            target.scale = Vector2.all((1 - progress) * 4);
            final length = target.animations?.length ?? 1;
            if (progress > (length - 1) / length) {
              target.current = SpriteState.robotIdle;
            } else if (progress > (length - 2) / length) {
              target.current = SpriteState.robot;
            } else if (progress > (length - 3) / length) {
              target.current = SpriteState.ember;
            } else if (progress > (length - 4) / length) {
              target.current = SpriteState.creature;
            } else {
              target.current = SpriteState.chopper;
            }
          },
          EffectController(
            duration: SpriteState.values.length.toDouble(),
            infinite: true,
          ),
        );
    add(
      SpriteAnimationGroupComponent(
          animations: {
            SpriteState.chopper: chopper,
            SpriteState.creature: creature,
            SpriteState.ember: ember,
            SpriteState.robot: robot,
            SpriteState.robotIdle: robotIdle,
          },
          current: SpriteState.chopper,
          children: [functionEffect],
          angle: 15.hd,
          /*anchor: .center,*/
        )
        /*..position = Vector2(-200, -100)*/
        ..position = game.camera.visibleWorldRect.topLeft.toVector2() / 2
        ..debugMode = true,
    );

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawColor(Colors.grey, .src);
    super.render(canvas);
    canvas.drawRect(
      Rect.fromCenter(
        center: .zero,
        width: game.canvasSize.x,
        height: game.canvasSize.y,
      ).inflate(-10),
      Paint()
        ..color = Colors.purple
        ..style = PaintingStyle.stroke,
    );
  }
}

enum SpriteState {
  chopper("sprites/chopper.png"),
  creature("sprites/creature.png"),
  ember("sprites/ember.png"),
  robot("sprites/robot.png"),
  robotIdle("sprites/robot-idle.png");

  final String path;

  const SpriteState(this.path);
}
