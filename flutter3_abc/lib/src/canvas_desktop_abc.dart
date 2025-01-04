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
    return cLayout(() {
      _buildLeftNavigation(context).alignParentConstraint(
        width: 54,
      );
      CanvasWidget(canvasDelegate).alignParentConstraint(
        alignment: Alignment.centerRight,
        width: matchConstraint,
        left: sId(-1).right,
      );
    });
  }

  /// 构建导航
  Widget _buildLeftNavigation(BuildContext context) {
    final OverlayPortalController controller = OverlayPortalController();
    return [
      HoverAnchorLayout(
        anchor: lpAbcSvgWidget(Assets.svg.addImage).icon(() {
          lpToast("click1".text());
        }),
        content: [
          ArrowWidget().size(size: 20),
          lpAbcSvgWidget(Assets.svg.addShape),
          lpAbcSvgWidget(Assets.svg.addImage).icon(() {
            lpToast("click2".text());
          }),
        ].column()!.backgroundColor(Colors.black12),
      ),
      lpAbcSvgWidget(Assets.svg.addImage),
      lpAbcSvgWidget(Assets.svg.addShape),
      lpAbcSvgWidget(Assets.svg.addShape),
      HoverAnchorLayout(
        anchor: lpAbcSvgWidget(Assets.svg.addImage).icon(() {
          lpToast("click1".text());
        }),
        content: [
          ArrowWidget().size(size: 20),
          lpAbcSvgWidget(Assets.svg.addShape),
          lpAbcSvgWidget(Assets.svg.addImage).icon(() {
            lpToast("click2".text());
          }),
        ].column()!.backgroundColor(Colors.black12),
      ),
    ].scroll(axis: Axis.vertical)!;
  }
}
