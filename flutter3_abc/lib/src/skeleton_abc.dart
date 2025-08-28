import 'package:flutter/material.dart';
import 'package:flutter3_app/flutter3_app.dart';

import '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2025/08/27
///
class SkeletonAbc extends StatefulWidget {
  const SkeletonAbc({super.key});

  @override
  State<SkeletonAbc> createState() => _SkeletonAbcState();
}

class _SkeletonAbcState extends State<SkeletonAbc> with BaseAbcStateMixin {
  @override
  WidgetList buildBodyList(BuildContext context) {
    final data = SkeletonData(
      left: "20",
      top: "20",
      children: [
        SkeletonData(
          fillHeight: "1h",
          bottom: "20",
          right: "20",
          children: [
            part1(),
            /*part1(color: Colors.red),*/
          ],
        ),
      ],
    );
    return [
      ShimmerSkeletonWidget(data: data).size(height: 200),
      ShimmerSkeletonWidget(
        data: data,
        colors: [
          Colors.transparent,
          Colors.red,
          Colors.transparent,
        ],
      ).size(height: 200),
    ];
  }

  SkeletonData part1({
    Color color = Colors.green,
  }) =>
      SkeletonData(
        fillWidth: "600",
        fillHeight: "100",
        right: "20",
        bottom: "20",
        children: [
          SkeletonData(
            type: SkeletonDataType.circle,
            width: "0.1",
            height: "0.1",
            color: color,
          ),
          SkeletonData(
            type: SkeletonDataType.rect,
            left: "0.1+20",
            width: "0.8-20",
            height: "0.1",
            rx: "10",
            ry: "10",
            color: color,
          ),
        ],
      );
}
