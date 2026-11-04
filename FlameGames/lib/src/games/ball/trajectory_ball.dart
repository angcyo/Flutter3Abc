import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_games/src/games/ball/throw_ball_game_config.dart';
import 'package:flame_games/src/games/base_game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter3_basics/flutter3_basics.dart' as fb;
import 'package:flutter3_flame/flutter3_flame.dart' hide Shape;

import '../../assets/game_assets.dart';
import '../game_hud_component.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/28
///
/// 轨迹球
class TrajectoryBall extends Ball {
  /// 是否收集历史轨迹
  final bool collectHistoryTrajectories;

  /// 历史发送的轨迹
  final List<BallTrajectory> trajectories = [];

  /// 当前投掷轨迹
  BallTrajectory? currentTrajectory;

  /// 是否渲染当前轨迹
  final bool renderCurrentTrajectory;

  /// 是否一直渲染刚体, 否则只在有轨迹时才渲染
  @fb.defInjectMark
  final bool? alwaysRenderBody;

  TrajectoryBall({
    super.bodyType = .static,
    super.color = Colors.blue,
    super.tag = "轨迹球",
    super.enableContactEvents = false,
    super.enableSensorEvents = false,
    super.isEnabled = false,
    super.isSensor = false,
    super.density = 1,
    super.friction = 0.6,
    super.restitution = 0.7,
    super.position,
    super.rotation,
    super.linearVelocity,
    super.angularVelocity,
    this.renderCurrentTrajectory = true,
    this.collectHistoryTrajectories = true,
    this.alwaysRenderBody,
  });

  @override
  Body createBody() {
    //bodyPosition = Vector2(2, 2);
    //bodyPosition.setFrom(Vector2(2, 2));
    return super.createBody();
  }

  @override
  void update(double dt) {
    if (bodyType != .static) {
      super.update(dt);
    }
  }

  @override
  void render(Canvas canvas) {
    //绘制历史轨迹
    for (final trajectory in trajectories) {
      canvas.drawDashedLine(
        (trajectory.start! - position).toOffset(),
        (trajectory.end! - position).toOffset(),
        dashLength: 0.08,
        gapLength: 0.05,
        paint: Paint()..color = Colors.grey,
      );
    }
    if (renderCurrentTrajectory && currentTrajectory != null) {
      canvas.drawLine(
        (currentTrajectory!.start! - position).toOffset(),
        (currentTrajectory!.end! - position).toOffset(),
        Paint()..color = Colors.grey,
      );
    }
    if (alwaysRenderBody == true ||
        (alwaysRenderBody == null && currentTrajectory != null)) {
      //渲染刚体
      super.render(canvas);
    }
  }

  ///
  @override
  void renderShape(Canvas canvas, Shape shape) {
    super.renderShape(canvas, shape);
  }

  @override
  void onRemove() {
    super.onRemove();
    final controller = findGameController<BaseGameController>();
    controller?.didBallStopped(this);
  }

  //--

  /// 投手按下的位置
  void ballDownPosition(Vector2 position) {
    currentTrajectory = BallTrajectory()..startWith(position);
    body.setTransform(position, body.rotation);
  }

  /// 移动到指定位置
  void ballMoveToPosition(Vector2 position) {
    currentTrajectory?.endWith(position);
    body.setTransform(position, body.rotation);
  }

  /// 取消发送
  void cancelLaunch() {
    currentTrajectory = null;
  }

  /// 发送一个球
  Future launchBall() async {
    final ct = currentTrajectory;
    if (ct == null) {
      return;
    }
    final world = this.world;
    final parent = this.parent;
    final startPosition = world != parent ? parent?.componentPosition : null;
    final target = parent ?? world;
    //debugger();
    // 创建一个球
    late Ball ball;
    ball =
        Ball(
            position: ct.end! + (startPosition ?? Vector2.zero()),
            color: originalPaint.color,
            radius: radius,
            density: density,
            friction: friction,
            restitution: restitution,
            tag: "发送",
          )
          ..onBeginContact = (other, contact) {
            if (!contact.isSensorEvent && ball.body.linearVelocity.length > 1) {
              //音效
              if (other is Bucket) {
                $gameAssets.playImpactBucketEffect();
              } else if (other is Wall) {
                $gameAssets.playImpactEffect();
              }
            }
          };
    // 添加球到世界
    await target.add(ball);
    // 给球一个初始速度
    final controller = findGameController<BaseGameController>();
    if (controller != null) {
      final impulse = controller.getBallImpulse(ct.start!, ct.end!);
      ball.onStoppedAction = (value) {
        controller.didBallStopped(value);
      };
      ball.body.applyLinearImpulseEx(
        impulse,
        /*point: ball.bodyPosition,*/
        wake: false,
      );
      if (collectHistoryTrajectories) {
        trajectories.add(ct);
      }
      currentTrajectory = null;
      //--
      controller.didLaunchBall(ball);
    }
  }
}
