import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter3_app/flutter3_app.dart' as f3;
import 'package:flutter3_flame/flutter3_flame.dart';

import '../../flutter3_abc.dart';
import 'flame_base_page.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/17
///
/// Flame 视差
///
/// https://docs.flame-engine.org/latest/flame/components/parallax_component.html
class FlameParallaxPage extends StatefulWidget {
  const FlameParallaxPage({super.key});

  @override
  State<FlameParallaxPage> createState() => _FlameParallaxPageState();
}

class _FlameParallaxPageState extends State<FlameParallaxPage>
    with BaseAbcStateMixin {
  @override
  f3.WidgetList buildBodyList(BuildContext context) {
    return [
      GameWidget(game: ParallaxGame()).size(height: 400),
      GameWidget(game: FlameGame(world: ParallaxWorld())).size(height: 400),
    ];
  }
}

//MARK: - Component

extension _ParallaxComponentEx on Component {
  /// demo
  Future initParallaxComponent() async {
    //--parallax
    final parallaxComponent = await findGame()?.loadParallaxComponent(
      [
        ParallaxImageData('parallax/bg.png'),
        ParallaxImageData('parallax/trees.png'),
      ],
      package: Assets.package,
      baseVelocity: Vector2(20, 0),
      velocityMultiplierDelta: Vector2(2 /*1.8*/, 1.0),
      filterQuality: FilterQuality.none,
    );
    if (parallaxComponent != null) {
      add(parallaxComponent);
    }

    //--base
    add(OriginCrossComponent());
    add(GameSizeTipComponent());
  }
}

//MARK: - Game

class ParallaxGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    await initParallaxComponent();
  }
}

//MARK: - World

class ParallaxWorld extends World with HasGameReference, TapCallbacks {
  @override
  FutureOr<void> onLoad() async {
    await initParallaxComponent();
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawColor(Colors.grey, .src);
    super.render(canvas);
  }

  ///
  @override
  void renderTree(Canvas canvas) {
    super.renderTree(canvas);
  }

  //--Tap
  @override
  void onTapDown(TapDownEvent event) {
    if (game.paused) {
      game.resumeEngine();
    } else {
      game.pauseEngine();
    }
    super.onTapDown(event);
  }
}
