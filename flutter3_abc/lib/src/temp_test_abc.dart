part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2025/01/21
///
/// 临时测试
class TempTestAbc extends StatefulWidget {
  const TempTestAbc({super.key});

  @override
  State<TempTestAbc> createState() => _TempTestAbcState();
}

class _TempTestAbcState extends State<TempTestAbc>
    with BaseAbcStateMixin, TileMixin {
  @override
  WidgetList buildBodyList(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return [
      NumberInputWidget(
        hintText: "字符串输入",
      ).backgroundColor(Colors.black12),
      NumberInputWidget(
        hintText: "整数输入",
        inputNumType: NumType.i,
      ).backgroundColor(Colors.black12),
      NumberInputWidget(
        hintText: "小数输入",
        inputNumType: NumType.d,
      ).backgroundColor(Colors.black12),
      NumberInputWidget(
        hintText: "字符串输入",
      )
          .backgroundColor(Colors.black38)
          .size(width: 80)
          .align(Alignment.centerLeft),
      buildNumberInputWidget(context, null),
      LabelNumberSliderTile(
        labelWidget: [
          "功率(%)".text(),
        ].row(gap: kL)?.paddingOnly(horizontal: kX),
        value: 1,
        minValue: 1,
        maxValue: 100,
        inactiveTrackGradientColors:
            EngraveTileMixin.sActiveTrackGradientColors,
        onValueChanged: (value) {},
      ).paddingOnly(top: kX),
    ];
  }
}
