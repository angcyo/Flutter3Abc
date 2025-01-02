part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2025/01/02
///
class MouseRegionAbc extends StatefulWidget {
  const MouseRegionAbc({super.key});

  @override
  State<MouseRegionAbc> createState() => _MouseRegionAbcState();
}

class _MouseRegionAbcState extends State<MouseRegionAbc> {
  List<MouseCursor> mouseCursorList = [
    SystemMouseCursors.none,
    SystemMouseCursors.basic,
    SystemMouseCursors.click,
    SystemMouseCursors.forbidden,
    SystemMouseCursors.wait,
    SystemMouseCursors.progress,
    SystemMouseCursors.contextMenu,
    SystemMouseCursors.help,
    SystemMouseCursors.text,
    SystemMouseCursors.verticalText,
    SystemMouseCursors.cell,
    SystemMouseCursors.precise,
    SystemMouseCursors.move,
    SystemMouseCursors.grab,
    SystemMouseCursors.grabbing,
    SystemMouseCursors.noDrop,
    SystemMouseCursors.alias,
    SystemMouseCursors.copy,
    SystemMouseCursors.disappearing,
    SystemMouseCursors.allScroll,
    SystemMouseCursors.resizeLeftRight,
    SystemMouseCursors.resizeUpDown,
    SystemMouseCursors.resizeUpLeftDownRight,
    SystemMouseCursors.resizeUpRightDownLeft,
    SystemMouseCursors.resizeUp,
    SystemMouseCursors.resizeDown,
    SystemMouseCursors.resizeLeft,
    SystemMouseCursors.resizeRight,
    SystemMouseCursors.resizeUpLeft,
    SystemMouseCursors.resizeUpRight,
    SystemMouseCursors.resizeDownLeft,
    SystemMouseCursors.resizeDownRight,
    SystemMouseCursors.resizeColumn,
    SystemMouseCursors.resizeRow,
    SystemMouseCursors.zoomIn,
    SystemMouseCursors.zoomOut,
  ];

  @override
  Widget build(BuildContext context) {
    return [
      for (final cursor in mouseCursorList)
        "$cursor"
            .text()
            .paddingOnly(all: kX)
            .backgroundDecoration(fillDecoration())
            .mouse(cursor: cursor),
    ].flowLayout(padding: edgeOnly(all: kX), childGap: kX)!;
  }
}
