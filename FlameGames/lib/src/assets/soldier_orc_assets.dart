import 'package:flutter3_basics/flutter3_basics.dart' show globalInstance;
import 'package:flutter3_flame/flutter3_flame.dart';

import '../../gen/assets.gen.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/09
///
/// 士兵 Solider 和兽人 Orc
class SoldierOrcAssets {
  //MARK: idle
  late Image soliderIdleImage;
  late Image orcIdleImage;

  //MARK: walk
  late Image soliderWalkImage;
  late Image orcWalkImage;

  //MARK: attack
  late Image soliderAttackImage;
  late Image orcAttackImage;

  //MARK: hurt
  late Image soliderHurtImage;
  late Image orcHurtImage;

  //MARK: death
  late Image soliderDeathImage;
  late Image orcDeathImage;

  /// 从资源中加载图片
  Future loadFromAssets(Game? game, {String? prefix = ""}) async {
    final images = game?.images ?? Flame.images;
    if (prefix != null) {
      images.prefix = prefix;
    }
    soliderIdleImage = await images.load(
      Assets.sprite.soldierIdleSpriteSheet.keyName,
    );
    orcIdleImage = await images.load(Assets.sprite.orcIdleSpriteSheet.keyName);

    soliderWalkImage = await images.load(
      Assets.sprite.soldierWalkSpriteSheet.keyName,
    );
    orcWalkImage = await images.load(Assets.sprite.orcWalkSpriteSheet.keyName);

    soliderAttackImage = await images.load(
      Assets.sprite.soldierAttack02SpriteSheet.keyName,
    );
    orcAttackImage = await images.load(
      Assets.sprite.orcAttack02SpriteSheet.keyName,
    );

    soliderHurtImage = await images.load(
      Assets.sprite.soldierHurtSpriteSheet.keyName,
    );
    orcHurtImage = await images.load(Assets.sprite.orcHurtSpriteSheet.keyName);

    soliderDeathImage = await images.load(
      Assets.sprite.soldierDeathSpriteSheet.keyName,
    );
    orcDeathImage = await images.load(
      Assets.sprite.orcDeathSpriteSheet.keyName,
    );
  }

  //MARK: Sprite

  SpriteAnimation get soliderIdleAnimation => SpriteAnimation.fromFrameData(
    soliderIdleImage,
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.15,
      texturePosition: Vector2(0, 0),
      textureSize: Vector2(36, 36),
      loop: true,
    ),
  );

  SpriteAnimation get orcIdleAnimation => SpriteAnimation.fromFrameData(
    orcIdleImage,
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.15,
      texturePosition: Vector2(0, 0),
      textureSize: Vector2(36, 36),
      loop: true,
    ),
  );

  SpriteAnimation get soliderWalkAnimation => SpriteAnimation.fromFrameData(
    soliderWalkImage,
    SpriteAnimationData.sequenced(
      amount: 8,
      stepTime: 0.15,
      texturePosition: Vector2(0, 0),
      textureSize: Vector2(36, 36),
      loop: true,
    ),
  );

  SpriteAnimation get orcWalkAnimation => SpriteAnimation.fromFrameData(
    orcWalkImage,
    SpriteAnimationData.sequenced(
      amount: 8,
      stepTime: 0.15,
      texturePosition: Vector2(0, 0),
      textureSize: Vector2(36, 36),
      loop: true,
    ),
  );

  SpriteAnimation get soliderAttackAnimation => SpriteAnimation.fromFrameData(
    soliderAttackImage,
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.15,
      texturePosition: Vector2(0, 0),
      textureSize: Vector2(36, 36),
      loop: true,
    ),
  );

  SpriteAnimation get orcAttackAnimation => SpriteAnimation.fromFrameData(
    orcAttackImage,
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.15,
      texturePosition: Vector2(0, 0),
      textureSize: Vector2(36, 36),
      loop: true,
    ),
  );

  SpriteAnimation get soliderHurtAnimation => SpriteAnimation.fromFrameData(
    soliderHurtImage,
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.15,
      texturePosition: Vector2(0, 0),
      textureSize: Vector2(36, 36),
      loop: true,
    ),
  );

  SpriteAnimation get orcHurtAnimation => SpriteAnimation.fromFrameData(
    orcHurtImage,
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.15,
      texturePosition: Vector2(0, 0),
      textureSize: Vector2(36, 36),
      loop: true,
    ),
  );

  SpriteAnimation get soliderDeathAnimation => SpriteAnimation.fromFrameData(
    soliderDeathImage,
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.15,
      texturePosition: Vector2(0, 0),
      textureSize: Vector2(36, 36),
      loop: false,
    ),
  );

  SpriteAnimation get orcDeathAnimation => SpriteAnimation.fromFrameData(
    orcDeathImage,
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.15,
      texturePosition: Vector2(0, 0),
      textureSize: Vector2(36, 36),
      loop: false,
    ),
  );
}

/// 精灵状态
enum SpriteState { idle, walk, attack, hurt, death }

@globalInstance
final $soldierOrcAssets = SoldierOrcAssets();
