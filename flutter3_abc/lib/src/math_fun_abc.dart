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
        "↓三角函数↓"
            .text(textAlign: .center, textColor: Colors.purpleAccent)
            .flowLayoutData(weight: 1),
        MathFunPaintWidget(
          tex: r'正弦 (Sine)函数: f(x) = \sin(x)',
          fun: (radians) => math.sin(radians),
          xSample: 0.1,
          xScale: 5,
          yScale: yScale1,
          xTicksStep: math.pi / 2,
          yTicksStep: 1,
        ),
        MathFunPaintWidget(
          tex: r'余弦 (Cosine)函数: f(x) = \cos(x)',
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
        MathFunPaintWidget(
          tex: r'正切 (Tangent)函数: f(x) = \tan(x)',
          fun: (radians) => math.tan(radians),
          xSample: 0.1,
          xScale: 5,
          xMinValue: -math.pi / 2,
          xMaxValue: math.pi / 2,
          yScale: yScale1,
          xTicksStep: math.pi / 2,
          yTicksStep: 1,
        ),
        MathFunPaintWidget(
          tex: r'反正切函数: f(x) = \arctan(x)',
          fun: (x) => math.atan(x),
          xSample: 0.1,
          xScale: 10,
          yScale: yScale1 * 2 / 5,
          xTicksStep: 1,
          yTicksStep: math.pi / 4,
        ),
        //MARK: 多项式
        "↓多项式↓"
            .text(textAlign: .center, textColor: Colors.purpleAccent)
            .flowLayoutData(weight: 1),
        MathFunPaintWidget(
          tex: r'2次多项式: f(x) = x^2 + x',
          fun: (x) => math.pow(x, 2) + x,
          xSample: 0.1,
          xScale: 0.8,
          xTicksStep: 10,
          yTicksStep: 50,
        ),
        MathFunPaintWidget(
          tex: r'3次多项式: f(x) = x^3 + x^2 + x',
          fun: (x) => math.pow(x, 3) + math.pow(x, 2) + x,
          xSample: 0.1,
          xScale: 0.8,
          xTicksStep: 10,
          yTicksStep: 50,
        ),
        MathFunPaintWidget(
          tex: r'4次多项式: f(x) = x^4 + x^3 + x^2 + x',
          fun: (x) => math.pow(x, 4) + math.pow(x, 3) + math.pow(x, 2) + x,
          xSample: 0.1,
          xScale: 0.8,
          xTicksStep: 10,
          yTicksStep: 50,
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
          xTicksStep: 10,
          yTicksStep: 50,
        ),
        //MARK: 幂函数
        "↓幂函数↓"
            .text(textAlign: .center, textColor: Colors.purpleAccent)
            .flowLayoutData(weight: 1),
        MathFunPaintWidget(
          tex: r'2次幂函数: f(x) = x^n',
          fun: (x) => math.pow(x, 2).toDouble(),
          xSample: 0.1,
          xScale: 0.8,
          xTicksStep: 10,
          yTicksStep: 50,
        ),
        MathFunPaintWidget(
          tex: r'3次幂函数: f(x) = x^n',
          fun: (x) => math.pow(x, 3).toDouble(),
          xSample: 0.1,
          xScale: 0.8,
          xTicksStep: 10,
          yTicksStep: 50,
        ),
        MathFunPaintWidget(
          tex: r'4次幂函数: f(x) = x^n',
          fun: (x) => math.pow(x, 4).toDouble(),
          xSample: 0.1,
          xScale: 0.8,
          xTicksStep: 10,
          yTicksStep: 50,
        ),
        MathFunPaintWidget(
          tex: r'5次幂函数: f(x) = x^n',
          fun: (x) => math.pow(x, 5).toDouble(),
          xSample: 0.1,
          xScale: 0.8,
          xTicksStep: 10,
          yTicksStep: 50,
        ),
        //MARK: 指数函数
        "↓指数函数↓"
            .text(textAlign: .center, textColor: Colors.purpleAccent)
            .flowLayoutData(weight: 1),
        MathFunPaintWidget(
          tex: r'2为底指数函数: f(x) = a^x',
          fun: (x) => math.pow(2, x).toDouble(),
          xSample: 0.1,
          xScale: 0.8,
          xTicksStep: 10,
          yTicksStep: 50,
        ),
        MathFunPaintWidget(
          tex: r'3为底指数函数: f(x) = a^x',
          fun: (x) => math.pow(3, x).toDouble(),
          xSample: 0.1,
          xScale: 0.8,
          xTicksStep: 10,
          yTicksStep: 50,
        ),
        MathFunPaintWidget(
          tex: r'4为底指数函数: f(x) = a^x',
          fun: (x) => math.pow(4, x).toDouble(),
          xSample: 0.1,
          xScale: 0.8,
          xTicksStep: 10,
          yTicksStep: 50,
        ),
        MathFunPaintWidget(
          tex: r'5为底指数函数: f(x) = a^x',
          fun: (x) => math.pow(5, x).toDouble(),
          xSample: 0.1,
          xScale: 0.8,
          xTicksStep: 10,
          yTicksStep: 50,
        ),
        //MARK: 其它函数
        "↓其它函数↓"
            .text(textAlign: .center, textColor: Colors.purpleAccent)
            .flowLayoutData(weight: 1),
        MathFunPaintWidget(
          tex: r'平方根函数: f(x) = \sqrt{x}',
          fun: (x) => math.sqrt(x).toDouble(),
          xTicksStep: 50,
          yScale: 5,
          yTicksStep: 4,
        ),
        MathFunPaintWidget(
          tex: r'倒数函数: f(x) = 1/x',
          fun: (x) => 1 / x,
          xSample: 0.01,
          xScale: 10,
          xTicksStep: 1,
          yScale: 0.4,
          yTicksStep: 100,
        ),
        MathFunPaintWidget(
          tex: r'自然指数函数: f(x) = e^x',
          fun: (x) => math.exp(x),
          xSample: 0.1,
          xScale: 10,
          xTicksStep: 1,
          yScale: 40,
          yTicksStep: 1,
        ),
        MathFunPaintWidget(
          tex: r'自然对数函数(幂函数的逆): f(x) = \ln(x)',
          fun: (x) => math.log(x),
          xSample: 0.1,
          xScale: 10,
          xTicksStep: 1,
          yScale: 40,
          yTicksStep: 1,
        ),
        //--
        "↓其它↓"
            .text(textAlign: .center, textColor: Colors.purpleAccent)
            .flowLayoutData(weight: 1),
        CustomPaint(
          painter: EulerWavePainter(0),
          size: .infinite,
        ).ratio(1 / 0.3),
        CustomPaint(
          painter: EulerWavePainter(0.25),
          size: .infinite,
        ).ratio(1 / 0.3),
        CustomPaint(
          painter: EulerWavePainter(0.5),
          size: .infinite,
        ).ratio(1 / 0.3),
        CustomPaint(
          painter: EulerWavePainter(0.75),
          size: .infinite,
        ).ratio(1 / 0.3),
        //--
        CustomPaint(
          painter: SpectrumBarsPainter(fftData: generateSimulatedFFT(0)),
          size: .infinite,
        ).ratio(1 / 0.3),
        CustomPaint(
          painter: SpectrumBarsPainter(fftData: generateSimulatedFFT(0.25)),
          size: .infinite,
        ).ratio(1 / 0.3),
        CustomPaint(
          painter: SpectrumBarsPainter(fftData: generateSimulatedFFT(0.5)),
          size: .infinite,
        ).ratio(1 / 0.3),
        CustomPaint(
          painter: SpectrumBarsPainter(fftData: generateSimulatedFFT(0.75)),
          size: .infinite,
        ).ratio(1 / 0.3),
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

  /// 限制x轴绘制的值范围
  final double? xMinValue;
  final double? xMaxValue;

  /// y轴需要绘制刻度的值间隔, 这个值是函数参数的输出值
  final double? yTicksStep;

  /// 限制y轴绘制的值范围
  final double? yMinValue;
  final double? yMaxValue;

  final String? debugLabel;

  const MathFunPaintWidget({
    super.key,
    required this.tex,
    required this.fun,
    this.xSample = 1,
    this.xScale = 1,
    this.yScale = 1,
    this.xTicksStep,
    this.xMinValue,
    this.xMaxValue,
    this.yTicksStep,
    this.yMinValue,
    this.yMaxValue,
    this.debugLabel,
  });

  bool isXValueInRage(double xValue) {
    if (xMinValue != null && xMaxValue != null) {
      return xValue >= xMinValue! && xValue <= xMaxValue!;
    }
    if (xMinValue != null) {
      return xValue >= xMinValue!;
    }
    if (xMaxValue != null) {
      return xValue <= xMaxValue!;
    }
    return true;
  }

  bool isYValueInRage(double yValue) {
    if (yMinValue != null && yMaxValue != null) {
      return yValue >= yMinValue! && yValue <= yMaxValue!;
    }
    if (yMinValue != null) {
      return yValue >= yMinValue!;
    }
    if (yMaxValue != null) {
      return yValue <= yMaxValue!;
    }
    return true;
  }

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
        bool isFirst = true;
        debugger(when: debugLabel != null);
        for (var x = 0; x < xMax; x++) {
          //公式计算
          final xStep = x - xMax / 2;
          final xValue = xStep * xSample;
          final yValue = fun(xValue).ensureValid();
          //绘制点
          final px = cx + xStep * xScale;
          final py = cy - yValue * yScale;
          if (isXValueInRage(xValue) && isYValueInRage(yValue)) {
            if (isFirst) {
              path.moveTo(px, py);
              isFirst = false;
            } else {
              path.lineTo(px, py);
            }
          }
        }
        canvas.drawPath(
          path,
          Paint()
            ..style = .stroke
            ..strokeWidth = 2
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

//MARK: - 复数旋转与波形合成

class EulerWavePainter extends CustomPainter {
  final double animationValue; // 0.0 到 1.0 的动画进度

  EulerWavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.redAccent
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    final centerY = size.height / 2;

    // 1. 原理应用：利用欧拉公式的实部(cos)和虚部(sin)计算坐标
    // 模拟两个频率不同的波形合成（傅里叶级数的简化版）
    for (double x = 0; x <= size.width; x++) {
      // 角度 theta 随 x 坐标和时间（动画）变化
      double theta1 =
          (x / size.width) * 2 * math.pi * 2 + (animationValue * 2 * math.pi);
      double theta2 =
          (x / size.width) * 2 * math.pi * 4 + (animationValue * 4 * math.pi);

      // 根据欧拉公式：y = Im( e^{i*theta1} + 0.5 * e^{i*theta2} )
      // 这里我们取虚部 sin，合并两个正弦波
      double y1 = math.sin(theta1) * 40;
      double y2 = math.sin(theta2) * 20;

      double finalY = centerY + y1 + y2;

      if (x == 0) {
        path.moveTo(x, finalY);
      } else {
        path.lineTo(x, finalY);
      }
    }

    canvas.drawPath(path, paint);

    // 2. 绘制辅助圆（展示复数平面的旋转感）
    _drawRotatingVector(canvas, size, animationValue);
  }

  void _drawRotatingVector(Canvas canvas, Size size, double progress) {
    final center = Offset(60, 60);
    final radius = 40.0;
    final vectorPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3;

    // 欧拉公式旋转向量：z = r * e^{i * theta}
    double theta = progress * 2 * math.pi;
    double dx = radius * math.cos(theta); // 实部
    double dy = radius * math.sin(theta); // 虚部

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.grey.withOpacity(0.2)
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );
    canvas.drawLine(center, center + Offset(dx, dy), vectorPaint);
  }

  @override
  bool shouldRepaint(covariant EulerWavePainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}

//MARK: SpectrumBarsPainter

List<double> generateSimulatedFFT(double time) {
  const int sampleCount = 32; // 32个频率通道
  List<double> data = List.filled(sampleCount, 0.0);

  for (int i = 0; i < sampleCount; i++) {
    // 1. 基础衰减：高频能量通常比低频低 (模拟 1/f 噪声)
    double base = math.exp(-i / 10.0) * 0.7;

    // 2. 模拟节奏：低频区（前几个点）随时间剧烈跳动（模拟鼓点）
    double rhythm = 0.0;
    if (i < 5) {
      rhythm = math.pow(math.sin(time * 5), 2) * 0.3;
    }

    // 3. 模拟旋律：在中频区产生一个随时间移动的峰值
    double melody =
        0.2 * math.exp(-math.pow(i - (15 + 5 * math.sin(time)), 2) / 4);

    // 4. 加上随机扰动：模拟真实采样中的不确定性
    double noise = math.Random().nextDouble() * 0.1;

    // 合成并限制在 0.0 ~ 1.0 之间
    data[i] = (base + rhythm + melody + noise).clamp(0.0, 1.0);
  }
  return data;
}

class SpectrumBarsPainter extends CustomPainter {
  final List<double> fftData; // 模拟 FFT 后的频率模长数据
  final Color barColor;

  SpectrumBarsPainter({
    required this.fftData,
    this.barColor = Colors.redAccent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = barColor
      ..style = PaintingStyle.fill;

    final double barWidth = size.width / fftData.length;
    final double spacing = 2.0; // 柱子间的间距

    for (int i = 0; i < fftData.length; i++) {
      // 这里的 fftData[i] 实际上就是复数 |a + bi| 的模长映射
      // 我们通过欧拉公式的几何映射，将频率能量转换为高度
      double barHeight = fftData[i] * size.height;

      // 计算绘制位置
      double left = i * barWidth + spacing / 2;
      double top = size.height - barHeight;
      double right = (i + 1) * barWidth - spacing / 2;
      double bottom = size.height;

      // 绘制圆角矩形，增加现代感
      canvas.drawRRect(
        RRect.fromLTRBR(left, top, right, bottom, const Radius.circular(4)),
        paint,
      );

      // 增加一个发光层（模拟电子波形的辉光）
      canvas.drawRect(
        Rect.fromLTRB(left, top, right, bottom),
        paint..color = barColor.withOpacity(0.3),
      );
    }
  }

  @override
  bool shouldRepaint(SpectrumBarsPainter oldDelegate) => true;
}
