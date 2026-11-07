import 'package:flutter3_basics/flutter3_basics.dart' as fb;
import 'package:flutter3_flame/flutter3_flame.dart';

import '../../../assets/pixel_shmup_assets.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/06
///
/// 飞船的数据信息
class ShipsData {
  /// 敌机配置
  ShipsConfigData config;

  /// 出生位置
  final Vector2 position;

  /// 移动方向
  final Vector2 direction;

  /// 当前速度
  double speed;

  /// 当前子弹的速度
  double bulletSpeed;

  /// 当前生命值
  int hp;

  /// 玩家索引
  final int? playerIndex;

  /// 是否是玩家的子弹
  bool get isPlayer => playerIndex != null;

  ShipsData({
    required this.config,
    required this.position,
    this.playerIndex,
    Vector2? direction,
    double? speed,
    int? hp,
    double? bulletSpeed,
  }) : hp = hp ?? config.hp,
       speed = speed ?? config.speed,
       direction = direction ?? Vector2.zero(),
       bulletSpeed = bulletSpeed ?? config.bulletSpeed;
}

/// 飞船的配置信息
class ShipsConfigData {
  /// 飞船类型
  /// - 决定飞船的外观
  /// - 决定子弹的外观
  final ShipsType type;

  /// 初始生命值
  final int hp;

  /// 初始移动速度
  final double speed;

  /// 得分
  final int score;

  //MARK: - bullet

  /// 发射子弹的速度
  final double bulletSpeed;

  /// 发射子弹的加速度
  final double bulletAcceleration;

  /// 发射子弹的间隔 s
  final double bulletInterval;

  /// 发射子弹的伤害
  final double bulletDamage;

  /// 是否是跟踪子弹
  final bool isTrackingBullet;

  //MARK: - random

  /// 随机生成权重
  final int weight;

  ShipsConfigData({
    this.type = .blue2,
    this.hp = 100,
    this.speed = 200,
    this.score = 100,
    this.bulletSpeed = 200 * 1.5,
    this.bulletAcceleration = 0,
    this.bulletInterval = 1,
    this.bulletDamage = 100 / 10,
    this.isTrackingBullet = false,
    this.weight = 100,
  });

  /// 根据等级, 返回对应的配置
  /// - [level] 从0开始 1 2 ~ n
  /// - [playerIndex] 玩家索引 0 or 1
  factory ShipsConfigData.level(
    int level, {
    ShipsType? type,
    int? playerIndex,
  }) {
    final isPlayer = playerIndex != null;
    return ShipsConfigData(
      type:
          type ??
          switch (level) {
            0 =>
              playerIndex == 1
                  ? ShipsType.red3
                  : playerIndex == 0
                  ? ShipsType.blue2
                  : [ShipsType.green3, ShipsType.yellow3].random(),
            1 =>
              playerIndex == 1
                  ? ShipsType.red2
                  : playerIndex == 0
                  ? ShipsType.blue3
                  : [ShipsType.green2, ShipsType.yellow2].random(),
            _ =>
              playerIndex == 1
                  ? ShipsType.red1
                  : playerIndex == 0
                  ? ShipsType.blue1
                  : [ShipsType.green1, ShipsType.yellow1].random(),
          },
      hp: (100 + 50 * level).minOf(300),
      speed: (100 - 20.0 * level).maxOf(50),
      score: (100 + 50 * level).minOf(300),
      bulletSpeed: (100 - 20.0 * level).maxOf(50) * (isPlayer ? 2 : 1.5),
      bulletAcceleration: (5.0 * level).minOf(50),
      bulletInterval:
          2 * (level + 1) * fb.nextDouble(0.5, 1) * (isPlayer ? 0.2 : 1),
      bulletDamage: (100 + 50 * level).minOf(300) / (isPlayer ? 4 : 10),
      isTrackingBullet: false,
      weight: (100.0 / (level + 1)).toInt().maxOf(10),
    );
  }
}

/// 飞船类型
enum ShipsType {
  ///蓝色1型
  blue1,

  ///蓝色2型
  blue2,

  ///蓝色3型
  blue3,

  ///红色1型
  red1,

  ///红色2型
  red2,

  ///红色3型
  red3,

  ///绿色1型
  green1,

  ///绿色2型
  green2,

  ///绿色3型
  green3,

  ///黄色1型
  yellow1,

  ///黄色2型
  yellow2,

  ///黄色3型
  yellow3;

  /// 对应的精灵
  Sprite get sprite =>
      $pixelShmupAssets.allShipsSprites[ShipsType.values.indexOf(this)];

  /// 对应的精灵 / 灰色
  Sprite get spriteGray =>
      $pixelShmupAssets.allShipsGraySprites[ShipsType.values.indexOf(this)];

  /// 对应的子弹精灵
  Sprite get bulletSprite =>
      this == .blue1 || this == .red1 || this == .green1 || this == .yellow1
      ? $pixelShmupAssets.tilesBulletMissileDoubleSprite
      : this == .blue2 || this == .red3 || this == .yellow3
      ? $pixelShmupAssets.tilesBulletSprite
      : this == .blue3 || this == .yellow2
      ? $pixelShmupAssets.tilesBulletDoubleSprite
      : this == .red2
      ? $pixelShmupAssets.tilesBulletBombSprite
      : this == .green2
      ? $pixelShmupAssets.tilesBulletBombSprite
      : $pixelShmupAssets.tilesBulletSprite;
}

final shipsEnemyLevel0Configs = [
  ShipsConfigData.level(0, type: ShipsType.green3),
  ShipsConfigData.level(0, type: ShipsType.yellow3),
];

final shipsEnemyLevel1Configs = [
  ...shipsEnemyLevel0Configs,
  ShipsConfigData.level(1, type: ShipsType.green2),
  ShipsConfigData.level(1, type: ShipsType.yellow2),
];

final shipsEnemyLevel2Configs = [
  ...shipsEnemyLevel1Configs,
  ShipsConfigData.level(2, type: ShipsType.green1),
  ShipsConfigData.level(2, type: ShipsType.yellow1),
];
