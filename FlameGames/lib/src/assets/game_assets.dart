import 'package:flame_games/gen/assets.gen.dart';
import 'package:flame_games/src/assets/shape_characters.dart';
import 'package:flutter3_basics/flutter3_basics.dart';
import 'package:flutter3_flame/flutter3_flame.dart';

import 'game_icons.dart';
import 'pixel_platformer.dart';
import 'shooting_gallery.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/23
///
/// 游戏资产
class GameAssets {
  final gameIcons = GameIcons();
  final pixelPlatformer = PixelPlatformer();
  final shapeCharacters = ShapeCharacters();
  final shootingGalleryHud = ShootingGalleryHud();

  /// 初始化游戏图片资产
  Future initGameImageAssets({Game? game, String? prefix = ""}) async {
    await gameIcons.loadFromAssets(game, prefix: prefix);
    await shootingGalleryHud.loadFromAssets(game, prefix: prefix);
    await shapeCharacters.loadFromAssets(game, prefix: prefix);
    await pixelPlatformer.loadFromAssets(game, prefix: prefix);

    //--音效
    await $audio.initAudioCache(fileNames: Assets.audio.impact.values);
    await $audio.initAudioCache(fileNames: Assets.audio.interface.values);
  }

  /// 游戏禁音总开关
  bool isGameMute = false;

  /// 播放一个点击音效
  void playClickEffect({bool? isMute}) {
    if (isMute ?? isGameMute) {
      return;
    }
    //$audio.playAudio(Assets.audio.interface.click001);
    //$audio.playAudio(Assets.audio.interface.click002);
    //$audio.playAudio(Assets.audio.interface.click003);
    //$audio.playAudio(Assets.audio.interface.click004);
    $audio.playAudio(Assets.audio.interface.click005);
  }

  /// 播放一个撞击音效
  void playImpactEffect({bool? isMute}) {
    if (isMute ?? isGameMute) {
      return;
    }
    //$audio.playAudio(Assets.audio.impact.impactBellHeavy000);
    //$audio.playAudio(Assets.audio.impact.impactBellHeavy001);
    //$audio.playAudio(Assets.audio.impact.impactBellHeavy002);//.
    //$audio.playAudio(Assets.audio.impact.impactBellHeavy003);//..
    $audio.playAudio(Assets.audio.impact.impactBellHeavy004); //...
  }

  /// 播放一个撞击桶的音效
  void playImpactBucketEffect({bool? isMute}) {
    if (isMute ?? isGameMute) {
      return;
    }
    $audio.playAudio(Assets.audio.impact.impactBellHeavy003);
  }
}

@globalInstance
final $gameAssets = GameAssets();
