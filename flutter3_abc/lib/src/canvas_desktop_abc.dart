part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/12/30
///
class CanvasDesktopAbc extends StatefulWidget {
  const CanvasDesktopAbc({super.key});

  @override
  State<CanvasDesktopAbc> createState() => _CanvasDesktopAbcState();
}

class _CanvasDesktopAbcState extends State<CanvasDesktopAbc> {
  final CanvasDelegate canvasDelegate = CanvasDelegate();

  @override
  Widget build(BuildContext context) {
    return CanvasWidget(canvasDelegate);
  }
}
