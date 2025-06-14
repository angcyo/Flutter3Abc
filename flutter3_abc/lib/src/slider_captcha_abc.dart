import 'package:flutter/material.dart';
import 'package:flutter3_app/flutter3_app.dart';

import '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a> \
/// @date 2025/06/14
///
class SliderCaptchaAbc extends StatefulWidget {
  const SliderCaptchaAbc({super.key});

  @override
  State<SliderCaptchaAbc> createState() => _SliderCaptchaAbcState();
}

class _SliderCaptchaAbcState extends State<SliderCaptchaAbc>
    with BaseAbcStateMixin {
  @override
  Widget buildAbc(BuildContext context) {
    return SliderCaptchaWidget().bounds();
  }
}
