import 'package:flutter3_core/flutter3_core.dart';

import '../base_game_controller.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/21
///
/// 拼图游戏控制器
class PuzzleGameController extends BaseGameController {
  /// 加载一张图片, 方便游戏
  static Future<UiImage?> loadImage({double? resize, Object? seed}) async {
    //.resizeAsync(size: fb.minOf(size.x, size.y))
    //await sleep(5_000);
    //return $gameAssets.shapeCharacters.image;
    final size = 500;
    UiImage? result;
    try {
      final url = seed == null
          ? "https://picsum.photos/$size"
          : "https://picsum.photos/seed/$seed/$size";
      result = await url.toImageFromHttp();
    } catch (e, s) {
      assert(() {
        l.e(e, stack: s);
        return true;
      }());
      try {
        final url =
            "https://pixabay.com/api/?key=58066999-922e9e5773978c61a6d13484c&min_width=$size&min_height=$size";
        final text = await url.dioGetString();
        final json = text.fromJson();
        final largeImageURL = json["hits"][0]["largeImageURL"];
        result = await "$largeImageURL".toImageFromHttp();
      } catch (e) {
        assert(() {
          l.e(e, stack: s);
          return true;
        }());
      }
    }
    if (result != null && resize != null) {
      result = await result.resizeAsync(size: resize);
    }
    return result;
  }

  PuzzleGameController() {
    scoreLabel = "步数: ";
  }

  //MARK: - 游戏

  /// 重置游戏
  void resetGame() {
    isSolvedDebug = null;
    gameDuration = 0;
    gameScore = 0;
  }

  //MARK: - 属性

  /// 行数
  int row = 0;

  /// 列数
  int col = 0;

  /// 拼图块数据
  List<PuzzleTileData> tiles = [];

  //MARK: - 方法

  /// 初始化拼图块
  /// - [row] 行数
  /// - [col] 列数
  ///
  /// - 重新生成数据
  /// - 重新打乱顺序
  void initPuzzle(int row, int col) {
    this.row = row;
    this.col = col;
    tiles = [];
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < col; j++) {
        tiles.add(
          PuzzleTileData(
            rowIndex: i,
            colIndex: j,
            value: i == row - 1 && j == col - 1 ? 0 /*最后一个*/ : i * col + j + 1,
          ),
        );
      }
    }
    shuffle();
    resetGame();
  }

  /// 重新初始化游戏
  void reInitGame() {
    shuffle();
    resetGame();
  }

  /// 打乱顺序
  void shuffle() {
    //按照空白块, 代码移动的方式洗牌, 保证有解
    for (var i = 0; i < row * col * 30; i++) {
      //获取空白块
      final emptyTile = tiles.firstWhere((tile) => tile.value == 0);
      final neighborTiles = _neighbors(emptyTile);
      if (neighborTiles.isNotEmpty) {
        //随机获取一个邻居块
        final randomTile = neighborTiles.random;
        if (randomTile != null) {
          //交换
          _swapTiles(randomTile, emptyTile);
        }
      }
    }

    //随机洗牌, 有可能无解
    /*final fillIndexList = List<int>.generate(row * col, (index) => index);
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < col; j++) {
        final index = i * col + j;

        fillIndexList.shuffle(random);
        final newIndex = fillIndexList.removeAt(0);
        final newRowIndex = newIndex ~/ col;
        final newColIndex = newIndex % col;

        tiles[index].rowIndex = newRowIndex;
        tiles[index].colIndex = newColIndex;
      }
    }*/
  }

  /// 移动指定块, 如果可以的话
  /// - 块需要在空格的旁边, 才可以移动
  bool moveTile(PuzzleTileData tile) {
    if (tile.value == 0) {
      l.w("不能移动空块:$tile");
      return false;
    }
    // 找到空块
    final emptyTile = tiles.firstWhere((tile) => tile.value == 0);
    final neighborTiles = _neighbors(emptyTile);

    // 如果块在邻居中, 则交换
    if (neighborTiles.contains(tile)) {
      //交换索引
      _swapTiles(tile, emptyTile);

      //--步数+1
      gameScore++;

      return true;
    } else {
      l.d(
        "空白块[$emptyTile]附近无点击块:$tile [${neighborTiles.length}]:\n${neighborTiles.join("\n")}",
      );
    }
    return false;
  }

  /// 交换2个块
  void _swapTiles(PuzzleTileData tile1, PuzzleTileData tile2) {
    // 交换块的索引
    final rowIndex = tile1.currentRowIndex;
    final colIndex = tile1.currentColIndex;
    tile1.currentRowIndex = tile2.currentRowIndex;
    tile1.currentColIndex = tile2.currentColIndex;
    tile2.currentRowIndex = rowIndex;
    tile2.currentColIndex = colIndex;
  }

  /// 获取块的上下左右邻居块
  List<PuzzleTileData> _neighbors(PuzzleTileData target) {
    // 计算块的邻居
    return [
      tiles.findFirst(
        (tile) =>
            tile.currentRowIndex == target.currentRowIndex - 1 &&
            tile.currentColIndex == target.currentColIndex,
      ),
      tiles.findFirst(
        (tile) =>
            tile.currentRowIndex == target.currentRowIndex + 1 &&
            tile.currentColIndex == target.currentColIndex,
      ),
      tiles.findFirst(
        (tile) =>
            tile.currentRowIndex == target.currentRowIndex &&
            tile.currentColIndex == target.currentColIndex - 1,
      ),
      tiles.findFirst(
        (tile) =>
            tile.currentRowIndex == target.currentRowIndex &&
            tile.currentColIndex == target.currentColIndex + 1,
      ),
    ].filterNull();
  }

  /// 是否完成, 调试用
  bool? isSolvedDebug;

  /// 是否完成
  @override
  bool get isGameSolved {
    if (isSolvedDebug != null) {
      return isSolvedDebug!;
    }
    final lastIndex = row * col - 1;
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < col; j++) {
        final index = i * col + j;
        /*if (index != lastIndex && tiles[index].value != i * col + j + 1) {
          return false;
        }*/
        if (index != lastIndex &&
            (tiles[index].currentRowIndex != i ||
                tiles[index].currentColIndex != j)) {
          return false;
        }
      }
    }
    return true;
  }
}

/// 拼图块的信息
class PuzzleTileData with Equatable {
  /// 块的当前显示行索引
  int currentRowIndex;

  /// 块的当前显示列索引
  int currentColIndex;

  /// 块的行索引
  final int rowIndex;

  /// 块的列索引
  final int colIndex;

  /// 块的值
  /// 0: 表示空块
  /// 1~999: 块的值
  final int value;

  PuzzleTileData({
    required this.rowIndex,
    required this.colIndex,
    required this.value,
  }) : currentRowIndex = rowIndex,
       currentColIndex = colIndex;

  @override
  List<Object?> get props => [value];

  @override
  String toString() =>
      "PuzzleTileData(rowIndex: $rowIndex, colIndex: $colIndex, value: $value, "
      "currentRowIndex: $currentRowIndex, currentColIndex: $currentColIndex)";
}
