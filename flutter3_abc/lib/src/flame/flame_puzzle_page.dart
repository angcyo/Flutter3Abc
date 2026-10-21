import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter3_app/flutter3_app.dart' as f3;
import 'package:flutter3_flame/flutter3_flame.dart';

import '../../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/21
///
/// Flame 拼图游戏
class FlamePuzzlePage extends StatefulWidget {
  const FlamePuzzlePage({super.key});

  @override
  State<FlamePuzzlePage> createState() => _FlamePuzzlePageState();
}

class _FlamePuzzlePageState extends State<FlamePuzzlePage>
    with BaseAbcStateMixin {
  @override
  f3.WidgetList buildBodyList(BuildContext context) {
    return [GameWidget(game: PuzzleGame()).size(height: 400)];
  }
}

//MARK: - Game

/// 拼图游戏
class PuzzleGame extends FlameGame {
  int gridSize;
  PuzzleBoard? _board;

  PuzzleGame({this.gridSize = 3});

  @override
  Color backgroundColor() => Colors.black;

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    final boardSize = min(canvasSize.x, canvasSize.y) * 0.92;
    final board = _board;
    if (board != null) {
      board
        ..size = Vector2.all(boardSize)
        ..position = (canvasSize - Vector2.all(boardSize)) / 2;
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    start(gridSize);
  }

  void start(int n) {
    gridSize = n;
    _board?.removeFromParent();

    final boardSize = min(size.x, size.y) * 0.92;
    final board = PuzzleBoard(n)
      ..size = Vector2.all(boardSize)
      ..position = (size - Vector2.all(boardSize)) / 2;

    _board = board;
    add(board);
  }
}

//MARK: - Component

class PuzzleBoard extends PositionComponent
    with HasGameReference, TapCallbacks {
  final int gridSize;
  final Random _random = Random();

  late final List<int> tiles;
  int moves = 0;

  PuzzleBoard(this.gridSize) {
    tiles = List.generate(gridSize * gridSize, (i) {
      return i == gridSize * gridSize - 1 ? 0 : i + 1;
    });
    _shuffle();
  }

  double get cellSize => size.x / gridSize;

  void _shuffle() {
    var empty = tiles.indexOf(0);

    // 从完成状态开始随机合法移动，确保生成的棋盘一定可解。
    for (var i = 0; i < gridSize * gridSize * 30; i++) {
      final neighbors = _neighbors(empty);
      final next = neighbors[_random.nextInt(neighbors.length)];
      tiles[empty] = tiles[next];
      tiles[next] = 0;
      empty = next;
    }
  }

  List<int> _neighbors(int index) {
    final row = index ~/ gridSize;
    final col = index % gridSize;
    final result = <int>[];

    if (row > 0) result.add(index - gridSize);
    if (row < gridSize - 1) result.add(index + gridSize);
    if (col > 0) result.add(index - 1);
    if (col < gridSize - 1) result.add(index + 1);

    return result;
  }

  @override
  void onTapDown(TapDownEvent event) {
    final col = (event.localPosition.x / cellSize).floor();
    final row = (event.localPosition.y / cellSize).floor();

    if (row < 0 || row >= gridSize || col < 0 || col >= gridSize) return;

    final tapped = row * gridSize + col;
    final empty = tiles.indexOf(0);

    if ((tapped ~/ gridSize - empty ~/ gridSize).abs() +
            (tapped % gridSize - empty % gridSize).abs() !=
        1) {
      return;
    }

    tiles[empty] = tiles[tapped];
    tiles[tapped] = 0;
    moves++;
  }

  bool get _isSolved {
    for (var i = 0; i < tiles.length - 1; i++) {
      if (tiles[i] != i + 1) return false;
    }
    return tiles.last == 0;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final gap = cellSize * 0.045;
    final boardPaint = Paint()..color = Colors.white;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.x, size.y),
        const Radius.circular(16),
      ),
      boardPaint,
    );

    for (var i = 0; i < tiles.length; i++) {
      final value = tiles[i];
      if (value == 0) continue;

      final row = i ~/ gridSize;
      final col = i % gridSize;
      final rect = Rect.fromLTWH(
        col * cellSize + gap,
        row * cellSize + gap,
        cellSize - gap * 2,
        cellSize - gap * 2,
      );

      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(10)),
        Paint()..color = const Color(0xFF4F7DF3),
      );

      final text = TextPainter(
        text: TextSpan(
          text: '$value',
          style: TextStyle(
            color: Colors.white,
            fontSize: cellSize * 0.36,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      text.paint(
        canvas,
        Offset(
          rect.center.dx - text.width / 2,
          rect.center.dy - text.height / 2,
        ),
      );
    }

    final status = _isSolved ? '完成！  移动次数：$moves' : '移动次数：$moves';
    final statusText = TextPainter(
      text: TextSpan(
        text: status,
        style: const TextStyle(
          color: Color(0xFF202124),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    statusText.paint(
      canvas,
      Offset((size.x - statusText.width) / 2, size.y + 16),
    );
  }
}
