import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter3_app/flutter3_app.dart';
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
  final yScale1 = 60.0;

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
      [
        //MARK: 三角函数
        "↓三角函数↓".text(textAlign: .center).flowLayoutData(weight: 1),
        MathFunPaintWidget(
          tex: r'正弦函数: f(x) = \sin(x)',
          fun: (radians) => math.sin(radians),
          xSample: 0.1,
          xScale: 5,
          yScale: yScale1,
          xTicksStep: math.pi / 2,
          yTicksStep: 1,
        ),
        MathFunPaintWidget(
          tex: r'余弦函数: f(x) = \cos(x)',
          fun: (radians) => math.cos(radians),
          xSample: 0.1,
          xScale: 5,
          yScale: yScale1,
          xTicksStep: math.pi / 2,
          yTicksStep: 1,
        ),
        MathFunPaintWidget(
          tex: r'反正弦函数: f(x) = \arcsin(x)',
          fun: (x) => math.asin(x),
          xSample: 0.1,
          xScale: 10,
          yScale: yScale1,
          xTicksStep: 1,
          yTicksStep: math.pi / 8,
        ),
        MathFunPaintWidget(
          tex: r'反余弦函数: f(x) = \arccos(x)',
          fun: (x) => math.acos(x),
          xSample: 0.1,
          xScale: 10,
          yScale: yScale1 * 2 / 5,
          xTicksStep: 1,
          yTicksStep: math.pi / 4,
        ),
        //MARK: 多项式
        "↓多项式↓".text(textAlign: .center).flowLayoutData(weight: 1),
        MathFunPaintWidget(
          tex: r'2次多项式: f(x) = x^2 + x',
          fun: (x) => math.pow(x, 2) + x,
          xSample: 0.1,
          xScale: 0.8,
        ),
        MathFunPaintWidget(
          tex: r'3次多项式: f(x) = x^3 + x^2 + x',
          fun: (x) => math.pow(x, 3) + math.pow(x, 2) + x,
          xSample: 0.1,
          xScale: 0.8,
        ),
        MathFunPaintWidget(
          tex: r'4次多项式: f(x) = x^4 + x^3 + x^2 + x',
          fun: (x) => math.pow(x, 4) + math.pow(x, 3) + math.pow(x, 2) + x,
          xSample: 0.1,
          xScale: 0.8,
        ),
        MathFunPaintWidget(
          tex: r'5次多项式: f(x) = x^5 + x^4 + x^3 + x^2 + x',
          fun: (x) =>
              math.pow(x, 5) +
              math.pow(x, 4) +
              math.pow(x, 3) +
              math.pow(x, 2) +
              x,
          xSample: 0.1,
          xScale: 0.8,
        ),
        //MARK: 幂函数
        "↓幂函数↓".text(textAlign: .center).flowLayoutData(weight: 1),
        MathFunPaintWidget(
          tex: r'2次幂函数: f(x) = x^n',
          fun: (x) => math.pow(x, 2).toDouble(),
          xSample: 0.1,
          xScale: 0.8,
        ),
        MathFunPaintWidget(
          tex: r'3次幂函数: f(x) = x^n',
          fun: (x) => math.pow(x, 3).toDouble(),
          xSample: 0.1,
          xScale: 0.8,
        ),
        MathFunPaintWidget(
          tex: r'4次幂函数: f(x) = x^n',
          fun: (x) => math.pow(x, 4).toDouble(),
          xSample: 0.1,
          xScale: 0.8,
        ),
        MathFunPaintWidget(
          tex: r'5次幂函数: f(x) = x^n',
          fun: (x) => math.pow(x, 5).toDouble(),
          xSample: 0.1,
          xScale: 0.8,
        ),
        //MARK: 指数函数
        "↓指数函数↓".text(textAlign: .center).flowLayoutData(weight: 1),
        MathFunPaintWidget(
          tex: r'2为低指数函数: f(x) = a^x',
          fun: (x) => math.pow(2, x).toDouble(),
          xSample: 0.1,
          xScale: 0.8,
        ),
        MathFunPaintWidget(
          tex: r'3为低指数函数: f(x) = a^x',
          fun: (x) => math.pow(3, x).toDouble(),
          xSample: 0.1,
          xScale: 0.8,
        ),
        MathFunPaintWidget(
          tex: r'4为低指数函数: f(x) = a^x',
          fun: (x) => math.pow(4, x).toDouble(),
          xSample: 0.1,
          xScale: 0.8,
        ),
        MathFunPaintWidget(
          tex: r'5为低指数函数: f(x) = a^x',
          fun: (x) => math.pow(5, x).toDouble(),
          xSample: 0.1,
          xScale: 0.8,
        ),
      ].flowLayout(lineMaxChildCount: 2, equalWidthRange: "", gap: kM)!,
    ];
  }
}

//MARK: - widget

/// 用来绘制数学公式的 widget
class MathFunPaintWidget extends StatelessWidget {
  /// LaTeX 表达式
  final String tex;

  /// x轴采样间隔数值
  /// - 值越大, 波长越短越细
  /// - 值越小, 波长越长越粗
  final double xSample;

  /// x轴坐标缩放的倍数
  final double xScale;

  /// y轴缩放数值倍数, 公式计算出值后, 需要放大的倍数
  /// - 影响波峰, 波谷的大小
  final double yScale;

  /// 数学公式计算函数
  final double Function(double) fun;

  /// x轴需要绘制刻度的值间隔, 这个值是函数参数的输入值
  final double? xTicksStep;

  /// y轴需要绘制刻度的值间隔, 这个值是函数参数的输出值
  final double? yTicksStep;

  final String? debugLabel;

  const MathFunPaintWidget({
    super.key,
    required this.tex,
    required this.fun,
    this.xSample = 1,
    this.xScale = 1,
    this.yScale = 1,
    this.xTicksStep,
    this.yTicksStep,
    this.debugLabel,
  });

  @override
  Widget build(BuildContext context) {
    return [
      paintWidget((canvas, size) {
        canvas.debugPaintBoxQuadrant(
          size,
          paintQuadrant: false,
          paintBounds: true,
          transform: createFlipMatrix(flipY: true, anchor: size.center(.zero)),
          color: Colors.grey,
        );

        //绘图坐标中点
        final cx = size.width / 2;
        final cy = size.height / 2;

        //采样值范围
        final xMax = size.width / xScale;

        final path = Path();
        debugger(when: debugLabel != null);
        for (var x = 0; x < xMax; x++) {
          //公式计算
          final xStep = x - xMax / 2;
          final xValue = xStep * xSample;
          final yValue = fun(xValue).ensureValid();
          //绘制点
          final px = cx + xStep * xScale;
          final py = cy - yValue * yScale;
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

        //x轴刻度
        if (xTicksStep != null) {
          //x值转换为绘制坐标
          double xValueToPx(double x) {
            final xValue = x;
            final xStep = xValue / xSample;
            final px = cx + xStep * xScale;
            return px;
          }

          double xValue = 0;
          while (true) {
            xValue += xTicksStep!;
            final px = xValueToPx(xValue);
            if (px > size.width) {
              break;
            }
            canvas.drawText(
              xValue.toDigits(),
              getOffset: (painter) {
                return Offset(px - painter.width / 2, cy);
              },
            );
          }
          xValue = 0;
          while (true) {
            xValue -= xTicksStep!;
            final px = xValueToPx(xValue);
            if (px < 0) {
              break;
            }
            canvas.drawText(
              xValue.toDigits(),
              getOffset: (painter) {
                return Offset(px - painter.width / 2, cy);
              },
            );
          }
        }

        //y轴刻度
        if (yTicksStep != null) {
          //y值转换为绘制坐标
          double yValueToPx(double y) {
            final yValue = y;
            final py = cy - yValue * yScale;
            return py;
          }

          final xOffset = 2;

          double yValue = 0;
          while (true) {
            yValue += yTicksStep!;
            final py = yValueToPx(yValue);
            if (py < 0) {
              break;
            }
            canvas.drawText(
              yValue.toDigits(),
              getOffset: (painter) {
                return Offset(cx + xOffset, py - painter.height / 2);
              },
            );
          }
          yValue = 0;
          while (true) {
            yValue -= yTicksStep!;
            final py = yValueToPx(yValue);
            if (py > size.height) {
              break;
            }
            canvas.drawText(
              yValue.toDigits(),
              getOffset: (painter) {
                return Offset(cx + xOffset, py - painter.height / 2);
              },
            );
          }
        }
      }).ratio(1 / 0.3).clipRadius(radius: 0),
      math_tex.Math.tex(tex, mathStyle: math_tex.MathStyle.display),
    ].column(crossAxisAlignment: .center)!;
  }
}
