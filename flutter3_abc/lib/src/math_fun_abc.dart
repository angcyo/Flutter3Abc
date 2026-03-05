import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter3_basics/flutter3_basics.dart';
import 'package:flutter_math_fork/flutter_math.dart' as math_tex;

import '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/03/05
///
/// 数学函数 Abc
/// - LaTeX 是一个功能极其强大的离散排版系统（排版界的“重型坦克”）
/// - KaTeX 是一个专门为 Web 浏览器设计的数学公式渲染库（排版界的“超音速赛车”）。
///
/// - [LaTeX 表达式](https://docs.gmt-china.org/6.2/basis/latex/)
/// - [KaTeX 表达式](https://katex.org/docs/supported.html) Flutter
///                 https://katex.org/docs/support_table.html
/// - [KaTeX 在线交互](https://katex.org/#demo)
///
class MathFunAbc extends StatefulWidget {
  const MathFunAbc({super.key});

  @override
  State<MathFunAbc> createState() => _MathFunAbcState();
}

class _MathFunAbcState extends State<MathFunAbc> with BaseAbcStateMixin {
  @override
  WidgetList buildBodyList(BuildContext context) {
    //return super.buildBodyList(context);
    return [
      "test".text(),
      math_tex.Math.tex(r'\frac a b', mathStyle: math_tex.MathStyle.display),
      math_tex.Math.tex(r'\frac a b', mathStyle: math_tex.MathStyle.text),
      math_tex.Math.tex(
        r'\frac a b',
        textStyle: TextStyle(fontSize: 42),
        // logicalPpi: MathOptions.defaultLogicalPpiFor(42),
      ),
      math_tex.SelectableMath.tex(
        r'\frac a b',
        textStyle: TextStyle(fontSize: 42),
      ),
      math_tex.Math.tex(
        r'\garbled $tring',
        textStyle: TextStyle(color: Colors.green),
        onErrorFallback: (err) => Container(
          color: Colors.red,
          child: Text(
            err.messageWithType,
            style: TextStyle(color: Colors.yellow),
          ),
        ),
      ),
      MathFunPaintWidget(tex: r'f(x) = \sin(x)'),
    ];
  }
}

//MARK: - widget

/// 用来绘制数学公式的 widget
class MathFunPaintWidget extends StatelessWidget {
  final String tex;

  const MathFunPaintWidget({super.key, required this.tex});

  @override
  Widget build(BuildContext context) {
    return [
      paintWidget((canvas, size) {
        canvas.drawRect(
          Rect.fromLTWH(10, 10, 10, 10),
          Paint()..color = Colors.redAccent,
        );
        final cx = size.width / 2;
        final cy = size.height / 2;
        final path = Path();
        var radians = 0.0;
        for (var x = 0; x < cx; x++) {
          final px = cx + x;
          final py =
              cy -
              math.sin(radians) *
                  50; /*math.sin((x % 100) / 100 * math.pi / 2)*/
          radians += 1;
          if (x == 0) {
            path.moveTo(px, py);
          } else {
            path.lineTo(px, py);
          }
        }

        canvas.drawPath(
          path,
          Paint()
            ..style = .stroke
            ..color = Colors.redAccent,
        );
      }).ratio(1 / 0.3),
      math_tex.Math.tex(tex, mathStyle: math_tex.MathStyle.display),
    ].column(crossAxisAlignment: .center)!;
  }
}
