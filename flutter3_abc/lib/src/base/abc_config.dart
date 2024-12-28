part of '../../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/11/07
///

abstract final class AbcConfig {
  static int _clickCount = 0;

  /// 获取点击次数
  static int getAndIncrementClickCount() {
    return _clickCount++;
  }
}