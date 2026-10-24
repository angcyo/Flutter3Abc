import 'dart:async';
import 'dart:math' as math;

import 'package:flame_games/src/assets/game_assets.dart';
import 'package:flame_games/src/games/puzzle/puzzle_game_config.dart';
import 'package:flame_games/src/games/puzzle/puzzle_game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter3_basics/flutter3_basics.dart' as fb;
import 'package:flutter3_flame/flutter3_flame.dart';

import '../base_game_mixin.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/21
///
/// 拼图游戏界面
class PuzzleGameScreen extends StatefulWidget with fb.TranslationTypeMixin {
  /// 游戏配置
  final PuzzleGameConfig config;

  @override
  fb.TranslationType get translationType => .none;

  const PuzzleGameScreen({required this.config, super.key});

  @override
  State<PuzzleGameScreen> createState() => _PuzzleGameScreenState();
}

class _PuzzleGameScreenState extends State<PuzzleGameScreen>
    with BaseGameStateMixin {
  @override
  void initState() {
    fb.setEnabledSystemUIMode();
    super.initState();
  }

  @override
  Game buildGame() => PuzzleGame(widget.config);
}

//MARK: - Route

/// 游戏路由
enum PuzzleGameRoute {
  /// 选择玩家数量
  selectPlayerCount,

  /// 选择游戏模式
  selectGameMode,

  /// 游戏主界面
  gameMain,
}

//MARK: - Game

/// 游戏主体
class PuzzleGame extends FlameGame {
  /// 游戏配置信息
  final PuzzleGameConfig config;

  /// 游戏图片
  fb.UiImage? gameImage;

  PuzzleGame(this.config);

  @override
  FutureOr<void> onLoad() async {
    if (config.gameType == .image) {
      final loading = TextComponent(text: "加载中...");
      loading.add(
        ColorEffect(
          Colors.black,
          EffectController(duration: 1.5, infinite: true, alternate: true),
          opacityFrom: 0.2,
          opacityTo: 0.8,
        ),
      );
      add(
        loading.button(() {
          pop();
        }).align(),
      );
      PuzzleGameController.loadImage(
        resize: fb.minOf(size.x, size.y),
        seed: "${config.seed}_${config.gridCount}",
      ).then((value) {
        gameImage = value;
        _loadGame();
      });
    } else {
      _loadGame();
    }
    return super.onLoad();
  }

  /// 加载游戏
  void _loadGame() {
    removeAllChildren();
    add(
      SplitLayout(
        children: [
          for (var i = 1; i <= config.playerCount; i++)
            PuzzleBoardComponent(index: i),
        ],
      ),
    );
  }
}

/// 拼图板, 整体组件, 包含所有拼图组件[PuzzleTileComponent]
/// - 包含hud
/// - 包含游戏区域
class PuzzleBoardComponent extends PositionComponent
    with HasGameReference<PuzzleGame> {
  /// 拼图板的索引
  /// - 默认为0
  /// 双人游戏中
  /// - 1: 玩家1,
  /// - 2: 玩家2
  final int index;

  /// 游戏控制器
  final PuzzleGameController controller = PuzzleGameController();

  PuzzleBoardComponent({this.index = 0});

  EffectController get effectController => EffectController(duration: 0.3);

  @override
  FutureOr<void> onLoad() {
    final config = game.config;

    //游戏区
    controller.initPuzzle(config.gridCount, config.gridCount);
    for (final tile in controller.tiles) {
      add(
        PuzzleTileComponent(tile)
          ..debugMode = false
          ..position = _tilePosition(tile)
          ..size = _tileSize(tile),
      );
    }

    //添加HUD
    add(PuzzleHudComponent());
    return super.onLoad();
  }

  Vector2 _tilePosition(PuzzleTileData tile) {
    return Vector2(
      boardLeft + (tileWidth + tileGap) * tile.currentColIndex,
      boardTop + (tileHeight + tileGap) * tile.currentRowIndex,
    );
  }

  Vector2 _tileSize(PuzzleTileData tile) {
    return Vector2(tileWidth, tileHeight);
  }

  /// 拼图块之间的间距
  double tileGap = 0;

  /// 拼图块的宽度
  double tileWidth = 0;

  /// 拼图块的高度
  double tileHeight = 0;

  /// 拼图板的左上角位置
  double boardLeft = 0;

  /// 拼图板的左上角位置
  double boardTop = 0;

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    final config = game.config;

    //左侧hud预留宽度
    final hudWidth = 60.0;
    //板可用宽度/高度
    final boardWidth = (size.x / config.playerCount) - hudWidth;
    final boardHeight = size.y;

    final minGap =
        10.0 * (3 / config.gridCount) /*100.0 / 1 / config.gridCount*/;
    final minTileWidth = 30.0;
    final minTileHeight = 30.0;

    //大小
    tileGap = minGap;
    tileWidth = math.max(
      boardWidth / config.gridCount - tileGap * 2,
      minTileWidth,
    );
    tileHeight = math.max(
      boardHeight / config.gridCount - tileGap * 2,
      minTileHeight,
    );
    if (tileWidth > tileHeight) {
      tileWidth = tileHeight;
    } else {
      tileHeight = tileWidth;
    }

    //位置
    final tileMaxWidth =
        tileWidth * config.gridCount + tileGap * (config.gridCount - 1);
    if (boardWidth < tileMaxWidth) {
      boardLeft = boardWidth - tileMaxWidth;
    } else {
      boardLeft = hudWidth + (boardWidth - tileMaxWidth) / 2;
    }
    boardTop =
        (boardHeight -
            tileHeight * config.gridCount -
            tileGap * (config.gridCount - 1)) /
        2;

    descendants().forEach((child) {
      if (child is PuzzleTileComponent) {
        child.removeAllEffect();
        final tile = child.tileData;
        child.add(MoveEffect.to(_tilePosition(tile), effectController));
        child.add(SizeEffect.to(_tileSize(tile), effectController));
      }
    });
  }

  ///
  @override
  void onParentResize(Vector2 maxSize) {
    super.onParentResize(maxSize);
  }

  //MARK: api

  /// 更新所有拼图块的位置和动画
  void updateAllTilePosition() {
    findChildren<PuzzleTileComponent>(
      (child) => child is PuzzleTileComponent,
    ).forEach((child) {
      child.removeAllEffect();
      final tile = child.tileData;
      child.add(MoveEffect.to(_tilePosition(tile), effectController));
      child.add(SizeEffect.to(_tileSize(tile), effectController));
    });
  }

  /// 当点击拼图块后, 改变了位置, 调用此方法更新位置和动画
  void updateTilePosition(PuzzleTileData? tile) {
    if (tile == null) {
      return;
    }
    final child = findChild<PuzzleTileComponent>(
      (child) => child is PuzzleTileComponent && child.tileData == tile,
    );
    if (child != null) {
      child.removeAllEffect();
      child.add(MoveEffect.to(_tilePosition(tile), effectController));
      child.add(SizeEffect.to(_tileSize(tile), effectController));
    }
    if (tile.value != 0) {
      //同时还要更新空白块
      updateTilePosition(
        findChild<PuzzleTileComponent>(
          (child) => child is PuzzleTileComponent && child.tileData.value == 0,
        )?.tileData,
      );
    }
    if (controller.isSolved()) {
      //游戏胜利
      showGameWin();
    }
  }

  /// 显示游戏胜利
  void showGameWin() {
    final key = ComponentKey.named("game_win_$index");
    if (hasChild(key)) {
      return;
    }
    add(
      FlowTapComponent(
        key: key,
        mainAxisMaxWidth: size.x,
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        backgroundColor: Colors.black38,
        maxChildrenPerRow: 1,
        crossAxisSpacing: 20,
        children: [
          SpriteComponent(
            sprite: $gameAssets.shootingGalleryHud.textGameoverSprite,
          ),
          SpriteComponent(
            sprite: $gameAssets.gameIcons.returnSprite,
            scale: Vector2(-1, 1),
          ).button(() {
            findChildren((e) => e.key == key).removeFromParent();
            controller.reInitGame();
            updateAllTilePosition();
          }),
        ],
      )..debugMode = false,
    );
  }
}

/// 拼图组件
/// - [PuzzleBoardComponent]
class PuzzleTileComponent extends PositionComponent
    with HasGameReference<PuzzleGame>, TapCallbacks {
  PuzzleTileData tileData;

  PuzzleTileComponent(this.tileData);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (tileData.value == 0) {
      //空白块
      return;
    }

    if (game.config.gameType == .image) {
      _drawImage(canvas);
    } else {
      _drawNumber(canvas);
    }
  }

  /// 绘制图片
  void _drawImage(Canvas canvas) {
    final image = game.gameImage;
    if (image != null) {
      final puzzleBoard = findParent<PuzzleBoardComponent>()!;
      final paint = Paint();
      final w = image.width / puzzleBoard.controller.row;
      final h = image.height / puzzleBoard.controller.col;
      final src = Rect.fromLTWH(
        tileData.colIndex * w,
        tileData.rowIndex * h,
        w,
        h,
      );
      final dst = Rect.fromLTWH(
        0,
        0,
        puzzleBoard.tileWidth,
        puzzleBoard.tileHeight,
      );
      canvas.drawImageRect(image, src, dst, paint);

      //超多指定步骤后, 提示小数字
      if ( /*isDebugMode ||*/ puzzleBoard.controller.stepCount >
          30 * (puzzleBoard.controller.row - 2) +
              30 * (puzzleBoard.controller.col - 2)) {
        _drawHintNumber(canvas);
      }
    } else {
      _drawNumber(canvas);
    }
  }

  /// 绘制数字
  void _drawNumber(Canvas canvas) {
    //圆角背景矩形
    final boardPaint = Paint()..color = const Color(0xFF4F7DF3);
    final boardRect = Rect.fromLTWH(0, 0, size.x, size.y);
    canvas.drawRRect(
      RRect.fromRectAndRadius(boardRect, const Radius.circular(16)),
      boardPaint,
    );

    final puzzleBoard = findParent<PuzzleBoardComponent>()!;

    //数值文本
    final text = TextPainter(
      text: TextSpan(
        text: '${tileData.value}',
        style: TextStyle(
          color: Colors.white,
          fontSize: puzzleBoard.tileWidth * 0.36,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    text.paint(
      canvas,
      Offset(
        boardRect.center.dx - text.width / 2,
        boardRect.center.dy - text.height / 2,
      ),
    );
  }

  /// 在左上角绘制提示数字
  void _drawHintNumber(Canvas canvas) {
    if (tileData.value == 0) {
      return;
    }
    final puzzleBoard = findParent<PuzzleBoardComponent>()!;
    final text = TextPainter(
      text: TextSpan(
        text: '${tileData.value}',
        style: TextStyle(
          color: Colors.white,
          fontSize: puzzleBoard.tileWidth * 0.12,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    text.paint(canvas, Offset(4, 0));
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    _moveSelf();
  }

  ///
  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    //_moveSelf();
  }

  /// 移动自己到空白处
  void _moveSelf() {
    if (isGamePaused) {
      return;
    }
    final puzzleBoard = findParent<PuzzleBoardComponent>();
    final controller = puzzleBoard?.controller;
    if (controller == null || controller.isSolved()) {
      return;
    }
    if (controller.moveTile(tileData)) {
      puzzleBoard?.updateTilePosition(tileData);
    }
  }
}

/// 拼图HUD组件
/// - 包含用时显示
/// - 包含步数显示
class PuzzleHudComponent extends PositionComponent
    with HasGameReference<PuzzleGame> {
  final FlameTextComponent timeText = FlameTextComponent(text: "00:00");
  final FlameTextComponent stepCountText = FlameTextComponent(text: "0");

  @override
  FutureOr<void> onLoad() {
    //TextComponent
    add(
      FlowComponent(
        position: Vector2(10, 10),
        rowCrossAxisAlignment: .center,
        children: [
          FlameTextComponent(text: "用时: "),
          timeText,
        ],
      ),
    );
    add(
      FlowComponent(
        position: Vector2(10, 40),
        rowCrossAxisAlignment: .center,
        children: [
          FlameTextComponent(text: "步数: "),
          stepCountText,
        ],
      ),
    );
    //--控制
    final puzzleBoard = findParent<PuzzleBoardComponent>();
    if (puzzleBoard != null && (isDebugMode || puzzleBoard.index <= 1)) {
      add(
        FlowComponent(
          position: Vector2(10, 10),
          crossAxisAlignment: .end,
          maxChildrenPerRow: 1,
          children: [
            if (isDebugMode)
              SpriteComponent(
                sprite: $gameAssets.gameIcons.returnSprite,
                scale: Vector2(-1, 1),
              ).button(() {
                final controller = puzzleBoard.controller;
                controller.reInitGame();
                puzzleBoard.updateAllTilePosition();
              }),
            if (isDebugMode)
              SpriteComponent(
                sprite: $gameAssets.gameIcons.checkmarkSprite,
              ).button(() {
                final controller = puzzleBoard.controller;
                controller.isSolvedDebug = true;
                puzzleBoard.showGameWin();
              }),
            if (isDebugMode)
              SpriteComponent(sprite: $gameAssets.gameIcons.pauseSprite).button(
                () {
                  game.pauseEngine();
                },
              ),
            SpriteComponent(sprite: $gameAssets.gameIcons.returnSprite).button(
              () {
                game.resumeEngine();
                game.pop();
              },
            ),
          ],
        )..debugMode = false,
      );
    }
    return super.onLoad();
  }

  /// 更新游戏数据
  @override
  void update(double dt) {
    super.update(dt);
    final controller = findParent<PuzzleBoardComponent>()?.controller;
    if (controller == null || controller.isSolved()) {
      return;
    }
    controller.timeCost += (dt * 1000).toInt();
    timeText.text = controller.timeCost.toMSTime();
    stepCountText.text = controller.stepCount.toString();
  }

  ///
  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }
}
