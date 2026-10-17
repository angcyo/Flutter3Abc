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
/// # Flame 粒子系统
///
/// ## 内置粒子
/// Flame 自带一些内置的 Particle 行为：
///
/// - 将其 [TranslatedParticle] 按给定的 child 进行平移Vector2
/// - [MovingParticle] 将其 child 在两个预定义的 Vector2 之间移动，支持 Curve
/// - [AcceleratedParticle] 允许实现基于基本物理的效果，例如引力或速度衰减。
/// - [CircleParticle] 可以渲染各种形状和大小的圆。
/// - [SpriteParticle] 会在 Particle 效果中渲染火焰 Sprite 。
/// - [ImageParticle] 在 Particle 效果中渲染 dart:ui Image
/// - [ComponentParticle] 在 Particle 效果中渲染火焰 Component
/// - [FlareParticle] 函数在 Particle 效果中渲染耀斑动画。
///
/// https://docs.flame-engine.org/latest/flame/rendering/particles.html
class FlameParticlePage extends StatefulWidget {
  const FlameParticlePage({super.key});

  @override
  State<FlameParticlePage> createState() => _FlameParticlePageState();
}

class _FlameParticlePageState extends State<FlameParticlePage>
    with BaseAbcStateMixin {
  @override
  f3.WidgetList buildBodyList(BuildContext context) {
    return [
      GameWidget(game: FlameGame(world: ParticleWorld())).size(height: 400),
      GameWidget(game: FlameGame(world: ParticleWorld2())).size(height: 400),
    ];
  }
}

//MARK: - World

class ParticleWorld extends World {
  @override
  FutureOr<void> onLoad() {
    add(
      ParticleSystemComponent(
        particle: CircleParticle(
          paint: Paint()..color = Colors.purple,
          lifespan: 3,
        ),
      ),
    );
    add(
      ParticleSystemComponent(
        particle: Particle.generate(
          count: 100,
          lifespan: 2,
          generator: (i) => AcceleratedParticle(
            acceleration: randomVector2(),
            child: CircleParticle(paint: Paint()..color = Colors.red),
          ),
        ),
      ),
    );
    return super.onLoad();
  }
}

class ParticleWorld2 extends World {
  @override
  FutureOr<void> onLoad() async {
    final sprite = await loadAbcSprite('player.png');
    add(
      ParticleSystemComponent(
        particle: Particle.generate(
          count: 100,
          lifespan: 2,
          generator: (i) => AcceleratedParticle(
            acceleration: randomVector2(),
            child: SpriteParticle(sprite: sprite),
          ),
        ),
      ),
    );
    return super.onLoad();
  }
}
