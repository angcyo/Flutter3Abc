part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2025/01/04
///
class HoveAnchorAbc extends StatefulWidget {
  const HoveAnchorAbc({super.key});

  @override
  State<HoveAnchorAbc> createState() => _HoveAnchorAbcState();
}

class _HoveAnchorAbcState extends State<HoveAnchorAbc> with BaseAbcStateMixin {
  final offset = 80.0;

  late final List<
      (
        ArrowPosition,
        double?,
        double?,
        double?,
        double?,
        Alignment? alignment
      )> arrowPositionList = [
    //--
    (ArrowPosition.topStart, null, null, null, null, Alignment.bottomLeft),
    (ArrowPosition.topCenter, null, null, null, null, Alignment.bottomCenter),
    (ArrowPosition.topEnd, null, null, null, null, Alignment.bottomRight),
    //--
    (ArrowPosition.rightStart, null, null, null, null, Alignment.topLeft),
    (ArrowPosition.rightCenter, null, null, null, null, Alignment.centerLeft),
    (ArrowPosition.rightEnd, null, null, null, offset, Alignment.bottomLeft),
    //--
    (ArrowPosition.bottomStart, null, offset, null, null, Alignment.topLeft),
    (ArrowPosition.bottomCenter, null, null, null, null, Alignment.topCenter),
    (ArrowPosition.bottomEnd, null, null, null, null, Alignment.topRight),
    //--
    (ArrowPosition.leftStart, null, offset, null, null, Alignment.topRight),
    (ArrowPosition.leftCenter, null, null, null, null, Alignment.centerRight),
    (ArrowPosition.leftEnd, null, null, null, offset, Alignment.bottomRight),
  ];

  final _controllerMap = <ArrowPosition, HoverAnchorLayoutController>{};

  HoverAnchorLayoutController? ensureController(ArrowPosition position) {
    return _controllerMap.putIfAbsent(
        position, () => HoverAnchorLayoutController());
  }

  bool _showArrow = true;
  bool _autoControl = true;
  bool _enableAnimate = true;

  @override
  Widget buildAbc(BuildContext context) {
    return $anyContainer(children: [
      for (final item in arrowPositionList)
        HoverAnchorLayout(
          anchor: "${item.$1}"
              .text()
              .paddingOnly(all: kX)
              .backgroundDecoration(fillDecoration())
              .click(() {
            //debugger();
            ensureController(item.$1)?.toggle();
          }),
          content: "${item.$1}".text().rowOf(GradientButton(
              child: "close".text(),
              onTap: () {
                lpToast("click:${item.$1}".text());
              })) /*.paddingAll(kX)*/,
          controller: ensureController(item.$1),
          backgroundColor: Colors.redAccent,
          arrowPosition: item.$1,
          showArrow: _showArrow,
          enableHoverShow: _autoControl,
          enableAnimate: _enableAnimate,
        ).anyParentData(
          left: item.$2,
          top: item.$3,
          right: item.$4,
          bottom: item.$5,
          alignment: item.$6,
        ),
      SwitchListTile(
          value: _showArrow,
          title: "是否显示箭头".text(),
          onChanged: (value) {
            _showArrow = value;
            updateState();
          }).anyParentData(
        maxWidth: 240,
        alignment: Alignment.center,
      ),
      SwitchListTile(
          value: _autoControl,
          title: "是否悬停显示".text(),
          onChanged: (value) {
            _autoControl = value;
            updateState();
          }).anyParentData(
        afterOffset: Offset(0, 50),
        maxWidth: 240,
        alignment: Alignment.center,
      ),
      SwitchListTile(
          value: _enableAnimate,
          title: "是否激活动画".text(),
          onChanged: (value) {
            _enableAnimate = value;
            updateState();
          }).anyParentData(
        afterOffset: Offset(0, 50 * 2),
        maxWidth: 240,
        alignment: Alignment.center,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return super.build(context);
    } else {
      return buildAbc(context);
    }
  }
}
