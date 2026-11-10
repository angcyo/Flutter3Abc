import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter3_basics/flutter3_basics.dart' as fb;
import 'package:flutter3_flame/flutter3_flame.dart';

import '../../assets/soldier_orc_assets.dart';
import '../base_game_mixin.dart';
import '../game_over_component.dart';
import 'component/duel_components.dart';
import 'duel_game_config.dart';
import 'duel_game_controller.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/09
///
/// 游戏界面
class DuelGameScreen extends StatefulWidget with fb.TranslationTypeMixin {
  final DuelGameConfig config;

  @override
  fb.TranslationType get translationType => .none;

  const DuelGameScreen({super.key, required this.config});

  @override
  State<DuelGameScreen> createState() => _DuelGameScreenState();
}

class _DuelGameScreenState extends State<DuelGameScreen>
    with BaseGameStateMixin {
  @override
  Game buildGame() => DuelGame(world: DuelWorld(config: widget.config));
}

//MARK: - Game

/// 游戏主体
class DuelGame extends BaseFlameGame<DuelWorld> {
  DuelGame({super.world});

  @override
  FutureOr<void> onLoad() async {
    camera.viewfinder.anchor = .topLeft;
    await $soldierOrcAssets.loadFromAssets(this);
    add(DuelHudComponent());
    /*if (isDebugMode) {
      add(GameOverComponent(*//*maskColor: Colors.blue*//*));
    }*/
    return super.onLoad();
  }
}

//MARK: - World

/// 游戏世界
class DuelWorld extends BaseFlameWorld {
  final DuelGameConfig config;

  final DuelGameController controller;

  DuelWorld({required this.config})
    : controller = DuelGameController(config: config);

  @override
  void onReloadWorld(Vector2 size) {
    super.onReloadWorld(size);
    controller.startGame(this);
  }

  @override
  void destroyAllChildren() {
    removeAllChildren();
  }

  @override
  void update(double dt) {
    super.update(dt);
    controller.update(dt);
  }
}
