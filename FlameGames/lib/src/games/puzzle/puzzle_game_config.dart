///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/23
///
/// 拼图游戏配置
class PuzzleGameConfig {
  /// 游戏人数
  /// - 1
  /// - 2
  int playerCount = 1;

  /// 游戏网格数 / 游戏难度
  int gridCount = 3;

  /// 游戏类型
  PuzzleGameType gameType = .number;

  /// 图片随机种子
  String seed = "";
}

enum PuzzleGameType {
  /// 数字拼板
  number,

  /// 图片拼板
  image,
}
