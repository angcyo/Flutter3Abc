part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/07/29
///
/// 新设计界面
class CanvasAbc2 extends StatefulWidget {
  /// 是否恢复临时工程
  final bool? restoreTempProject;

  /// 需要打开的工程
  final ProjectBean? openProjectBean;

  const CanvasAbc2({
    super.key,
    this.restoreTempProject,
    this.openProjectBean,
  });

  @override
  State<CanvasAbc2> createState() => _CanvasAbc2State();
}

class _CanvasAbc2State extends State<CanvasAbc2>
    with CreationMixin, CreationMixin2, AppLifecycleStateMixin {
  @override
  void onAppChangeMetrics() {
    updateState();
  }
}
