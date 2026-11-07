import 'dart:math';

import 'package:flame_games/src/games/ships/component/ships_spirit.dart';
import 'package:flutter3_basics/flutter3_basics.dart' as fb;
import 'package:flutter3_flame/flutter3_flame.dart';

import '../data/ships_data.dart';
import '../ships_game_screen.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/06
///
/// 飞船敌人生成器
class ShipsEnemySpawner extends Component {
  /// 经过的时间 ms
  double elapsedSeconds = 0;

  /// 累计时间
  double _cumulativeTime = 0;

  /// 累计数量
  int _cumulativeCount = 0;

  @override
  void update(double dt) {
    super.update(dt);
    elapsedSeconds += dt;
    final difficulty = EnemyDifficulty(elapsedSeconds: elapsedSeconds);
    if (_cumulativeTime < 1) {
      _cumulativeTime += dt;
      if (_cumulativeCount <
          shipsGameController.config.enemySpawnRate *
              (difficulty.level / 2).maxOf(1) *
              shipsGameController.config.playerCount) {
        //每秒20个
        _cumulativeCount += 1;
        final enemyData = generateEnemy(difficulty: difficulty);
        if (enemyData != null) {
          findParent<World>()?.add(ShipsEnemySpirit(shipsData: enemyData));
        }
      }
    } else {
      _cumulativeTime = 0;
      _cumulativeCount = 0;
    }
  }

  /// 根据游戏时长生成敌机数据
  ShipsData? generateEnemy({
    required EnemyDifficulty difficulty,
    List<Vector2> existingPositions = const [],
  }) {
    final config = shipsGameController.randomEnemyConfig(difficulty.level);

    final position = shipsGameController.randomEnemyPositionWithSpacing(
      gameSize: findGame()!.canvasSize,
      existingPositions: existingPositions,
      minSpacing: 60,
    );

    if (position == null) {
      return null;
    }

    return ShipsData(
      config: config,
      position: position,
      /*direction: Vector2(0, 1),
      speed: config.speed * difficulty.speedMultiplier,
      hp: config.hp * difficulty.hpMultiplier,*/
    );
  }
}

class ShipsEnemySpawnSchedule {
  /// 在指定时间内生成指定数量的敌机
  ///
  /// duration: 总生成时间，单位秒
  /// count: 生成数量
  /// randomize: 是否随机生成时间
  /// random: 随机数生成器
  ///
  /// 返回每架敌机的生成时间，单位秒
  static List<double> generate({
    required double duration,
    required int count,
    bool randomize = false,
  }) {
    if (duration <= 0) {
      throw ArgumentError.value(duration, 'duration');
    }

    if (count < 0) {
      throw ArgumentError.value(count, 'count');
    }

    if (count == 0) {
      return [];
    }

    final interval = duration / count;

    final result = <double>[];

    for (var i = 0; i < count; i++) {
      // 均匀分布：每个生成时间段的中心位置
      final baseTime = interval * (i + 1);

      var time = baseTime;

      if (randomize) {
        // 在当前时间段内随机偏移
        final offset = (fb.nextDouble() - 0.5) * interval * 0.8;

        time += offset;
      }

      // 限制在指定时间范围内
      time = time.clamp(0.0, duration).toDouble();

      result.add(time);
    }

    result.sort();

    return result;
  }
}

class EnemyDifficulty {
  /// 当前游戏时间
  final double elapsedSeconds;

  const EnemyDifficulty({required this.elapsedSeconds});

  /// 敌机生成间隔
  double get spawnInterval {
    return max(0.4, 2.0 - elapsedSeconds * 0.01);
  }

  /// 敌机速度倍率
  double get speedMultiplier {
    return min(2.0, 1.0 + elapsedSeconds * 0.005);
  }

  /// 敌机生命值倍率
  double get hpMultiplier {
    return min(3.0, 1.0 + elapsedSeconds * 0.01);
  }

  /// 根据游戏时长, 决定游戏等级 30s 一个等级
  /// [0~10]
  int get level {
    return (elapsedSeconds / 30).clamp(0, 10).toInt();
  }

  /*  /// 是否进入 Boss 波
  bool get isBossWave {
    return elapsedSeconds >= 90;
  }*/
}
