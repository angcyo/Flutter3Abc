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
  Widget buildAbc(BuildContext context) {
    return SkeletonWidget(
      data: SkeletonData(
        type: SkeletonDataType.circle,
        width: 0.3,
        height: 0.3,
        color: Colors.green,
      ),
    ).bounds();
  }
}
