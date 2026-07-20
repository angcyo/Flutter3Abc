import 'package:flutter/material.dart';
import 'package:flutter3_app/flutter3_app.dart';

import '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/07/20
///
/// 表盘布局测试页面
class DialLayoutAbc extends StatefulWidget {
  const DialLayoutAbc({super.key});

  @override
  State<DialLayoutAbc> createState() => _DialLayoutAbcState();
}

class _DialLayoutAbcState extends State<DialLayoutAbc>
    with BaseAbcStateMixin, TileMixin {
  /// 子元素的数量
  int _childCount = 12;
  double radialGap = 30;
  double arcGap = 30;

  @override
  WidgetList buildBodyList(BuildContext context) {
    return [
      DialLayout(
        radialGap: radialGap,
        arcGap: arcGap,
        children: [
          for (int i = 0; i < _childCount; i++)
            GradientButton(
              child: "Button $i".text(),
              onTap: () {
                toast("$i".text(useDefStyle: false));
              },
            ),
        ],
      ).size(height: $screenHeight * 3 / 4),
      [
        "数量".text().min(minWidth: 80),
        buildSliderWidget(
          context,
          _childCount.toDouble(),
          minValue: 0,
          maxValue: 100,
          onChanged: (value) {
            _childCount = value.toInt();
            updateState();
          },
        ).expanded(),
      ].row()!,
      [
        "元素间隙".text().min(minWidth: 80),
        buildSliderWidget(
          context,
          arcGap,
          minValue: 0,
          maxValue: 100,
          onChanged: (value) {
            arcGap = value;
            updateState();
          },
        ).expanded(),
      ].row()!,
      [
        "圆间隙".text().min(minWidth: 80),
        buildSliderWidget(
          context,
          radialGap,
          minValue: 0,
          maxValue: 100,
          onChanged: (value) {
            radialGap = value;
            updateState();
          },
        ).expanded(),
      ].row()!,
    ];
  }
}
