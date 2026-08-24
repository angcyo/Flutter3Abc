part of '../../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/12/10
///
class PathAbc extends StatefulWidget {
  const PathAbc({super.key});

  @override
  State<PathAbc> createState() => _PathAbcState();
}

class _PathAbcState extends State<PathAbc> with AbsScrollPage {
  String? svgPath;

  @override
  WidgetList? buildScrollBody(BuildContext context) {
    final p1 =
        "m23.167,330.833v-7h4.667v7h5.833v-9.333h3.5l-11.667-10.5-11.667,10.5h3.5v9.333h5.833Z"
            .toUiPath();

    final p2 = Path();
    p2.moveTo(10, 10);
    p2.lineTo(100, 20);
    return [
      [
        PathWidget(
          path: p1,
          shader: sweepGradientShader([
            Colors.blueAccent,
            Colors.redAccent,
          ], rect: p1!.getBounds()),
        ).bounds(),
        //--
        GlowingBorderButton(text: 'Glow Button', onPressed: null),
        //--
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 调用我们自定义的 AI 思考 Loading 动画
            const AiThinkingLoading(),
            const SizedBox(height: 30),
            Text(
              "AI 正在思考中...",
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
                fontWeight: FontWeight.w300,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ).backgroundColor(const Color(0xFF101015)),
        //--
        AiThinkingLoadingFluid(size: 50 /*整体高度，宽度会调整为2倍*/),
        //--
        AiNeuralNetworkLoading(size: 100 /*建议尺寸稍大一些*/),
        //--
        AiBrainRingLoading(),
        AiDnaWaveLoading(),
        AiRippleLoading(),
        AiIntersectSphereLoading(),
        AiSpectrumLoading(),
        AiOrbitFlipLoading(),
        AiNeuralGridLoading(), //√
        AiVectorSweepLoading(),
        AiParticleImplodeLoading(),
        AiAttentionMapLoading(),
        AiNeuroResonanceLoading(),
        AiLogicTreeLoading(),
        AiCube3DGridLoading(), //√
        AiLatentFieldLoading(),
        AiEmbeddingClusterLoading(), //√
        AiNeuralGrid3DLoading(),
        AiNeuralGrid3DLoading2(),
        AiSphereNeuralGrid3DLoading(),
        AiIcosahedron3DLoading(),
        AiHypercube4DLoading(),
        AiDNAHelix3DLoading(),
        AiTorusGrid3DLoading(),
        AiGimbalGyro3DLoading(),
        AiFractalTree3DLoading(),
        AiSwarmCloud3DLoading(),
        AiBlackHole3DLoading(),
        AiMobiusStrip3DLoading(),
        AiCubeMatrix3DLoading(), //√
        AiTesseract3DLoading(),
        AiAtomCore3DLoading(),
        AiTorusKnot3DLoading(), //√
        AiHoloScanner3DLoading(),
      ].flowLayout(gap: kX, padding: insets(all: 20))!,
      HttpDeviceXyzControlWidget().bounds().size(
        size: isDesktopOrWeb ? 400 : null,
      ),
      //--
      Divider(),
      PathWidget(
        path: p2,
        shader: linearGradientShader([
          Colors.blueAccent,
          Colors.redAccent,
        ], rect: p2.getBounds()),
      ).bounds(),
      if (!isNil(svgPath)) svgPath!.text(),
      [
        GradientButton.min(
          child: "each path".text(),
          onTap: () {
            svgPath = stringBuilder((b) {
              p2.eachPathMetrics((
                posIndex,
                ratio,
                contourIndex,
                position,
                angle,
                isClose,
              ) {
                b.append(
                  "[$contourIndex/$posIndex] position:${position.log}, angle:$angle, isClose:$isClose $ratio\n",
                );
              }, 1 /*kPathAcceptableError*/);
            });
            updateState();
          },
        ),
        GradientButton.min(
          child: "each path(async)".text(),
          onTap: () async {
            StringBuffer buffer = StringBuffer();
            await p2.eachPathMetricsAsync((
              posIndex,
              ratio,
              contourIndex,
              position,
              angle,
              isClose,
            ) {
              buffer.write(
                "[$contourIndex/$posIndex] position:${position.log}, angle:$angle, isClose:$isClose $ratio\n",
              );
            }, 1 /*kPathAcceptableError*/);
            svgPath = buffer.toString();
            updateState();
          },
        ),
        GradientButton.min(
          child: "path to svg(async)".text(),
          onTap: () async {
            svgPath = await p2.toSvgPathStringAsync(
              pathStep: kPathAcceptableError,
              tolerance: $lpDeviceKeys.vectorTolerance,
              contourInterval: 1,
              stepInterval: null,
              digits: 3,
            );
            updateState();
          },
        ),
        GradientButton.min(
          child: "path to svg(async)2".text(),
          onTap: () async {
            svgPath = await p2.toSvgPathStringAsync(
              contourInterval: 1,
              stepInterval: null,
              digits: 3,
            );
            updateState();
          },
        ),
        GradientButton.min(
          child: "path to svg(async)3".text(),
          onTap: () async {
            svgPath = await p2.toSvgPathStringAsync(
              contourInterval: null,
              stepInterval: null,
              digits: 3,
            );
            updateState();
          },
        ),
        GradientButton.min(
          child: "path to svg".text(),
          onTap: () {
            svgPath = p2.toSvgPathString(
              pathStep: kPathAcceptableError,
              tolerance: $lpDeviceKeys.vectorTolerance,
              digits: 3,
            );
            updateState();
          },
        ),
        GradientButton.min(
          child: "async loop test".text(),
          onTap: () async {
            StringBuffer buffer = StringBuffer();
            await for (final distance in 100.loop(step: 10, interval: 1)) {
              buffer.write("$distance ");
            }
            svgPath = buffer.toString();
            updateState();
          },
        ),
      ].flowLayout(
        padding: edgeOnly(all: kH),
        childGap: kH,
      )!,
    ];
  }
}

/// 发光边框按钮
class GlowingBorderButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final double borderRadius;

  const GlowingBorderButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width = 200,
    this.height = 60,
    this.borderRadius = 30,
  });

  @override
  State<GlowingBorderButton> createState() => _GlowingBorderButtonState();
}

class _GlowingBorderButtonState extends State<GlowingBorderButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // 创建循环动画控制器
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _GlowingBorderPainter(
            progress: _controller.value,
            borderRadius: widget.borderRadius,
            borderWidth: 2.5,
            glowBlurRadius: 8.0,
            gradientColors: const [
              Colors.transparent,
              /*Colors.greenAccent,
              Colors.blueAccent,*/
              Color(0xFF00F2FE),
              Color(0xFF4FACFE),
              Colors.white, // 头部高亮
            ],
          ),
          child: Container(
            width: widget.width,
            height: widget.height,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black38 /*const Color(0xFF1E1E2C)*/,
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GlowingBorderPainter extends CustomPainter {
  final double progress;
  final double borderRadius;
  final double borderWidth;
  final double glowBlurRadius;
  final List<Color> gradientColors;

  _GlowingBorderPainter({
    required this.progress,
    required this.borderRadius,
    required this.borderWidth,
    required this.glowBlurRadius,
    required this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final RRect rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(borderRadius),
    );

    final Path fullPath = Path()..addRRect(rrect);

    // 1. 获取路径测量对象
    final PathMetrics pathMetrics = fullPath.computeMetrics();
    final Path animatedPath = Path();

    // 假设流光线的长度占总边框长度的 30%
    const double lineLengthFraction = 0.30;

    for (final PathMetric metric in pathMetrics) {
      final double totalLength = metric.length;
      final double currentLength = totalLength * progress;
      final double lineLength = totalLength * lineLengthFraction;

      final double start = currentLength;
      final double end = currentLength + lineLength;

      if (end <= totalLength) {
        // 未跨越终点，直接截取
        animatedPath.addPath(metric.extractPath(start, end), Offset.zero);
      } else {
        // 跨越终点，分两段截取以实现无缝衔接
        animatedPath.addPath(
          metric.extractPath(start, totalLength),
          Offset.zero,
        );
        animatedPath.addPath(
          metric.extractPath(0, end - totalLength),
          Offset.zero,
        );
      }
    }

    // 2. 配置渐变着色器 (使亮端在前，虚化尾部在后)
    final Rect bounds = Offset.zero & size;
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        center: Alignment.center,
        colors: gradientColors,
        transform: GradientRotation(progress * 2 * 3.141592653589793),
      ).createShader(bounds);

    // 3. 绘制发光底影 (Glow Effect)
    final Paint glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth * 2
      ..strokeCap = StrokeCap.round
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, glowBlurRadius)
      ..shader = paint.shader;

    // 先画发光背景，再画核心流光线
    canvas.drawPath(animatedPath, glowPaint);
    canvas.drawPath(animatedPath, paint);
  }

  @override
  bool shouldRepaint(covariant _GlowingBorderPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

/// 通过绘制三个相互绕转、大小和透明度呈周期性变化的圆点，来模拟神经元在后台进行“思考”和“数据交换”的效果。
class AiThinkingLoading extends StatefulWidget {
  final double size;
  final Color color;

  const AiThinkingLoading({
    super.key,
    this.size = 80.0,
    this.color = const Color(0xFF4CAFFF), // 经典的 AI 科技蓝
  });

  @override
  State<AiThinkingLoading> createState() => _AiThinkingLoadingState();
}

class _AiThinkingLoadingState extends State<AiThinkingLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // 定义动画周期，repeat 让他无限循环
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose(); // 释放资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: .center,
            children: List.generate(3, (index) {
              // 核心算法：为三个点计算不同的相位偏移
              // 使得它们在同一时刻状态不同，形成“交错”效果
              final double phaseOffset = index * (2 * math.pi / 3);
              final double animationValue =
                  (_controller.value * 2 * math.pi) + phaseOffset;

              // 1. 计算位置（在圆周上绕转）
              final double radius = widget.size * 0.35; // 旋转半径
              final double x = math.cos(animationValue) * radius;
              final double y = math.sin(animationValue) * radius;

              // 2. 计算大小（周期性变大变小，模拟呼吸/能量波动）
              // 使用 sin 函数将范围控制在 0.5 到 1.0 之间
              final double scale = 0.75 + 0.25 * math.sin(animationValue);

              // 3. 计算透明度（周期性淡入淡出）
              // 使用 sin 函数将范围控制在 0.3 到 0.9 之间
              final double opacity = 0.6 + 0.3 * math.sin(animationValue);

              return Transform.translate(
                offset: Offset(x, y),
                child: Transform.scale(
                  scale: scale,
                  child: Opacity(
                    opacity: opacity,
                    child: Container(
                      width: widget.size * 0.2, // 点的基础大小
                      height: widget.size * 0.2,
                      decoration: BoxDecoration(
                        color: widget.color,
                        shape: BoxShape.circle,
                        // 添加微弱的霓虹灯发光效果
                        boxShadow: [
                          BoxShadow(
                            color: widget.color.withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

/// 流体神经元 Loading（推荐，纯 Widget 实现）
class AiThinkingLoadingFluid extends StatefulWidget {
  final double size;
  final Color baseColor;
  final Color highlightColor;

  const AiThinkingLoadingFluid({
    Key? key,
    this.size = 60.0,
    this.baseColor = const Color(0xFF3A86FF), // 科技蓝
    this.highlightColor = const Color(0xFF8338EC), // 智慧紫
  }) : super(key: key);

  @override
  State<AiThinkingLoadingFluid> createState() => _AiThinkingLoadingFluidState();
}

class _AiThinkingLoadingFluidState extends State<AiThinkingLoadingFluid>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000), // 整个周期
    )..repeat(); // 无限循环
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size * 2,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 1. 底部的流光渐变层
          _buildShimmerGradient(),

          // 2. 顶部的错峰缩放圆点层
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              return _buildPulsingDot(index);
            }),
          ),
        ],
      ),
    );
  }

  // 构建流光渐变 (使用ShaderMask)
  Widget _buildShimmerGradient() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: const [0.0, 0.5, 1.0],
              // 关键：让渐变随时间平移
              transform: _SlideGradientTransform(percentage: _controller.value),
            ).createShader(rect);
          },
          blendMode: BlendMode.srcIn,
          child: Container(
            width: widget.size * 2,
            height: widget.size / 2,
            decoration: BoxDecoration(
              color: Colors.white, // 作为Shader的载体，颜色不重要
              borderRadius: BorderRadius.circular(widget.size / 4),
            ),
          ),
        );
      },
    );
  }

  // 构建单个缩放圆点
  Widget _buildPulsingDot(int index) {
    // 为每个圆点创建错开的动画区间
    // 比如：点1(0.0-0.5), 点2(0.1-0.6), 点3(0.2-0.7)...
    final Animation<double> scaleAnimation =
        TweenSequence([
          TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.5), weight: 50),
          TweenSequenceItem(tween: Tween(begin: 1.5, end: 1.0), weight: 50),
        ]).animate(
          CurvedAnimation(
            parent: _controller,
            // 使用 Interval 实现错峰
            curve: Interval(
              (index * 0.15).clamp(0.0, 1.0),
              (0.6 + index * 0.1).clamp(0.0, 1.0),
              curve: Curves.easeInOut,
            ),
          ),
        );

    return AnimatedBuilder(
      animation: scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: scaleAnimation.value,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: widget.size / 10),
            width: widget.size / 5,
            height: widget.size / 5,
            decoration: const BoxDecoration(
              color: Colors.white, // 这里设为白色，会被底部的ShaderMask着色
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.white24,
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// 辅助类：用于平移 Gradient 的 Transform
class _SlideGradientTransform extends GradientTransform {
  final double percentage;

  const _SlideGradientTransform({required this.percentage});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    // 计算平移矩阵：在 X 轴上平移 bounds.width 的距离
    return Matrix4.translationValues(
      bounds.width * 2 * (percentage - 0.5),
      0,
      0,
    );
  }
}

/// 脉冲神经网络 Loading（进阶，CustomPainter 实现）
class AiNeuralNetworkLoading extends StatefulWidget {
  final double size;
  final Color color;

  const AiNeuralNetworkLoading({
    Key? key,
    this.size = 100.0,
    this.color = const Color(0xFF00C853), // 活力绿/科技蓝
  }) : super(key: key);

  @override
  State<AiNeuralNetworkLoading> createState() => _AiNeuralNetworkLoadingState();
}

class _AiNeuralNetworkLoadingState extends State<AiNeuralNetworkLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _NeuralNetworkPainter(
            animationValue: _controller.value,
            color: widget.color,
          ),
        );
      },
    );
  }
}

class _NeuralNetworkPainter extends CustomPainter {
  final double animationValue;
  final Color color;

  _NeuralNetworkPainter({required this.animationValue, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint nodePaint = Paint()
      ..color = color.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    final Paint linePaint = Paint()
      ..color = color.withOpacity(0.2)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final Paint pulsePaint = Paint()
      ..color = color
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // 1. 定义神经元节点位置 (相对于 size)
    final List<Offset> nodes = [
      Offset(size.width * 0.15, size.height * 0.15), // Top Left
      Offset(size.width * 0.85, size.height * 0.15), // Top Right
      Offset(size.width * 0.5, size.height * 0.5), // Center
      Offset(size.width * 0.15, size.height * 0.85), // Bottom Left
      Offset(size.width * 0.85, size.height * 0.85), // Bottom Right
    ];

    // 2. 绘制静态连接线
    canvas.drawLine(nodes[0], nodes[2], linePaint);
    canvas.drawLine(nodes[1], nodes[2], linePaint);
    canvas.drawLine(nodes[3], nodes[2], linePaint);
    canvas.drawLine(nodes[4], nodes[2], linePaint);

    // 3. 绘制节点
    for (var node in nodes) {
      // 节点随动画微小缩放
      final double pulseSize =
          2.0 * math.sin(animationValue * 2 * math.pi) + 4.0;
      canvas.drawCircle(node, pulseSize, nodePaint);

      // 节点外围光晕
      canvas.drawCircle(
        node,
        pulseSize + 4,
        nodePaint..color = color.withOpacity(0.1),
      );
    }

    // 4. 绘制能量脉冲 (从外围流向中心)
    for (int i = 0; i < 4; i++) {
      int outerNodeIndex = (i < 2) ? i : i + 1; // 避开中心节点 index=2

      // 错开脉冲时间
      double startPercent = (i * 0.25);
      double endPercent = (startPercent + 0.5) % 1.0;

      // 计算当前脉冲在线段上的起点和终点
      double pathValue = (animationValue - startPercent) / 0.5;
      if (pathValue >= 0 && pathValue <= 1.0) {
        Offset startOffset = nodes[outerNodeIndex];
        Offset endOffset = nodes[2];

        // 使用 PathMeasure 可以实现更复杂的路径脉冲，这里使用简单的线段插值
        Offset currentPulseStart = Offset.lerp(
          startOffset,
          endOffset,
          pathValue.clamp(0.0, 0.8),
        )!;
        Offset currentPulseEnd = Offset.lerp(
          startOffset,
          endOffset,
          pathValue.clamp(0.2, 1.0),
        )!;

        // 脉冲颜色渐变 (淡入淡出)
        double opacity = math.sin(pathValue * math.pi);
        canvas.drawLine(
          currentPulseStart,
          currentPulseEnd,
          pulsePaint..color = color.withOpacity(opacity),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _NeuralNetworkPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.color != color;
  }
}

/// 神经脉冲与算力环（CustomPainter + 光晕）
class AiBrainRingLoading extends StatefulWidget {
  final double size;

  const AiBrainRingLoading({super.key, this.size = 90.0});

  @override
  State<AiBrainRingLoading> createState() => _AiBrainRingLoadingState();
}

class _AiBrainRingLoadingState extends State<AiBrainRingLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _AiBrainRingPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _AiBrainRingPainter extends CustomPainter {
  final double progress;

  _AiBrainRingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;

    // 1. 绘制底层淡色轨环
    final trackPaint = Paint()
      ..color = const Color(0xFF6366F1).withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawCircle(center, radius, trackPaint);

    // 2. 绘制旋转的流光渐变圆弧
    final sweepAngle = math.pi * 0.8;
    final startAngle = progress * 2 * math.pi;

    final arcGradient = SweepGradient(
      colors: const [Color(0x006366F1), Color(0xFF818CF8), Color(0xFFC084FC)],
      stops: const [0.0, 0.5, 1.0],
      transform: GradientRotation(startAngle),
    );

    final arcPaint = Paint()
      ..shader = arcGradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.5;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      arcPaint,
    );

    // 3. 绘制中心微光的 AI 核心（呼吸效果）
    final corePulse = 0.5 + 0.5 * math.sin(progress * 2 * math.pi);
    final coreRadius = (size.width * 0.12) + (corePulse * 3);

    final coreGlowPaint = Paint()
      ..color = const Color(0xFFA855F7).withOpacity(0.3 + corePulse * 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final corePaint = Paint()
      ..color = const Color(0xFFC084FC)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, coreRadius + 4, coreGlowPaint);
    canvas.drawCircle(center, coreRadius, corePaint);
  }

  @override
  bool shouldRepaint(covariant _AiBrainRingPainter oldDelegate) => true;
}

/// 双螺旋神经网络折叠（DNA/Data Stream 风格）
class AiDnaWaveLoading extends StatefulWidget {
  final double width;
  final double height;

  const AiDnaWaveLoading({super.key, this.width = 120.0, this.height = 40.0});

  @override
  State<AiDnaWaveLoading> createState() => _AiDnaWaveLoadingState();
}

class _AiDnaWaveLoadingState extends State<AiDnaWaveLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(6, (index) {
              // 计算各个节点的位置偏置
              final progress = _controller.value * 2 * math.pi;
              final nodeOffset = index * (math.pi / 3);

              // 上下节点的交错 Y 轴位移
              final y1 = math.sin(progress + nodeOffset) * (widget.height / 3);
              final y2 =
                  math.sin(progress + nodeOffset + math.pi) *
                  (widget.height / 3);

              // 节点的动态透明度和缩放
              final opacity =
                  0.4 + 0.6 * ((math.sin(progress + nodeOffset) + 1) / 2);

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.translate(
                    offset: Offset(0, y1),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Color.lerp(
                          Colors.cyanAccent,
                          Colors.blueAccent,
                          index / 5,
                        )?.withOpacity(opacity),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, y2),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Color.lerp(
                          Colors.purpleAccent,
                          Colors.pinkAccent,
                          index / 5,
                        )?.withOpacity(1.0 - opacity + 0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              );
            }),
          );
        },
      ),
    );
  }
}

/// 多重波纹发光扩散（Ripple Spectrum 风格）
class AiRippleLoading extends StatefulWidget {
  final double size;

  const AiRippleLoading({super.key, this.size = 100.0});

  @override
  State<AiRippleLoading> createState() => _AiRippleLoadingState();
}

class _AiRippleLoadingState extends State<AiRippleLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: List.generate(3, (index) {
              // 错开 3 个波纹的动画进度
              final delay = index * 0.333;
              double progress = _controller.value - delay;
              if (progress < 0) progress += 1.0;

              // 扩散半径与透明度曲线
              final scale = progress;
              final opacity = (1.0 - progress).clamp(0.0, 1.0);

              return Transform.scale(
                scale: scale,
                child: Opacity(
                  opacity: opacity,
                  child: Container(
                    width: widget.size,
                    height: widget.size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF3B82F6),
                        width: 2.0,
                      ),
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFF60A5FA).withOpacity(0.3),
                          const Color(0xFF3B82F6).withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

/// 神经交错光球（Matrix Intersect 风格）
class AiIntersectSphereLoading extends StatefulWidget {
  final double size;

  const AiIntersectSphereLoading({super.key, this.size = 80.0});

  @override
  State<AiIntersectSphereLoading> createState() =>
      _AiIntersectSphereLoadingState();
}

class _AiIntersectSphereLoadingState extends State<AiIntersectSphereLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final progress = _controller.value * 2 * math.pi;
        final radius = widget.size * 0.28;

        // 两球围绕中心的交错运动轨迹
        final dx1 = math.cos(progress) * radius;
        final dy1 = math.sin(progress * 2) * (radius * 0.5); // 8字形轨迹

        final dx2 = math.cos(progress + math.pi) * radius;
        final dy2 = math.sin((progress + math.pi) * 2) * (radius * 0.5);

        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 球体 A：紫色光球
              Transform.translate(
                offset: Offset(dx1, dy1),
                child: _buildGlowOrb(
                  size: widget.size * 0.35,
                  color: const Color(0xFFA855F7),
                ),
              ),
              // 球体 B：青色光球
              Transform.translate(
                offset: Offset(dx2, dy2),
                child: _buildGlowOrb(
                  size: widget.size * 0.35,
                  color: const Color(0xFF06B6D4),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGlowOrb({required double size, required Color color}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.6),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}

/// 算力跳动音频/数据频谱（Equilizer Spectrum 风格）
class AiSpectrumLoading extends StatefulWidget {
  final double height;
  final Color color;

  const AiSpectrumLoading({
    super.key,
    this.height = 30.0,
    this.color = const Color(0xFF6366F1),
  });

  @override
  State<AiSpectrumLoading> createState() => _AiSpectrumLoadingState();
}

class _AiSpectrumLoadingState extends State<AiSpectrumLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: .min,
          crossAxisAlignment: .center,
          children: List.generate(5, (index) {
            // 为每一根柱子生成不同相位的频率跳动
            final phase = index * (math.pi / 4);
            final value = math.sin((_controller.value * 2 * math.pi) + phase);

            // 将跳动范围映射到 0.2 ~ 1.0 的高度缩放
            final barHeight = widget.height * (0.2 + 0.8 * ((value + 1) / 2));

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2.5),
              width: 3.5,
              height: barHeight,
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.5 + 0.5 * ((value + 1) / 2)),
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        );
      },
    );
  }
}

/// 多重同心圆卡牌翻转（Orbit Flip 风格）
class AiOrbitFlipLoading extends StatefulWidget {
  final double size;

  const AiOrbitFlipLoading({super.key, this.size = 70.0});

  @override
  State<AiOrbitFlipLoading> createState() => _AiOrbitFlipLoadingState();
}

class _AiOrbitFlipLoadingState extends State<AiOrbitFlipLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final angle = _controller.value * 2 * math.pi;

        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 外层 X 轴翻转环
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.002) // 增加 3D 透视视差
                  ..rotateX(angle),
                alignment: Alignment.center,
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFEC4899).withOpacity(0.7),
                      width: 2,
                    ),
                  ),
                ),
              ),

              // 内层 Y 轴翻转环（反向旋转）
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.002)
                  ..rotateY(-angle * 1.2),
                alignment: Alignment.center,
                child: Container(
                  width: widget.size * 0.65,
                  height: widget.size * 0.65,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF3B82F6).withOpacity(0.8),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// 神经网络节点激活（Neural Grid Matrix）
class AiNeuralGridLoading extends StatefulWidget {
  final double size;

  const AiNeuralGridLoading({super.key, this.size = 90.0});

  @override
  State<AiNeuralGridLoading> createState() => _AiNeuralGridLoadingState();
}

class _AiNeuralGridLoadingState extends State<AiNeuralGridLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _NeuralGridPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _NeuralGridPainter extends CustomPainter {
  final double progress;

  _NeuralGridPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final count = 6; // 节点的数量
    final radius = size.width * 0.38;

    final nodePaint = Paint()..style = PaintingStyle.fill;
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    List<Offset> nodes = [];

    // 1. 计算分布在圆周上的节点位置
    for (int i = 0; i < count; i++) {
      final angle = (i * 2 * math.pi / count) + (progress * 2 * math.pi * 0.2);
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      nodes.add(Offset(x, y));
    }

    // 2. 绘制节点之间的连线（根据相位计算透明度，模拟信号传输）
    for (int i = 0; i < count; i++) {
      for (int j = i + 1; j < count; j++) {
        final phase = (i + j) * 0.5 + progress * 2 * math.pi;
        final opacity = (0.1 + 0.4 * math.sin(phase)).clamp(0.05, 0.5);
        linePaint.color = const Color(0xFF6366F1).withOpacity(opacity);
        canvas.drawLine(nodes[i], nodes[j], linePaint);
      }
    }

    // 3. 绘制节点本身（闪烁呼吸效果）
    for (int i = 0; i < count; i++) {
      final nodePhase = i * 0.8 + progress * 2 * math.pi;
      final nodeOpacity = (0.3 + 0.7 * math.sin(nodePhase)).clamp(0.2, 1.0);
      final nodeRadius = 3.0 + 2.0 * math.sin(nodePhase);

      nodePaint.color = Color.lerp(
        const Color(0xFF818CF8),
        const Color(0xFFC084FC),
        (math.sin(nodePhase) + 1) / 2,
      )!.withOpacity(nodeOpacity);

      canvas.drawCircle(nodes[i], nodeRadius, nodePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _NeuralGridPainter oldDelegate) => true;
}

/// 向量检索雷达扫描（RAG Vector Sweep）
class AiVectorSweepLoading extends StatefulWidget {
  final double size;

  const AiVectorSweepLoading({super.key, this.size = 85.0});

  @override
  State<AiVectorSweepLoading> createState() => _AiVectorSweepLoadingState();
}

class _AiVectorSweepLoadingState extends State<AiVectorSweepLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _VectorSweepPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _VectorSweepPainter extends CustomPainter {
  final double progress;

  _VectorSweepPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    // 1. 绘制网格背景圈
    final bgPaint = Paint()
      ..color = const Color(0xFF38BDF8).withOpacity(0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawCircle(center, radius, bgPaint);
    canvas.drawCircle(center, radius * 0.5, bgPaint);

    // 2. 绘制 360 度旋转的扫描扇形渐变
    final currentAngle = progress * 2 * math.pi;
    final sweepGradient = SweepGradient(
      colors: const [Colors.transparent, Color(0x2238BDF8), Color(0xFF38BDF8)],
      stops: const [0.0, 0.75, 1.0],
      transform: GradientRotation(currentAngle - math.pi / 2),
    );

    final sweepPaint = Paint()
      ..shader = sweepGradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..style = PaintingStyle.fill;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      currentAngle - math.pi / 2,
      math.pi / 2, // 扇形覆盖 90 度
      true,
      sweepPaint,
    );

    // 3. 绘制扫描线前沿
    final linePaint = Paint()
      ..color = const Color(0xFF38BDF8)
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final lineEnd = Offset(
      center.dx + radius * math.cos(currentAngle),
      center.dy + radius * math.sin(currentAngle),
    );
    canvas.drawLine(center, lineEnd, linePaint);
  }

  @override
  bool shouldRepaint(covariant _VectorSweepPainter oldDelegate) => true;
}

/// 算力向心坍缩粒子（Entropy Convergence）
class AiParticleImplodeLoading extends StatefulWidget {
  final double size;

  const AiParticleImplodeLoading({super.key, this.size = 80.0});

  @override
  State<AiParticleImplodeLoading> createState() =>
      _AiParticleImplodeLoadingState();
}

class _AiParticleImplodeLoadingState extends State<AiParticleImplodeLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _ParticleImplodePainter(progress: _controller.value),
        );
      },
    );
  }
}

class _ParticleImplodePainter extends CustomPainter {
  final double progress;

  _ParticleImplodePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;
    final particleCount = 8;

    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < particleCount; i++) {
      // 错开每个粒子的进场时间
      final particleDelay = i / particleCount;
      double pProgress = progress - particleDelay;
      if (pProgress < 0) pProgress += 1.0;

      // 向心坍缩：半径随时间减小，同时伴随旋转
      final currentRadius = maxRadius * (1.0 - pProgress);
      final angle =
          (i * (2 * math.pi / particleCount)) + (pProgress * math.pi * 2);

      final x = center.dx + currentRadius * math.cos(angle);
      final y = center.dy + currentRadius * math.sin(angle);

      // 距离中心越近，粒子越亮越小
      final opacity = math.sin(pProgress * math.pi); // 边缘淡入，中心淡出
      final pSize = 2.0 + 3.0 * (1.0 - pProgress);

      paint.color = Color.lerp(
        const Color(0xFF38BDF8),
        const Color(0xFFEC4899),
        pProgress,
      )!.withOpacity(opacity.clamp(0.0, 1.0));

      canvas.drawCircle(Offset(x, y), pSize, paint);
    }

    // 中心绘制一个稳定的微光核心点
    paint.color = const Color(0xFFEC4899).withOpacity(0.8);
    canvas.drawCircle(center, 3.5, paint);
  }

  @override
  bool shouldRepaint(covariant _ParticleImplodePainter oldDelegate) => true;
}

/// Transformer 交叉注意力网络 (Attention Mechanism Map)
class AiAttentionMapLoading extends StatefulWidget {
  final double size;

  const AiAttentionMapLoading({super.key, this.size = 110.0});

  @override
  State<AiAttentionMapLoading> createState() => _AiAttentionMapLoadingState();
}

class _AiAttentionMapLoadingState extends State<AiAttentionMapLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _AttentionMapPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _AttentionMapPainter extends CustomPainter {
  final double progress;

  _AttentionMapPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final topLayerCount = 5;
    final bottomLayerCount = 8;
    final nodeRadius = 3.0;

    final nodePaint = Paint()..style = PaintingStyle.fill;
    final attentionPaint = Paint()..style = PaintingStyle.stroke;

    List<Offset> topNodes = [];
    List<Offset> bottomNodes = [];

    final topLayerY = size.height * 0.25;
    final bottomLayerY = size.height * 0.75;
    final topSpacing = size.width / (topLayerCount + 1);
    final bottomSpacing = size.width / (bottomLayerCount + 1);

    // 1. 计算和绘制层节点
    for (int i = 0; i < topLayerCount; i++) {
      topNodes.add(Offset((i + 1) * topSpacing, topLayerY));
      nodePaint.color = const Color(0xFFC084FC).withOpacity(0.8);
      canvas.drawCircle(topNodes.last, nodeRadius, nodePaint);
    }
    for (int i = 0; i < bottomLayerCount; i++) {
      bottomNodes.add(Offset((i + 1) * bottomSpacing, bottomLayerY));
      nodePaint.color = const Color(0xFF6366F1).withOpacity(0.8);
      canvas.drawCircle(bottomNodes.last, nodeRadius, nodePaint);
    }

    // 2. 绘制交叉注意力连线 (Attention Weights)
    // 连线的透明度和强度取决于时间相位和随机性，模拟注意力的动态选择
    for (int i = 0; i < topLayerCount; i++) {
      for (int j = 0; j < bottomLayerCount; j++) {
        final phase = (i + j) * 0.4 + progress * 2 * math.pi;

        // 模拟随机的高注意力权重出现（只有强关联的连线才显示）
        double attentionScore = (math.sin(phase) + 1) / 2;
        if (attentionScore > 0.7) {
          final opacity = (attentionScore - 0.7) / 0.3; // 归一化到 0.0 - 1.0

          attentionPaint
            ..color = const Color(0xFF818CF8).withOpacity(opacity * 0.4)
            ..strokeWidth = 1.0 + opacity * 2.0;

          // 绘制一个带弯曲的路径，而不是直线，更具柔性
          final path = Path()
            ..moveTo(topNodes[i].dx, topNodes[i].dy + nodeRadius)
            ..quadraticBezierTo(
              (topNodes[i].dx + bottomNodes[j].dx) / 2,
              center.dy, // 控制点在中心
              bottomNodes[j].dx,
              bottomNodes[j].dy - nodeRadius,
            );
          canvas.drawPath(path, attentionPaint);

          // 3. 在强注意力的末端绘制一个激活点
          nodePaint.color = Colors.white.withOpacity(opacity * 0.9);
          canvas.drawCircle(
            bottomNodes[j],
            nodeRadius + opacity * 1.5,
            nodePaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _AttentionMapPainter oldDelegate) => true;
}

/// 算力脑波共鸣 (Neuro-Resonance Spectrum)
class AiNeuroResonanceLoading extends StatefulWidget {
  final double size;

  const AiNeuroResonanceLoading({super.key, this.size = 100.0});

  @override
  State<AiNeuroResonanceLoading> createState() =>
      _AiNeuroResonanceLoadingState();
}

class _AiNeuroResonanceLoadingState extends State<AiNeuroResonanceLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000), // 缓慢有节奏
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _NeuroResonancePainter(progress: _controller.value),
        );
      },
    );
  }
}

class _NeuroResonancePainter extends CustomPainter {
  final double progress;

  _NeuroResonancePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final ringCount = 3; // 三层同心圆结构
    final lineCount = 8; // 辐射连线数量
    final maxRadius = size.width / 2;

    final linePaint = Paint()
      ..color = const Color(0xFF6366F1).withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final nodePaint = Paint()..style = PaintingStyle.fill;

    // 1. 绘制辐射神经连线
    for (int i = 0; i < lineCount; i++) {
      final angle = (i * 2 * math.pi / lineCount) + (progress * 0.2 * math.pi);
      final lineEnd = Offset(
        center.dx + maxRadius * math.cos(angle),
        center.dy + maxRadius * math.sin(angle),
      );
      canvas.drawLine(center, lineEnd, linePaint);

      // 2. 在不同的圆环（层）上绘制沿波浪跳动的激活点
      for (int ring = 1; ring <= ringCount; ring++) {
        final ringRadius = maxRadius * (ring / (ringCount + 1));

        // 核心算法：点的相位受 径向距离、角度、时间 共同驱动，形成螺旋传播的波浪效果
        final pointPhase =
            (angle * 2) + (ring * math.pi / 2) + progress * 2 * math.pi;
        final isActive = math.sin(pointPhase);

        // 只有当正弦波达到一定强度时（激活状态），才绘制点
        if (isActive > 0.5) {
          final opacity = (isActive - 0.5) / 0.5; // 0.0 - 1.0
          final pointRadius = 2.0 + opacity * 2.0;

          // 核心点到边缘的颜色渐变：紫 -> 蓝 -> 青
          final pointColor = Color.lerp(
            Color.lerp(
              const Color(0xFFA855F7),
              const Color(0xFF6366F1),
              ring / ringCount,
            ),
            const Color(0xFF38BDF8),
            ring / ringCount,
          )!.withOpacity(opacity * 0.9);

          final nodeOffset = Offset(
            center.dx + (ringRadius + isActive * 5.0) * math.cos(angle),
            // 带轻微径向跳动
            center.dy + (ringRadius + isActive * 5.0) * math.sin(angle),
          );

          nodePaint.color = pointColor;
          canvas.drawCircle(nodeOffset, pointRadius, nodePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _NeuroResonancePainter oldDelegate) => true;
}

/// 分形逻辑树探索 (Fractal Logic Tree Exploration)
class AiLogicTreeLoading extends StatefulWidget {
  final double size;

  const AiLogicTreeLoading({super.key, this.size = 120.0});

  @override
  State<AiLogicTreeLoading> createState() => _AiLogicTreeLoadingState();
}

class _AiLogicTreeLoadingState extends State<AiLogicTreeLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _LogicTreePainter(progress: _controller.value),
        );
      },
    );
  }
}

class _LogicTreePainter extends CustomPainter {
  final double progress;

  _LogicTreePainter({required this.progress});

  final Color branchColor = const Color(0xFF6366F1);
  final Color nodeColor = const Color(0xFFC084FC);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxLevel = 4; // 分形层级

    _drawBranch(canvas, center, -math.pi / 2, size.width / 4, 1, maxLevel);
  }

  // 分形绘制函数
  void _drawBranch(
    Canvas canvas,
    Offset start,
    double angle,
    double length,
    int level,
    int maxLevel,
  ) {
    if (level > maxLevel) return;

    // 1. 计算当前分支终点
    final end = Offset(
      start.dx + length * math.cos(angle),
      start.dy + length * math.sin(angle),
    );

    // 2. 绘制分支连线 (透明度和粗细随层级和时间相位变化)
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (maxLevel - level) * 0.8 + 0.5;

    // 核心算法：分支的激活状态随层级和相位缓慢传播，模拟逻辑推理
    final phase = level * 1.5 + progress * 2 * math.pi;
    final activity = (math.sin(phase) + 1) / 2; // 0.0 - 1.0

    // 将颜色从蓝逐渐lerp到紫，模拟推理过程中的语义变化
    linePaint.color = Color.lerp(
      branchColor,
      nodeColor,
      level / maxLevel,
    )!.withOpacity(0.05 + activity * 0.5); // 缓慢闪烁

    canvas.drawLine(start, end, linePaint);

    // 3. 在终点绘制神经节点 (仅激活状态)
    if (activity > 0.6) {
      final nodeOpacity = (activity - 0.6) / 0.4;
      final nodePaint = Paint()
        ..color = Colors.white.withOpacity(nodeOpacity * 0.8)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(end, 2.0 + nodeOpacity * 1.5, nodePaint);
    }

    // 4. 递归绘制两个子分支 (分形角度随时间相位变化)
    final nextLevel = level + 1;
    final nextLength = length * 0.75; // 分支长度衰减
    final spreadAngle =
        math.pi / 4 + 0.1 * math.sin(progress * 2 * math.pi); // 动态偏角

    // 左分支
    _drawBranch(
      canvas,
      end,
      angle - spreadAngle,
      nextLength,
      nextLevel,
      maxLevel,
    );
    // 右分支
    _drawBranch(
      canvas,
      end,
      angle + spreadAngle,
      nextLength,
      nextLevel,
      maxLevel,
    );
  }

  @override
  bool shouldRepaint(covariant _LogicTreePainter oldDelegate) => true;
}

/// 3D 旋转超三维向量网格 (Hypercube Net 3D)
class AiCube3DGridLoading extends StatefulWidget {
  final double size;

  const AiCube3DGridLoading({super.key, this.size = 100.0});

  @override
  State<AiCube3DGridLoading> createState() => _AiCube3DGridLoadingState();
}

class _AiCube3DGridLoadingState extends State<AiCube3DGridLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _Cube3DPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _Cube3DPainter extends CustomPainter {
  final double progress;

  _Cube3DPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final side = size.width * 0.28;

    // 8 个顶点三维空间原始坐标 [-1, 1]
    final List<List<double>> rawVertices = [
      [-1, -1, -1],
      [1, -1, -1],
      [1, 1, -1],
      [-1, 1, -1],
      [-1, -1, 1],
      [1, -1, 1],
      [1, 1, 1],
      [-1, 1, 1],
    ];

    // 立方体 12 条边连线索引表
    final List<List<int>> edges = [
      [0, 1],
      [1, 2],
      [2, 3],
      [3, 0],
      [4, 5],
      [5, 6],
      [6, 7],
      [7, 4],
      [0, 4],
      [1, 5],
      [2, 6],
      [3, 7],
    ];

    final angleX = progress * 2 * math.pi;
    final angleY = progress * 2 * math.pi * 0.5;

    // 1. 三维旋转变换（Rotate X & Y）
    List<List<double>> rotated = [];
    for (var v in rawVertices) {
      // Y 轴旋转
      double x1 = v[0] * math.cos(angleY) + v[2] * math.sin(angleY);
      double y1 = v[1];
      double z1 = -v[0] * math.sin(angleY) + v[2] * math.cos(angleY);

      // X 轴旋转
      double x2 = x1;
      double y2 = y1 * math.cos(angleX) - z1 * math.sin(angleX);
      double z2 = y1 * math.sin(angleX) + z1 * math.cos(angleX);

      rotated.add([x2 * side, y2 * side, z2 * side]);
    }

    // 2. 透视投影（Perspective Projection 到 2D 屏幕）
    final fov = 200.0;
    List<Offset> points2D = [];
    List<double> zDepths = [];

    for (var r in rotated) {
      double z = r[2] + fov;
      double scale = fov / z;
      double x2d = center.dx + r[0] * scale;
      double y2d = center.dy + r[1] * scale;
      points2D.add(Offset(x2d, y2d));
      zDepths.add(z);
    }

    final linePaint = Paint()..style = PaintingStyle.stroke;
    final nodePaint = Paint()..style = PaintingStyle.fill;

    // 3. 绘制 3D 棱边连线
    for (var edge in edges) {
      int idxA = edge[0];
      int idxB = edge[1];
      double avgZ = (zDepths[idxA] + zDepths[idxB]) / 2;

      // 根据 Z 轴深度调整连线透明度与粗细，产生前后透视深度感
      double depthFactor = (fov + side - avgZ) / (2 * side);
      depthFactor = depthFactor.clamp(0.15, 1.0);

      linePaint
        ..color = const Color(0xFF6366F1).withOpacity(depthFactor * 0.7)
        ..strokeWidth = 1.0 + depthFactor * 1.5;

      canvas.drawLine(points2D[idxA], points2D[idxB], linePaint);
    }

    // 4. 绘制 3D 神经网络节点（前亮后暗）
    for (int i = 0; i < points2D.length; i++) {
      double depthFactor = (fov + side - zDepths[i]) / (2 * side);
      depthFactor = depthFactor.clamp(0.2, 1.0);

      nodePaint.color = Color.lerp(
        const Color(0xFF818CF8),
        const Color(0xFFC084FC),
        depthFactor,
      )!.withOpacity(depthFactor);

      canvas.drawCircle(points2D[i], 2.0 + depthFactor * 2.5, nodePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _Cube3DPainter oldDelegate) => true;
}

/// 生成式神经拓扑场 (GAN Dynamic Topo-Field)
class AiLatentFieldLoading extends StatefulWidget {
  final double size;

  const AiLatentFieldLoading({super.key, this.size = 110.0});

  @override
  State<AiLatentFieldLoading> createState() => _AiLatentFieldLoadingState();
}

class _AiLatentFieldLoadingState extends State<AiLatentFieldLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _LatentFieldPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _LatentFieldPainter extends CustomPainter {
  final double progress;

  _LatentFieldPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final count = 10;
    final maxDist = size.width * 0.42;

    List<Offset> nodes = [];

    // 1. 利用 Lissajous 曲线公式生成有引力感、流体感的不规则节点轨迹
    for (int i = 0; i < count; i++) {
      final a = 2.0 + (i % 3);
      final b = 3.0 + (i % 2);
      final delta = (i * math.pi / count) + progress * 2 * math.pi;

      final x = center.dx + (size.width * 0.35) * math.sin(a * delta);
      final y =
          center.dy + (size.height * 0.35) * math.sin(b * delta + (i * 0.5));
      nodes.add(Offset(x, y));
    }

    final linePaint = Paint()..style = PaintingStyle.stroke;
    final nodePaint = Paint()..style = PaintingStyle.fill;

    // 2. 距离临界检定：当两点距离小于阈值时瞬间激活连接触突
    for (int i = 0; i < count; i++) {
      for (int j = i + 1; j < count; j++) {
        final dist = (nodes[i] - nodes[j]).distance;

        if (dist < maxDist) {
          final intensity = (1.0 - (dist / maxDist)).clamp(0.0, 1.0);

          linePaint
            ..color = Color.lerp(
              const Color(0xFF38BDF8),
              const Color(0xFFC084FC),
              intensity,
            )!.withOpacity(intensity * 0.6)
            ..strokeWidth = intensity * 2.0;

          canvas.drawLine(nodes[i], nodes[j], linePaint);
        }
      }
    }

    // 3. 绘制触突核心点
    for (int i = 0; i < count; i++) {
      final pulse = (math.sin(progress * 2 * math.pi + i) + 1) / 2;
      nodePaint.color = Color.lerp(
        const Color(0xFF818CF8),
        Colors.white,
        pulse,
      )!.withOpacity(0.7 + pulse * 0.3);

      canvas.drawCircle(nodes[i], 2.0 + pulse * 2.0, nodePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _LatentFieldPainter oldDelegate) => true;
}

/// 超图节点降维坍缩 (Hyper-Graph Manifold Fold)
class AiEmbeddingClusterLoading extends StatefulWidget {
  final double size;

  const AiEmbeddingClusterLoading({super.key, this.size = 100.0});

  @override
  State<AiEmbeddingClusterLoading> createState() =>
      _AiEmbeddingClusterLoadingState();
}

class _AiEmbeddingClusterLoadingState extends State<AiEmbeddingClusterLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _EmbeddingClusterPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _EmbeddingClusterPainter extends CustomPainter {
  final double progress;

  _EmbeddingClusterPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerCount = 7;
    final outerRadius = size.width * 0.42;

    final nodePaint = Paint()..style = PaintingStyle.fill;
    final pathPaint = Paint()..style = PaintingStyle.stroke;

    // 1. 绘制外层高维稀疏点
    List<Offset> outerNodes = [];
    for (int i = 0; i < outerCount; i++) {
      final angle = (i * 2 * math.pi / outerCount) + (progress * 0.5 * math.pi);
      final x = center.dx + outerRadius * math.cos(angle);
      final y = center.dy + outerRadius * math.sin(angle);
      outerNodes.add(Offset(x, y));

      nodePaint.color = const Color(0xFF818CF8).withOpacity(0.5);
      canvas.drawCircle(outerNodes.last, 2.5, nodePaint);
    }

    // 2. 绘制从外层稀疏节点向中心核心超点收敛的弯曲传输弧线
    for (int i = 0; i < outerCount; i++) {
      // 错开传输相位
      final phase = (i * 0.6) + progress * 2 * math.pi;
      final flowIntensity = (math.sin(phase) + 1) / 2;

      pathPaint
        ..color = const Color(
          0xFFC084FC,
        ).withOpacity(0.15 + flowIntensity * 0.5)
        ..strokeWidth = 1.0 + flowIntensity * 1.5;

      // 贝塞尔曲线控制点：让能量束呈现向心旋涡弧度
      final ctrlAngle = (i * 2 * math.pi / outerCount) + (math.pi / 4);
      final ctrlPoint = Offset(
        center.dx + (outerRadius * 0.5) * math.cos(ctrlAngle),
        center.dy + (outerRadius * 0.5) * math.sin(ctrlAngle),
      );

      final path = Path()
        ..moveTo(outerNodes[i].dx, outerNodes[i].dy)
        ..quadraticBezierTo(ctrlPoint.dx, ctrlPoint.dy, center.dx, center.dy);

      canvas.drawPath(path, pathPaint);

      // 3. 在连线上绘制沿路径向中心移动的光子/算力粒子
      final t = (progress + i / outerCount) % 1.0; // 0.0 -> 1.0 移动
      final particlePos = _getQuadraticBezierPoint(
        outerNodes[i],
        ctrlPoint,
        center,
        t,
      );

      nodePaint.color = Colors.white.withOpacity((1.0 - t) * 0.9); // 越靠近中心越亮
      canvas.drawCircle(particlePos, 2.0 + (1.0 - t) * 2.0, nodePaint);
    }

    // 4. 中心密集向量 Cluster 核心点
    final corePulse = (math.sin(progress * 2 * math.pi) + 1) / 2;
    nodePaint.color = Color.lerp(
      const Color(0xFFEC4899),
      const Color(0xFFC084FC),
      corePulse,
    )!;
    canvas.drawCircle(center, 4.0 + corePulse * 3.0, nodePaint);
  }

  // 二次贝塞尔曲线插值公式计算点位置
  Offset _getQuadraticBezierPoint(Offset p0, Offset p1, Offset p2, double t) {
    double u = 1 - t;
    double tt = t * t;
    double uu = u * u;
    double x = uu * p0.dx + 2 * u * t * p1.dx + tt * p2.dx;
    double y = uu * p0.dy + 2 * u * t * p1.dy + tt * p2.dy;
    return Offset(x, y);
  }

  @override
  bool shouldRepaint(covariant _EmbeddingClusterPainter oldDelegate) => true;
}

/// 3D 神经网络网格动画 (AiNeuralGrid3DLoading)
class AiNeuralGrid3DLoading extends StatefulWidget {
  final double size;

  const AiNeuralGrid3DLoading({super.key, this.size = 110.0});

  @override
  State<AiNeuralGrid3DLoading> createState() => _AiNeuralGrid3DLoadingState();
}

class _AiNeuralGrid3DLoadingState extends State<AiNeuralGrid3DLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _NeuralGrid3DPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _NeuralGrid3DPainter extends CustomPainter {
  final double progress;

  _NeuralGrid3DPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final gridScale = size.width * 0.32;

    // 1. 构建 3D 神经网络网格节点 (3层 x 3列 x 2深度，共18个三维节点)
    final List<List<double>> rawNodes = [];
    final List<List<int>> connections = [];

    // 生成三维网格节点坐标 [-1, 1]
    for (int z = -1; z <= 1; z += 2) {
      for (int y = -1; y <= 1; y++) {
        for (int x = -1; x <= 1; x++) {
          rawNodes.add([x * 0.8, y * 0.8, z * 0.8]);
        }
      }
    }

    // 自动构建近邻节点的神经网络拓扑连线
    final int nodeCount = rawNodes.length;
    for (int i = 0; i < nodeCount; i++) {
      for (int j = i + 1; j < nodeCount; j++) {
        double dx = rawNodes[i][0] - rawNodes[j][0];
        double dy = rawNodes[i][1] - rawNodes[j][1];
        double dz = rawNodes[i][2] - rawNodes[j][2];
        double dist = math.sqrt(dx * dx + dy * dy + dz * dz);

        // 仅连接距离较近的节点，形成强关联的网络拓扑结构
        if (dist <= 1.2) {
          connections.add([i, j]);
        }
      }
    }

    // 2. 旋转矩阵运算 (同时绕 Y 轴与 X 轴旋转)
    final angleY = progress * 2 * math.pi;
    final angleX =
        math.sin(progress * 2 * math.pi) * (math.pi / 6); // 带晃动的 X 轴旋转

    List<List<double>> rotatedNodes = [];
    for (var node in rawNodes) {
      // Y 轴旋转
      double x1 = node[0] * math.cos(angleY) + node[2] * math.sin(angleY);
      double y1 = node[1];
      double z1 = -node[0] * math.sin(angleY) + node[2] * math.cos(angleY);

      // X 轴旋转
      double x2 = x1;
      double y2 = y1 * math.cos(angleX) - z1 * math.sin(angleX);
      double z2 = y1 * math.sin(angleX) + z1 * math.cos(angleX);

      rotatedNodes.add([x2 * gridScale, y2 * gridScale, z2 * gridScale]);
    }

    // 3. 3D 透视投影 (Perspective Projection)
    final fov = 180.0; // 视距镜头深度
    List<Offset> projected2D = [];
    List<double> depthFactors = [];

    for (var node in rotatedNodes) {
      double z = node[2] + fov;
      double scale = fov / z;
      double x2d = center.dx + node[0] * scale;
      double y2d = center.dy + node[1] * scale;

      projected2D.add(Offset(x2d, y2d));

      // 深度因子 [0.15 - 1.0]，Z 轴靠前的点因子越大
      double depth = (fov + gridScale - z) / (2 * gridScale);
      depthFactors.add(depth.clamp(0.15, 1.0));
    }

    final linePaint = Paint()..style = PaintingStyle.stroke;
    final nodePaint = Paint()..style = PaintingStyle.fill;

    // 4. 绘制 3D 神经网络连线 (带有相位脉冲 + 深度衰减)
    for (int k = 0; k < connections.length; k++) {
      int idxA = connections[k][0];
      int idxB = connections[k][1];

      double avgDepth = (depthFactors[idxA] + depthFactors[idxB]) / 2;

      // 神经网络传输相位（信号在连线上闪烁）
      final signalPhase = (k * 0.4) + progress * 2 * math.pi;
      final signalActive = (math.sin(signalPhase) + 1) / 2;

      linePaint
        ..color = Color.lerp(
          const Color(0xFF6366F1),
          const Color(0xFFC084FC),
          signalActive,
        )!.withOpacity(avgDepth * (0.2 + 0.6 * signalActive))
        ..strokeWidth = (1.0 + signalActive * 1.5) * avgDepth;

      canvas.drawLine(projected2D[idxA], projected2D[idxB], linePaint);
    }

    // 5. 绘制 3D 神经网络节点 (近大远小，交错闪烁)
    for (int i = 0; i < projected2D.length; i++) {
      final depth = depthFactors[i];
      final nodePhase = (i * 0.8) + progress * 2 * math.pi;
      final activation = (math.sin(nodePhase) + 1) / 2; // 0.0 - 1.0 激活程度

      final nodeRadius = (2.5 + activation * 2.5) * depth;

      nodePaint.color = Color.lerp(
        const Color(0xFF818CF8),
        Colors.white,
        activation,
      )!.withOpacity(depth * (0.4 + 0.6 * activation));

      // 外围发光晕圈
      if (activation > 0.6) {
        final glowPaint = Paint()
          ..color = const Color(0xFFC084FC).withOpacity(depth * 0.3)
          ..style = PaintingStyle.fill;
        canvas.drawCircle(projected2D[i], nodeRadius * 2.0, glowPaint);
      }

      // 核心节点
      canvas.drawCircle(projected2D[i], nodeRadius, nodePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _NeuralGrid3DPainter oldDelegate) => true;
}

/// 3D 赛博神经网络加载动画 (AiNeuralGrid3DLoading)
class AiNeuralGrid3DLoading2 extends StatefulWidget {
  final double size;

  const AiNeuralGrid3DLoading2({super.key, this.size = 130.0});

  @override
  State<AiNeuralGrid3DLoading2> createState() => _AiNeuralGrid3DLoading2State();
}

class _AiNeuralGrid3DLoading2State extends State<AiNeuralGrid3DLoading2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _NeuralGrid3DPainter2(progress: _controller.value),
        );
      },
    );
  }
}

class _Point3D {
  final double x, y, z;

  _Point3D(this.x, this.y, this.z);
}

class _Connection {
  final int from;
  final int to;

  _Connection(this.from, this.to);
}

class _NeuralGrid3DPainter2 extends CustomPainter {
  final double progress;

  _NeuralGrid3DPainter2({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final scale3d = size.width * 0.32;

    // 1. 构建精简而高级的 3D 晶体神经网格结构
    // 包含：外部立方体 8 节点 + 内部核心 6 节点（正八面体拓扑）
    final List<_Point3D> rawPoints = [
      // 外部 Outer Cube Corner (8 Points)
      _Point3D(-1, -1, -1), _Point3D(1, -1, -1),
      _Point3D(1, 1, -1), _Point3D(-1, 1, -1),
      _Point3D(-1, -1, 1), _Point3D(1, -1, 1),
      _Point3D(1, 1, 1), _Point3D(-1, 1, 1),
      // 内部 Inner Core Axes (6 Points)
      _Point3D(0, -0.6, 0), _Point3D(0, 0.6, 0),
      _Point3D(-0.6, 0, 0), _Point3D(0.6, 0, 0),
      _Point3D(0, 0, -0.6), _Point3D(0, 0, 0.6),
    ];

    // 2. 拓扑连线设计 (Cube Edges + Core Neural Hubs)
    final List<_Connection> connections = [
      // 立方体外框 12 边
      _Connection(0, 1),
      _Connection(1, 2),
      _Connection(2, 3),
      _Connection(3, 0),
      _Connection(4, 5),
      _Connection(5, 6),
      _Connection(6, 7),
      _Connection(7, 4),
      _Connection(0, 4),
      _Connection(1, 5),
      _Connection(2, 6),
      _Connection(3, 7),
      // 内部核心枢纽连线
      _Connection(8, 9),
      _Connection(10, 11),
      _Connection(12, 13),
      // 核心与外框的神经突触连接
      _Connection(8, 0),
      _Connection(8, 1),
      _Connection(9, 6),
      _Connection(9, 7),
      _Connection(10, 3),
      _Connection(10, 4),
      _Connection(11, 2),
      _Connection(11, 5),
    ];

    // 3. 3D 旋转矩阵计算 (Y 轴连续旋转 + X/Z 轴正弦波动)
    final rotY = progress * 2 * math.pi;
    final rotX = math.sin(progress * 2 * math.pi) * 0.4 + 0.3; // 保持适度俯视角
    final rotZ = math.cos(progress * 2 * math.pi) * 0.15;

    final List<_Point3D> rotatedPoints = [];
    final List<Offset> proj2D = [];
    final List<double> zDepths = [];

    final fov = 200.0;

    for (var p in rawPoints) {
      // Y 旋转
      double x1 = p.x * math.cos(rotY) + p.z * math.sin(rotY);
      double y1 = p.y;
      double z1 = -p.x * math.sin(rotY) + p.z * math.cos(rotY);

      // X 旋转
      double x2 = x1;
      double y2 = y1 * math.cos(rotX) - z1 * math.sin(rotX);
      double z2 = y1 * math.sin(rotX) + z1 * math.cos(rotX);

      // Z 旋转
      double x3 = x2 * math.cos(rotZ) - y2 * math.sin(rotZ);
      double y3 = x2 * math.sin(rotZ) + y2 * math.cos(rotZ);
      double z3 = z2;

      // 坐标缩放与透视投影
      double worldX = x3 * scale3d;
      double worldY = y3 * scale3d;
      double worldZ = z3 * scale3d;

      double cameraZ = worldZ + fov;
      double perspective = fov / cameraZ;

      proj2D.add(
        Offset(
          center.dx + worldX * perspective,
          center.dy + worldY * perspective,
        ),
      );

      // 归一化深度因子 [0.15 - 1.0] (Z 轴靠前的点更亮更大)
      double depth = (worldZ + scale3d * 1.5) / (scale3d * 3.0);
      zDepths.add(depth.clamp(0.15, 1.0));
      rotatedPoints.add(_Point3D(worldX, worldY, worldZ));
    }

    // 4. 画笔初始化
    final linePaint = Paint()..style = PaintingStyle.stroke;
    final glowPaint = Paint()..style = PaintingStyle.fill;
    final particlePaint = Paint()..style = PaintingStyle.fill;

    // 5. 绘制神经网络拓扑底线与动态流体数据包 (Data Flow)
    for (int i = 0; i < connections.length; i++) {
      final conn = connections[i];
      final pA = proj2D[conn.from];
      final pB = proj2D[conn.to];
      final depthA = zDepths[conn.from];
      final depthB = zDepths[conn.to];
      final avgDepth = (depthA + depthB) / 2;

      // 基础神经网络暗线
      linePaint
        ..color = const Color(0xFF4F46E5).withOpacity(0.2 * avgDepth)
        ..strokeWidth = 1.0 * avgDepth;
      canvas.drawLine(pA, pB, linePaint);

      // 沿着 3D 连线流动的 AI 数据光斑粒子
      // 错开每条线的动画相位
      final flowProgress = (progress * 2 + i * 0.17) % 1.0;
      final particlePos = Offset.lerp(pA, pB, flowProgress)!;

      // 粒子高光发光 (BlendMode.plus 增强科技荧光感)
      final particleAlpha = math.sin(flowProgress * math.pi) * avgDepth;

      particlePaint.color = const Color(
        0xFF00F0FF,
      ).withOpacity(particleAlpha * 0.8);
      canvas.drawCircle(particlePos, 2.0 * avgDepth, particlePaint);

      // 粒子发光晕圈
      glowPaint.color = const Color(
        0xFF6366F1,
      ).withOpacity(particleAlpha * 0.35);
      canvas.drawCircle(particlePos, 4.5 * avgDepth, glowPaint);
    }

    // 6. 绘制 3D 晶体神经节点 (含深度高光 + 呼吸激活状态)
    for (int i = 0; i < proj2D.length; i++) {
      final pos = proj2D[i];
      final depth = zDepths[i];

      // 节点呼吸频率
      final nodePhase = (i * 0.6) + progress * 2 * math.pi;
      final nodePulse = (math.sin(nodePhase) + 1) / 2; // 0.0 - 1.0

      final baseRadius = (i >= 8 ? 3.5 : 2.5) * depth; // 核心节点比外框节点稍大
      final activeRadius = baseRadius + (nodePulse * 2.0 * depth);

      // 核心高光节点颜色渐变 (青蓝 -> 纯白)
      final nodeColor = Color.lerp(
        const Color(0xFF06B6D4),
        Colors.white,
        nodePulse,
      )!;

      // A. 节点外层高光晕（Cyan/Purple Glow）
      glowPaint.color =
          (i % 2 == 0 ? const Color(0xFF00F0FF) : const Color(0xFFA855F7))
              .withOpacity(depth * (0.2 + 0.4 * nodePulse));
      canvas.drawCircle(pos, activeRadius * 2.2, glowPaint);

      // B. 节点实体中心
      final corePaint = Paint()
        ..color = nodeColor.withOpacity(depth * 0.9)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(pos, activeRadius, corePaint);

      // C. 核心节点高光点
      if (nodePulse > 0.7) {
        final highlightPaint = Paint()
          ..color = Colors.white.withOpacity(depth * nodePulse)
          ..style = PaintingStyle.fill;
        canvas.drawCircle(pos, activeRadius * 0.4, highlightPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _NeuralGrid3DPainter2 oldDelegate) => true;
}

/// 3D 动态神经网络球体 (AiSphereNeuralGrid3DLoading)
class AiSphereNeuralGrid3DLoading extends StatefulWidget {
  final double size;

  const AiSphereNeuralGrid3DLoading({super.key, this.size = 130.0});

  @override
  State<AiSphereNeuralGrid3DLoading> createState() =>
      _AiSphereNeuralGrid3DLoadingState();
}

class _AiSphereNeuralGrid3DLoadingState
    extends State<AiSphereNeuralGrid3DLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _SphereNeuralPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _SphereNeuralPainter extends CustomPainter {
  final double progress;

  _SphereNeuralPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.36;

    // 1. 使用斐波那契螺旋生成均匀分布的球面 3D 节点 (24 个节点)
    final int nodeCount = 24;
    final List<_Point3D> rawNodes = [];
    final double goldenRatio = (1 + math.sqrt(5)) / 2;

    for (int i = 0; i < nodeCount; i++) {
      double theta = 2 * math.pi * i / goldenRatio;
      double phi = math.acos(1 - 2 * (i + 0.5) / nodeCount);
      double x = math.cos(theta) * math.sin(phi);
      double y = math.sin(theta) * math.sin(phi);
      double z = math.cos(phi);
      rawNodes.add(_Point3D(x, y, z));
    }

    // 2. 旋转矩阵 (Y轴为主旋转，X轴小幅倾斜正弦波动)
    final rotY = progress * 2 * math.pi;
    final rotX = math.sin(progress * 2 * math.pi) * 0.35 + 0.2;

    List<_Point3D> rotatedNodes = [];
    List<Offset> proj2D = [];
    List<double> zDepths = [];
    final fov = 220.0;

    for (var p in rawNodes) {
      // Y 轴
      double x1 = p.x * math.cos(rotY) + p.z * math.sin(rotY);
      double y1 = p.y;
      double z1 = -p.x * math.sin(rotY) + p.z * math.cos(rotY);
      // X 轴
      double x2 = x1;
      double y2 = y1 * math.cos(rotX) - z1 * math.sin(rotX);
      double z2 = y1 * math.sin(rotX) + z1 * math.cos(rotX);

      double wx = x2 * radius;
      double wy = y2 * radius;
      double wz = z2 * radius;

      double perspective = fov / (wz + fov);
      proj2D.add(
        Offset(center.dx + wx * perspective, center.dy + wy * perspective),
      );

      double depth = (wz + radius) / (2 * radius);
      zDepths.add(depth.clamp(0.1, 1.0));
      rotatedNodes.add(_Point3D(wx, wy, wz));
    }

    final linePaint = Paint()..style = PaintingStyle.stroke;
    final nodePaint = Paint()..style = PaintingStyle.fill;

    // 3. 绘制 3D 核心闪烁能源球 (Core AI Energy)
    final corePulse = (math.sin(progress * 4 * math.pi) + 1) / 2;
    final coreRadius = (8.0 + corePulse * 4.0);
    final coreGlow = Paint()
      ..color = const Color(0xFF38BDF8).withOpacity(0.35 + corePulse * 0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawCircle(center, coreRadius * 1.8, coreGlow);
    canvas.drawCircle(
      center,
      coreRadius,
      Paint()..color = const Color(0xFF0284C7),
    );

    // 4. 动态球面神经网络连线
    for (int i = 0; i < nodeCount; i++) {
      for (int j = i + 1; j < nodeCount; j++) {
        double dx = rawNodes[i].x - rawNodes[j].x;
        double dy = rawNodes[i].y - rawNodes[j].y;
        double dz = rawNodes[i].z - rawNodes[j].z;
        double dist = math.sqrt(dx * dx + dy * dy + dz * dz);

        // 仅连接距离较近的节点，形成紧密网格
        if (dist < 0.95) {
          final avgDepth = (zDepths[i] + zDepths[j]) / 2;
          final linePhase = (i + j) * 0.3 + progress * 2 * math.pi;
          final active = (math.sin(linePhase) + 1) / 2;

          linePaint
            ..color = Color.lerp(
              const Color(0xFF0284C7),
              const Color(0xFF38BDF8),
              active,
            )!.withOpacity(avgDepth * (0.15 + 0.5 * active))
            ..strokeWidth = (0.8 + active * 1.2) * avgDepth;

          canvas.drawLine(proj2D[i], proj2D[j], linePaint);
        }
      }
    }

    // 5. 绘制 3D 节点
    for (int i = 0; i < nodeCount; i++) {
      final depth = zDepths[i];
      final pPhase = (i * 0.7) + progress * 2 * math.pi;
      final pPulse = (math.sin(pPhase) + 1) / 2;

      final nSize = (2.0 + pPulse * 2.5) * depth;

      nodePaint.color = Color.lerp(
        const Color(0xFF38BDF8),
        Colors.white,
        pPulse,
      )!.withOpacity(depth * (0.4 + 0.6 * pPulse));

      canvas.drawCircle(proj2D[i], nSize, nodePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _SphereNeuralPainter oldDelegate) => true;
}

/// 正二十面体量子晶体 (AiIcosahedron3DLoading)
class AiIcosahedron3DLoading extends StatefulWidget {
  final double size;

  const AiIcosahedron3DLoading({super.key, this.size = 130.0});

  @override
  State<AiIcosahedron3DLoading> createState() => _AiIcosahedron3DLoadingState();
}

class _AiIcosahedron3DLoadingState extends State<AiIcosahedron3DLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _IcosahedronPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _IcosahedronPainter extends CustomPainter {
  final double progress;

  _IcosahedronPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final scale = size.width * 0.35;

    // 1. 构建黄金比例正二十面体 (12 个顶点)
    final double phi = (1.0 + math.sqrt(5.0)) / 2.0;
    final List<_Point3D> vertices = [
      _Point3D(-1, phi, 0),
      _Point3D(1, phi, 0),
      _Point3D(-1, -phi, 0),
      _Point3D(1, -phi, 0),
      _Point3D(0, -1, phi),
      _Point3D(0, 1, phi),
      _Point3D(0, -1, -phi),
      _Point3D(0, 1, -phi),
      _Point3D(phi, 0, -1),
      _Point3D(phi, 0, 1),
      _Point3D(-phi, 0, -1),
      _Point3D(-phi, 0, 1),
    ];

    // 2. 旋转转换 (X/Y/Z 三向动态组合)
    final angle = progress * 2 * math.pi;
    final rotX = angle;
    final rotY = angle * 0.7;
    final rotZ = math.sin(angle * 0.5) * 0.3;

    List<Offset> proj2D = [];
    List<double> depths = [];

    for (var v in vertices) {
      // 归一化顶点坐标到单位球
      double len = math.sqrt(v.x * v.x + v.y * v.y + v.z * v.z);
      double x = v.x / len, y = v.y / len, z = v.z / len;

      // Rotate X
      double y1 = y * math.cos(rotX) - z * math.sin(rotX);
      double z1 = y * math.sin(rotX) + z * math.cos(rotX);
      // Rotate Y
      double x2 = x * math.cos(rotY) + z1 * math.sin(rotY);
      double z2 = -x * math.sin(rotY) + z1 * math.cos(rotY);
      // Rotate Z
      double x3 = x2 * math.cos(rotZ) - y1 * math.sin(rotZ);
      double y3 = x2 * math.sin(rotZ) + y1 * math.cos(rotZ);

      double cameraZ = z2 * scale + 200.0;
      double perspective = 200.0 / cameraZ;

      proj2D.add(
        Offset(
          center.dx + x3 * scale * perspective,
          center.dy + y3 * scale * perspective,
        ),
      );
      depths.add(((z2 * scale + scale) / (2 * scale)).clamp(0.15, 1.0));
    }

    final linePaint = Paint()..style = PaintingStyle.stroke;

    // 3. 绘制晶体棱边与能量数据流
    int edgeCount = 0;
    for (int i = 0; i < vertices.length; i++) {
      for (int j = i + 1; j < vertices.length; j++) {
        double dx = vertices[i].x - vertices[j].x;
        double dy = vertices[i].y - vertices[j].y;
        double dz = vertices[i].z - vertices[j].z;
        double dist = math.sqrt(dx * dx + dy * dy + dz * dz);

        // 正二十面体棱长恒定约 2.0 / len
        if (dist < 1.1) {
          edgeCount++;
          double avgDepth = (depths[i] + depths[j]) / 2;

          // 棱线基础结构
          linePaint
            ..color = const Color(0xFFA855F7).withOpacity(0.25 * avgDepth)
            ..strokeWidth = 1.2 * avgDepth;
          canvas.drawLine(proj2D[i], proj2D[j], linePaint);

          // 棱线上流动的量子高光粒子
          double particlePhase = (progress * 3 + edgeCount * 0.1) % 1.0;
          Offset particlePos = Offset.lerp(
            proj2D[i],
            proj2D[j],
            particlePhase,
          )!;

          final pPaint = Paint()
            ..color = const Color(0xFFEC4899).withOpacity(avgDepth * 0.8)
            ..style = PaintingStyle.fill;
          canvas.drawCircle(particlePos, 2.0 * avgDepth, pPaint);
        }
      }
    }

    // 4. 绘制顶点核心晶核
    for (int i = 0; i < proj2D.length; i++) {
      double d = depths[i];
      canvas.drawCircle(
        proj2D[i],
        3.5 * d,
        Paint()
          ..color = Color.lerp(
            const Color(0xFFA855F7),
            const Color(0xFFEC4899),
            d,
          )!.withOpacity(d),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _IcosahedronPainter oldDelegate) => true;
}

/// 四维超正方体投影 (AiHypercube4DLoading)
class AiHypercube4DLoading extends StatefulWidget {
  final double size;

  const AiHypercube4DLoading({super.key, this.size = 130.0});

  @override
  State<AiHypercube4DLoading> createState() => _AiHypercube4DLoadingState();
}

class _AiHypercube4DLoadingState extends State<AiHypercube4DLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _Hypercube4DPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _Point4D {
  final double x, y, z, w;

  _Point4D(this.x, this.y, this.z, this.w);
}

class _Hypercube4DPainter extends CustomPainter {
  final double progress;

  _Hypercube4DPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final scale = size.width * 0.28;

    // 1. 生成 4D 超立方体的 16 个顶点 (±1, ±1, ±1, ±1)
    List<_Point4D> points = [];
    for (int i = 0; i < 16; i++) {
      points.add(
        _Point4D(
          (i & 1) == 0 ? -1 : 1,
          (i & 2) == 0 ? -1 : 1,
          (i & 4) == 0 ? -1 : 1,
          (i & 8) == 0 ? -1 : 1,
        ),
      );
    }

    // 2. 4D 旋转矩阵 (ZW 与 XW 平面双重四维旋转)
    final angle = progress * 2 * math.pi;
    List<Offset> proj2D = [];
    List<double> depths = [];

    for (var p in points) {
      // ZW 旋转
      double z1 = p.z * math.cos(angle) - p.w * math.sin(angle);
      double w1 = p.z * math.sin(angle) + p.w * math.cos(angle);
      // XW 旋转
      double x1 = p.x * math.cos(angle * 0.5) - w1 * math.sin(angle * 0.5);
      double w2 = p.x * math.sin(angle * 0.5) + w1 * math.cos(angle * 0.5);

      // 4D 到 3D 的透视投影 (Distance 4D = 2.0)
      double distance4D = 2.0;
      double wPersp = 1 / (distance4D - w2);

      double x3D = x1 * wPersp;
      double y3D = p.y * wPersp;
      double z3D = z1 * wPersp;

      // 3D 到 2D 的透视投影
      double cameraZ = z3D + 2.5;
      double perspective = 1.8 / cameraZ;

      proj2D.add(
        Offset(
          center.dx + x3D * scale * perspective,
          center.dy + y3D * scale * perspective,
        ),
      );
      depths.add(((z3D + 1.0) / 2.0).clamp(0.1, 1.0));
    }

    final linePaint = Paint()..style = PaintingStyle.stroke;

    // 3. 绘制 4D 超立方体的 32 条四维维度边
    for (int i = 0; i < 16; i++) {
      for (int j = i + 1; j < 16; j++) {
        // 在 4D 空间中，仅汉明距离为 1 的顶点有连线
        int numDifferences = 0;
        if ((i & 1) != (j & 1)) numDifferences++;
        if ((i & 2) != (j & 2)) numDifferences++;
        if ((i & 4) != (j & 4)) numDifferences++;
        if ((i & 8) != (j & 8)) numDifferences++;

        if (numDifferences == 1) {
          double avgDepth = (depths[i] + depths[j]) / 2;

          linePaint
            ..color = Color.lerp(
              const Color(0xFF10B981), // 赛博翡翠绿
              const Color(0xFF06B6D4), // 科技青
              avgDepth,
            )!.withOpacity(avgDepth * 0.6)
            ..strokeWidth = (0.8 + avgDepth * 1.4);

          canvas.drawLine(proj2D[i], proj2D[j], linePaint);
        }
      }
    }

    // 4. 绘制投影节点
    for (int i = 0; i < 16; i++) {
      double d = depths[i];
      canvas.drawCircle(
        proj2D[i],
        2.5 * d,
        Paint()
          ..color = const Color(0xFF34D399).withOpacity(d)
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _Hypercube4DPainter oldDelegate) => true;
}

/// 3D 双螺旋神经网络 (AiDNAHelix3DLoading)
class AiDNAHelix3DLoading extends StatefulWidget {
  final double size;

  const AiDNAHelix3DLoading({super.key, this.size = 130.0});

  @override
  State<AiDNAHelix3DLoading> createState() => _AiDNAHelix3DLoadingState();
}

class _AiDNAHelix3DLoadingState extends State<AiDNAHelix3DLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _DNAHelixPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _DNAHelixPainter extends CustomPainter {
  final double progress;

  _DNAHelixPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final helixRadius = size.width * 0.22;
    final helixHeight = size.height * 0.75;

    final int pairs = 12; // 12 对双螺旋节点
    final rotZ = progress * 2 * math.pi;

    List<Offset> chainA2D = [];
    List<Offset> chainB2D = [];
    List<double> depthsA = [];
    List<double> depthsB = [];

    for (int i = 0; i < pairs; i++) {
      double t = (i / (pairs - 1)) - 0.5; // [-0.5, 0.5]
      double y3D = t * helixHeight;
      double angle = t * 3.5 * math.pi + rotZ;

      // 链 A 坐标
      double xA = math.cos(angle) * helixRadius;
      double zA = math.sin(angle) * helixRadius;
      // 链 B 坐标 (相位相差 180度)
      double xB = math.cos(angle + math.pi) * helixRadius;
      double zB = math.sin(angle + math.pi) * helixRadius;

      // 简单的 3D 俯视视角倾斜
      double rotX = 0.35; // 倾斜角
      double yA3D = y3D * math.cos(rotX) - zA * math.sin(rotX);
      double zA3D = y3D * math.sin(rotX) + zA * math.cos(rotX);

      double yB3D = y3D * math.cos(rotX) - zB * math.sin(rotX);
      double zB3D = y3D * math.sin(rotX) + zB * math.cos(rotX);

      double fov = 200.0;
      double scaleA = fov / (zA3D + fov);
      double scaleB = fov / (zB3D + fov);

      chainA2D.add(Offset(center.dx + xA * scaleA, center.dy + yA3D * scaleA));
      chainB2D.add(Offset(center.dx + xB * scaleB, center.dy + yB3D * scaleB));

      depthsA.add(((zA3D + helixRadius) / (2 * helixRadius)).clamp(0.15, 1.0));
      depthsB.add(((zB3D + helixRadius) / (2 * helixRadius)).clamp(0.15, 1.0));
    }

    final linePaint = Paint()..style = PaintingStyle.stroke;

    // 绘制碱基对横向神经网络连线
    for (int i = 0; i < pairs; i++) {
      final pA = chainA2D[i];
      final pB = chainB2D[i];
      final avgDepth = (depthsA[i] + depthsB[i]) / 2;

      // 动态数据脉冲
      double pulse = (math.sin(progress * 4 * math.pi + i * 0.5) + 1) / 2;

      linePaint
        ..color = Color.lerp(
          const Color(0xFFF43F5E),
          const Color(0xFFFB923C),
          pulse,
        )!.withOpacity(avgDepth * (0.2 + 0.6 * pulse))
        ..strokeWidth = (1.0 + pulse * 1.5) * avgDepth;

      canvas.drawLine(pA, pB, linePaint);
    }

    // 绘制纵向主链与节点
    for (int i = 0; i < pairs; i++) {
      // 链 A 节点
      canvas.drawCircle(
        chainA2D[i],
        3.0 * depthsA[i],
        Paint()
          ..color = const Color(0xFFF43F5E).withOpacity(depthsA[i])
          ..style = PaintingStyle.fill,
      );
      // 链 B 节点
      canvas.drawCircle(
        chainB2D[i],
        3.0 * depthsB[i],
        Paint()
          ..color = const Color(0xFFFB923C).withOpacity(depthsB[i])
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DNAHelixPainter oldDelegate) => true;
}

/// 3D 环面环形场 (AiTorusGrid3DLoading)
class AiTorusGrid3DLoading extends StatefulWidget {
  final double size;

  const AiTorusGrid3DLoading({super.key, this.size = 130.0});

  @override
  State<AiTorusGrid3DLoading> createState() => _AiTorusGrid3DLoadingState();
}

class _AiTorusGrid3DLoadingState extends State<AiTorusGrid3DLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _TorusGridPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _TorusGridPainter extends CustomPainter {
  final double progress;

  _TorusGridPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final R = size.width * 0.28; // 大半径
    final r = size.width * 0.10; // 小半径

    final int uSteps = 12; // 围绕大圆切片数
    final int vSteps = 8; // 围绕管壁切片数

    final rotY = progress * 2 * math.pi;
    final rotX = 0.85; // 视角俯仰角

    List<List<Offset>> grid2D = List.generate(uSteps, (_) => []);
    List<List<double>> gridDepths = List.generate(uSteps, (_) => []);

    final fov = 200.0;

    for (int u = 0; u < uSteps; u++) {
      double uAngle = (u / uSteps) * 2 * math.pi + rotY;
      for (int v = 0; v < vSteps; v++) {
        double vAngle = (v / vSteps) * 2 * math.pi + (progress * 2 * math.pi);

        // Torus 参数方程
        double x = (R + r * math.cos(vAngle)) * math.cos(uAngle);
        double y = (R + r * math.cos(vAngle)) * math.sin(uAngle);
        double z = r * math.sin(vAngle);

        // X 轴旋转视角
        double y1 = y * math.cos(rotX) - z * math.sin(rotX);
        double z1 = y * math.sin(rotX) + z * math.cos(rotX);

        double perspective = fov / (z1 + fov + R);
        grid2D[u].add(
          Offset(center.dx + x * perspective, center.dy + y1 * perspective),
        );
        gridDepths[u].add(((z1 + R) / (2 * R)).clamp(0.1, 1.0));
      }
    }

    final linePaint = Paint()..style = PaintingStyle.stroke;

    // 绘制 3D 环面网格线
    for (int u = 0; u < uSteps; u++) {
      for (int v = 0; v < vSteps; v++) {
        int nextU = (u + 1) % uSteps;
        int nextV = (v + 1) % vSteps;

        double depth = gridDepths[u][v];

        linePaint
          ..color = const Color(0xFF10B981).withOpacity(0.35 * depth)
          ..strokeWidth = 1.0 * depth;

        // U 方向环线
        canvas.drawLine(grid2D[u][v], grid2D[nextU][v], linePaint);
        // V 方向管壁线
        canvas.drawLine(grid2D[u][v], grid2D[u][nextV], linePaint);

        // 高光自旋节点
        if (v % 2 == 0) {
          canvas.drawCircle(
            grid2D[u][v],
            2.0 * depth,
            Paint()
              ..color = const Color(0xFF6EE7B7).withOpacity(depth)
              ..style = PaintingStyle.fill,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _TorusGridPainter oldDelegate) => true;
}

/// 3D 三轴陀螺仪连环 (AiGimbalGyro3DLoading)
class AiGimbalGyro3DLoading extends StatefulWidget {
  final double size;

  const AiGimbalGyro3DLoading({super.key, this.size = 130.0});

  @override
  State<AiGimbalGyro3DLoading> createState() => _AiGimbalGyro3DLoadingState();
}

class _AiGimbalGyro3DLoadingState extends State<AiGimbalGyro3DLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _GimbalPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _GimbalPainter extends CustomPainter {
  final double progress;

  _GimbalPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final baseRadius = size.width * 0.40;

    // 三层陀螺仪环：Outer, Middle, Inner
    _drawGyroRing(
      canvas,
      center,
      baseRadius * 1.0,
      progress * 2 * math.pi,
      0,
      const Color(0xFF3B82F6),
    );
    _drawGyroRing(
      canvas,
      center,
      baseRadius * 0.72,
      -progress * 3 * math.pi,
      math.pi / 3,
      const Color(0xFF8B5CF6),
    );
    _drawGyroRing(
      canvas,
      center,
      baseRadius * 0.45,
      progress * 4 * math.pi,
      math.pi / 1.5,
      const Color(0xFFEC4899),
    );

    // 中央量子发光核心
    final coreGlow = Paint()
      ..color = const Color(0xFF3B82F6).withOpacity(0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(center, 6, coreGlow);
    canvas.drawCircle(
      center,
      3.5,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill,
    );
  }

  void _drawGyroRing(
    Canvas canvas,
    Offset center,
    double radius,
    double rotAngle,
    double tiltAngle,
    Color color,
  ) {
    final int segments = 24;
    List<Offset> points2D = [];
    List<double> depths = [];

    final fov = 200.0;

    for (int i = 0; i < segments; i++) {
      double a = (i / segments) * 2 * math.pi;
      // 基础圆平面坐标
      double x = math.cos(a) * radius;
      double y = math.sin(a) * radius;
      double z = 0;

      // 自转
      double x1 = x * math.cos(rotAngle) - y * math.sin(rotAngle);
      double y1 = x * math.sin(rotAngle) + y * math.cos(rotAngle);

      // 倾斜视角 (X/Z 轴)
      double y2 = y1 * math.cos(tiltAngle) - z * math.sin(tiltAngle);
      double z2 = y1 * math.sin(tiltAngle) + z * math.cos(tiltAngle);

      double perspective = fov / (z2 + fov + radius);
      points2D.add(
        Offset(center.dx + x1 * perspective, center.dy + y2 * perspective),
      );
      depths.add(((z2 + radius) / (2 * radius)).clamp(0.15, 1.0));
    }

    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (int i = 0; i < segments; i++) {
      int next = (i + 1) % segments;
      double avgDepth = (depths[i] + depths[next]) / 2;

      linePaint.color = color.withOpacity(avgDepth * 0.7);
      linePaint.strokeWidth = 1.2 * avgDepth;
      canvas.drawLine(points2D[i], points2D[next], linePaint);

      // 环上的数据节点
      if (i % 6 == 0) {
        canvas.drawCircle(
          points2D[i],
          2.5 * depths[i],
          Paint()
            ..color = Colors.white.withOpacity(depths[i])
            ..style = PaintingStyle.fill,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GimbalPainter oldDelegate) => true;
}

/// 3D 神经网络分形树 (AiFractalTree3DLoading)
class AiFractalTree3DLoading extends StatefulWidget {
  final double size;

  const AiFractalTree3DLoading({super.key, this.size = 130.0});

  @override
  State<AiFractalTree3DLoading> createState() => _AiFractalTree3DLoadingState();
}

class _AiFractalTree3DLoadingState extends State<AiFractalTree3DLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _FractalTreePainter(progress: _controller.value),
        );
      },
    );
  }
}

class _FractalTreePainter extends CustomPainter {
  final double progress;

  _FractalTreePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final trunkLength = size.height * 0.22;

    final rotY = progress * 2 * math.pi;

    // 递归绘制 3D 分形树
    _drawBranch(
      canvas,
      center,
      0,
      0,
      0,
      // 3D 起始点 (x, y, z)
      0,
      -trunkLength,
      0,
      // 3D 向量 (dx, dy, dz)
      3,
      // 递归深度
      rotY,
      center,
    );
  }

  void _drawBranch(
    Canvas canvas,
    Offset center,
    double x,
    double y,
    double z,
    double dx,
    double dy,
    double dz,
    int depth,
    double rotY,
    Offset origin,
  ) {
    if (depth == 0) return;

    // Y 轴 3D 旋转计算
    double rx1 = x * math.cos(rotY) + z * math.sin(rotY);
    double ry1 = y;
    double rz1 = -x * math.sin(rotY) + z * math.cos(rotY);

    double ex = x + dx;
    double ey = y + dy;
    double ez = z + dz;

    double rx2 = ex * math.cos(rotY) + ez * math.sin(rotY);
    double ry2 = ey;
    double rz2 = -ex * math.sin(rotY) + ez * math.cos(rotY);

    // 3D 透视投影
    double fov = 200.0;
    double scale1 = fov / (rz1 + fov + 100);
    double scale2 = fov / (rz2 + fov + 100);

    Offset p1 = Offset(origin.dx + rx1 * scale1, origin.dy + ry1 * scale1 + 15);
    Offset p2 = Offset(origin.dx + rx2 * scale2, origin.dy + ry2 * scale2 + 15);

    double avgDepth = ((rz1 + rz2) / 2 + 100) / 200;
    avgDepth = avgDepth.clamp(0.1, 1.0);

    // 绘制树枝连线
    final paint = Paint()
      ..color = Color.lerp(
        const Color(0xFF06B6D4),
        const Color(0xFF6366F1),
        depth / 3,
      )!.withOpacity(avgDepth * 0.7)
      ..strokeWidth = depth * 1.2 * avgDepth
      ..style = PaintingStyle.stroke;

    canvas.drawLine(p1, p2, paint);

    // 末端绘制高光叶子节点
    if (depth == 1) {
      canvas.drawCircle(
        p2,
        3.0 * avgDepth,
        Paint()
          ..color = const Color(0xFF38BDF8).withOpacity(avgDepth)
          ..style = PaintingStyle.fill,
      );
    }

    // 分支衍生 (呈 3 方向 120 度角发散)
    double branchScale = 0.68;
    for (int i = 0; i < 3; i++) {
      double angle = (i * 2 * math.pi / 3) + (progress * 2 * math.pi);
      double nextDx =
          (dx * math.cos(angle) - dz * math.sin(angle)) * branchScale;
      double nextDy = dy * branchScale;
      double nextDz =
          (dx * math.sin(angle) + dz * math.cos(angle)) * branchScale;

      _drawBranch(
        canvas,
        center,
        ex,
        ey,
        ez,
        nextDx,
        nextDy,
        nextDz,
        depth - 1,
        rotY,
        origin,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _FractalTreePainter oldDelegate) => true;
}

/// 3D 动态 AI 粒子群 (AiSwarmCloud3DLoading)
class AiSwarmCloud3DLoading extends StatefulWidget {
  final double size;

  const AiSwarmCloud3DLoading({super.key, this.size = 130.0});

  @override
  State<AiSwarmCloud3DLoading> createState() => _AiSwarmCloud3DLoadingState();
}

class _AiSwarmCloud3DLoadingState extends State<AiSwarmCloud3DLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _SwarmCloudPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _SwarmCloudPainter extends CustomPainter {
  final double progress;

  _SwarmCloudPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final count = 36;
    final radius = size.width * 0.35;

    final rotY = progress * 2 * math.pi;
    final rotX = 0.4;
    final fov = 200.0;

    List<Offset> points2D = [];
    List<double> depths = [];

    for (int i = 0; i < count; i++) {
      // 利用李萨如(Lissajous)曲线映射 3D 轨迹
      double t = (i / count) * 2 * math.pi + progress * 2 * math.pi;
      double x = math.sin(t * 2) * radius * 0.9;
      double y = math.cos(t * 3) * radius * 0.6;
      double z = math.sin(t * 5) * radius * 0.8;

      // Y/X 旋转
      double x1 = x * math.cos(rotY) + z * math.sin(rotY);
      double z1 = -x * math.sin(rotY) + z * math.cos(rotY);
      double y1 = y * math.cos(rotX) - z1 * math.sin(rotX);
      double z2 = y * math.sin(rotX) + z1 * math.cos(rotX);

      double scale = fov / (z2 + fov + radius);
      points2D.add(Offset(center.dx + x1 * scale, center.dy + y1 * scale));
      depths.add(((z2 + radius) / (2 * radius)).clamp(0.1, 1.0));
    }

    // 绘制粒子流云
    for (int i = 0; i < count; i++) {
      double d = depths[i];
      int next = (i + 1) % count;

      // 粒子间微弱连线
      final linePaint = Paint()
        ..color = const Color(0xFF38BDF8).withOpacity(d * 0.25)
        ..strokeWidth = 1.0 * d;
      canvas.drawLine(points2D[i], points2D[next], linePaint);

      // 粒子本体
      final pPaint = Paint()
        ..color = Color.lerp(
          const Color(0xFF0284C7),
          Colors.white,
          d,
        )!.withOpacity(d * 0.9)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(points2D[i], (2.0 + (i % 3)) * d, pPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _SwarmCloudPainter oldDelegate) => true;
}

/// 3D 奇点黑洞引力场 (AiBlackHole3DLoading)
class AiBlackHole3DLoading extends StatefulWidget {
  final double size;

  const AiBlackHole3DLoading({super.key, this.size = 130.0});

  @override
  State<AiBlackHole3DLoading> createState() => _AiBlackHole3DLoadingState();
}

class _AiBlackHole3DLoadingState extends State<AiBlackHole3DLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _BlackHolePainter(progress: _controller.value),
        );
      },
    );
  }
}

class _BlackHolePainter extends CustomPainter {
  final double progress;

  _BlackHolePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final count = 40;
    final maxRadius = size.width * 0.42;

    final rotX = 1.15; // 接近平视吸积盘角度
    final rotZ = progress * 2 * math.pi;

    // 中央奇点 (Singularity Core)
    final blackHolePaint = Paint()..color = Colors.black;
    final glowPaint = Paint()
      ..color = const Color(0xFFF59E0B).withOpacity(0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    canvas.drawCircle(center, 12, glowPaint);
    canvas.drawCircle(center, 8, blackHolePaint);

    // 吸积盘螺旋坍缩粒子
    for (int i = 0; i < count; i++) {
      // 粒子半径从外向内螺旋坍缩
      double pProgress = (progress + i / count) % 1.0;
      double r = (1.0 - pProgress) * maxRadius;
      double angle = pProgress * 4 * math.pi + (i * 0.2) + rotZ;

      double x = math.cos(angle) * r;
      double y = math.sin(angle) * r;
      double z = math.sin(pProgress * math.pi) * 15;

      // 倾斜矩阵
      double y1 = y * math.cos(rotX) - z * math.sin(rotX);
      double z1 = y * math.sin(rotX) + z * math.cos(rotX);

      double depth = ((z1 + maxRadius) / (2 * maxRadius)).clamp(0.1, 1.0);
      Offset pos = Offset(center.dx + x, center.dy + y1);

      final pColor = Color.lerp(
        const Color(0xFFEF4444), // 外围冷红
        const Color(0xFFFBBF24), // 内圈亮金
        1.0 - pProgress,
      )!;

      canvas.drawCircle(
        pos,
        (1.5 + (1.0 - pProgress) * 2.5) * depth,
        Paint()
          ..color = pColor.withOpacity(depth * pProgress)
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _BlackHolePainter oldDelegate) => true;
}

/// 3D 莫比乌斯无限环带 (AiMobiusStrip3DLoading)
class AiMobiusStrip3DLoading extends StatefulWidget {
  final double size;

  const AiMobiusStrip3DLoading({super.key, this.size = 130.0});

  @override
  State<AiMobiusStrip3DLoading> createState() => _AiMobiusStrip3DLoadingState();
}

class _AiMobiusStrip3DLoadingState extends State<AiMobiusStrip3DLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _MobiusPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _MobiusPainter extends CustomPainter {
  final double progress;

  _MobiusPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final R = size.width * 0.28;
    final count = 30;

    final rotY = progress * 2 * math.pi;
    final rotX = 0.5;
    final fov = 220.0;

    List<Offset> points2D = [];
    List<double> depths = [];

    for (int i = 0; i < count; i++) {
      double u = (i / count) * 2 * math.pi;
      double v = 0.3 * math.sin(progress * 2 * math.pi); // 动态宽度扭曲

      // 莫比乌斯带参数方程
      double x = (R + v * math.cos(u / 2)) * math.cos(u);
      double y = (R + v * math.cos(u / 2)) * math.sin(u);
      double z = v * math.sin(u / 2) * R;

      // 3D 旋转
      double x1 = x * math.cos(rotY) + z * math.sin(rotY);
      double z1 = -x * math.sin(rotY) + z * math.cos(rotY);
      double y1 = y * math.cos(rotX) - z1 * math.sin(rotX);
      double z2 = y * math.sin(rotX) + z1 * math.cos(rotX);

      double scale = fov / (z2 + fov + R);
      points2D.add(Offset(center.dx + x1 * scale, center.dy + y1 * scale));
      depths.add(((z2 + R) / (2 * R)).clamp(0.15, 1.0));
    }

    final linePaint = Paint()..style = PaintingStyle.stroke;

    // 绘制无限环线条
    for (int i = 0; i < count; i++) {
      int next = (i + 1) % count;
      double avgDepth = (depths[i] + depths[next]) / 2;

      linePaint
        ..color = const Color(0xFF8B5CF6).withOpacity(avgDepth * 0.6)
        ..strokeWidth = 2.0 * avgDepth;
      canvas.drawLine(points2D[i], points2D[next], linePaint);

      // 环带上流动的流光高光
      double lightPhase = (progress * 2 + i / count) % 1.0;
      if (lightPhase > 0.7) {
        canvas.drawCircle(
          points2D[i],
          3.0 * avgDepth,
          Paint()
            ..color = const Color(0xFFC084FC).withOpacity(avgDepth)
            ..style = PaintingStyle.fill,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _MobiusPainter oldDelegate) => true;
}

/// 3D 智能量子矩阵阵列 (AiCubeMatrix3DLoading)
class AiCubeMatrix3DLoading extends StatefulWidget {
  final double size;

  const AiCubeMatrix3DLoading({super.key, this.size = 130.0});

  @override
  State<AiCubeMatrix3DLoading> createState() => _AiCubeMatrix3DLoadingState();
}

class _AiCubeMatrix3DLoadingState extends State<AiCubeMatrix3DLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _CubeMatrixPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _CubeMatrixPainter extends CustomPainter {
  final double progress;

  _CubeMatrixPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final spacing = size.width * 0.12;

    final rotY = progress * 2 * math.pi;
    final rotX = 0.55;

    // 生成 3x3 立方体阵列
    for (int x = -1; x <= 1; x++) {
      for (int y = -1; y <= 1; y++) {
        for (int z = -1; z <= 1; z++) {
          // 每个小立方体跟随波浪波动
          double distFromCenter = math.sqrt(x * x + y * y + z * z);
          double wave = math.sin(progress * 2 * math.pi - distFromCenter * 0.8);

          double px = x * spacing;
          double py = y * spacing + (wave * 6.0); // 上下波动
          double pz = z * spacing;

          // 3D 旋转
          double x1 = px * math.cos(rotY) + pz * math.sin(rotY);
          double z1 = -px * math.sin(rotY) + pz * math.cos(rotY);
          double y1 = py * math.cos(rotX) - z1 * math.sin(rotX);
          double z2 = py * math.sin(rotX) + z1 * math.cos(rotX);

          double depth = ((z2 + spacing * 2) / (spacing * 4)).clamp(0.2, 1.0);
          Offset pos = Offset(center.dx + x1, center.dy + y1);

          // 绘制矩阵量子节点
          final cubePaint = Paint()
            ..color = Color.lerp(
              const Color(0xFF10B981),
              const Color(0xFF06B6D4),
              (wave + 1) / 2,
            )!.withOpacity(depth * 0.85)
            ..style = PaintingStyle.fill;

          canvas.drawRect(
            Rect.fromCenter(
              center: pos,
              width: (5.0 + wave * 1.5) * depth,
              height: (5.0 + wave * 1.5) * depth,
            ),
            cubePaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _CubeMatrixPainter oldDelegate) => true;
}

/// 3D 投影超立方体 (AiTesseract3DLoading)
class AiTesseract3DLoading extends StatefulWidget {
  final double size;

  const AiTesseract3DLoading({super.key, this.size = 130.0});

  @override
  State<AiTesseract3DLoading> createState() => _AiTesseract3DLoadingState();
}

class _AiTesseract3DLoadingState extends State<AiTesseract3DLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _TesseractPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _TesseractPainter extends CustomPainter {
  final double progress;

  _TesseractPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final angle = progress * 2 * math.pi;
    final fov = 180.0;

    // 8 个外顶点的 3D 坐标
    final double outerS = size.width * 0.28;
    // 8 个内顶点的 3D 坐标（随时间脉冲缩放）
    final double innerS = outerS * (0.45 + 0.1 * math.sin(angle * 2));

    List<Offset> projectCube(double s) {
      final verts = [
        [-s, -s, -s],
        [s, -s, -s],
        [s, s, -s],
        [-s, s, -s],
        [-s, -s, s],
        [s, -s, s],
        [s, s, s],
        [-s, s, s],
      ];
      return verts.map((v) {
        double x = v[0], y = v[1], z = v[2];
        // Y 轴 & X 轴旋转
        double x1 = x * math.cos(angle) + z * math.sin(angle);
        double z1 = -x * math.sin(angle) + z * math.cos(angle);
        double y1 = y * math.cos(0.5) - z1 * math.sin(0.5);
        double z2 = y * math.sin(0.5) + z1 * math.cos(0.5);

        double scale = fov / (z2 + fov + s * 2);
        return Offset(center.dx + x1 * scale, center.dy + y1 * scale);
      }).toList();
    }

    final outer2D = projectCube(outerS);
    final inner2D = projectCube(innerS);

    final edgePaint = Paint()
      ..color = const Color(0xFF3B82F6).withOpacity(0.65)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final connectPaint = Paint()
      ..color = const Color(0xFF60A5FA).withOpacity(0.35)
      ..strokeWidth = 1.0;

    // 立方体 12 条边线索引
    final edges = [
      [0, 1],
      [1, 2],
      [2, 3],
      [3, 0],
      [4, 5],
      [5, 6],
      [6, 7],
      [7, 4],
      [0, 4],
      [1, 5],
      [2, 6],
      [3, 7],
    ];

    // 绘制外与内立方体框架
    for (var e in edges) {
      canvas.drawLine(outer2D[e[0]], outer2D[e[1]], edgePaint);
      canvas.drawLine(inner2D[e[0]], inner2D[e[1]], edgePaint);
    }

    // 绘制连接四维相连的 8 条边
    for (int i = 0; i < 8; i++) {
      canvas.drawLine(outer2D[i], inner2D[i], connectPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _TesseractPainter oldDelegate) => true;
}

/// 3D 动态量子原子核 (AiAtomCore3DLoading)
class AiAtomCore3DLoading extends StatefulWidget {
  final double size;

  const AiAtomCore3DLoading({super.key, this.size = 130.0});

  @override
  State<AiAtomCore3DLoading> createState() => _AiAtomCore3DLoadingState();
}

class _AiAtomCore3DLoadingState extends State<AiAtomCore3DLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _AtomCorePainter(progress: _controller.value),
        );
      },
    );
  }
}

class _AtomCorePainter extends CustomPainter {
  final double progress;

  _AtomCorePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.38;

    // 中央能量核
    final coreGlow = Paint()
      ..color = const Color(0xFFEC4899).withOpacity(0.6)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawCircle(center, 8, coreGlow);
    canvas.drawCircle(center, 5, Paint()..color = Colors.white);

    // 3 个不同空间平面的椭圆轨道 (倾角 0, 60°, 120°)
    for (int ring = 0; ring < 3; ring++) {
      final ringAngle = ring * math.pi / 3;
      final rotZ = progress * 2 * math.pi * (ring % 2 == 0 ? 1 : -1);

      final trackPath = Path();
      Offset? electronPos;

      for (int i = 0; i <= 60; i++) {
        double t = (i / 60) * 2 * math.pi;
        double x = math.cos(t) * radius;
        double y = math.sin(t) * (radius * 0.35);

        // 3D 姿态旋转
        double rx = x * math.cos(ringAngle) - y * math.sin(ringAngle);
        double ry = x * math.sin(ringAngle) + y * math.cos(ringAngle);

        Offset point = Offset(center.dx + rx, center.dy + ry);
        if (i == 0) {
          trackPath.moveTo(point.dx, point.dy);
        } else {
          trackPath.lineTo(point.dx, point.dy);
        }

        // 计算电子在轨道上的位置
        if ((t - rotZ).abs() % (2 * math.pi) < 0.11) {
          electronPos = point;
        }
      }

      // 绘制轨道线
      canvas.drawPath(
        trackPath,
        Paint()
          ..color = const Color(0xFFF472B6).withOpacity(0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0,
      );

      // 绘制轨道上高能运行的电子粒子
      if (electronPos != null) {
        canvas.drawCircle(
          electronPos,
          3.5,
          Paint()..color = const Color(0xFFF0ABFC),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _AtomCorePainter oldDelegate) => true;
}

/// 3D 环面三叶结 (AiTorusKnot3DLoading)
class AiTorusKnot3DLoading extends StatefulWidget {
  final double size;

  const AiTorusKnot3DLoading({super.key, this.size = 130.0});

  @override
  State<AiTorusKnot3DLoading> createState() => _AiTorusKnot3DLoadingState();
}

class _AiTorusKnot3DLoadingState extends State<AiTorusKnot3DLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _TorusKnotPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _TorusKnotPainter extends CustomPainter {
  final double progress;

  _TorusKnotPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final scaleRadius = size.width * 0.12;
    final count = 80;

    final rotY = progress * 2 * math.pi;
    final rotX = 0.6;
    final fov = 200.0;

    List<Offset> pts = [];
    List<double> depths = [];

    // (p=2, q=3) 三叶结参数方程
    for (int i = 0; i < count; i++) {
      double t = (i / count) * 2 * math.pi;
      double r = 2 + math.cos(3 * t);
      double x = r * math.cos(2 * t) * scaleRadius;
      double y = r * math.sin(2 * t) * scaleRadius;
      double z = math.sin(3 * t) * scaleRadius * 1.5;

      // 3D 空间旋转
      double x1 = x * math.cos(rotY) + z * math.sin(rotY);
      double z1 = -x * math.sin(rotY) + z * math.cos(rotY);
      double y1 = y * math.cos(rotX) - z1 * math.sin(rotX);
      double z2 = y * math.sin(rotX) + z1 * math.cos(rotX);

      double scale = fov / (z2 + fov + scaleRadius * 3);
      pts.add(Offset(center.dx + x1 * scale, center.dy + y1 * scale));
      depths.add(((z2 + scaleRadius * 3) / (scaleRadius * 6)).clamp(0.1, 1.0));
    }

    // 渲染拓扑线
    for (int i = 0; i < count; i++) {
      int next = (i + 1) % count;
      double d = depths[i];

      final p = Paint()
        ..color = Color.lerp(
          const Color(0xFF14B8A6),
          const Color(0xFF2DD4BF),
          d,
        )!.withOpacity(d * 0.8)
        ..strokeWidth = 2.0 * d
        ..style = PaintingStyle.stroke;

      canvas.drawLine(pts[i], pts[next], p);
    }
  }

  @override
  bool shouldRepaint(covariant _TorusKnotPainter oldDelegate) => true;
}

/// 3D 全息雷达扫描场 (AiHoloScanner3DLoading)
class AiHoloScanner3DLoading extends StatefulWidget {
  final double size;

  const AiHoloScanner3DLoading({super.key, this.size = 130.0});

  @override
  State<AiHoloScanner3DLoading> createState() => _AiHoloScanner3DLoadingState();
}

class _AiHoloScanner3DLoadingState extends State<AiHoloScanner3DLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _HoloScannerPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _HoloScannerPainter extends CustomPainter {
  final double progress;

  _HoloScannerPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final gridCount = 6;
    final step = size.width * 0.11;
    final rotX = 1.1; // 平视透视倾角

    final gridPaint = Paint()
      ..color = const Color(0xFF06B6D4).withOpacity(0.2)
      ..strokeWidth = 1.0;

    // 绘制 3D 网格底层
    for (int i = -gridCount; i <= gridCount; i++) {
      double pos = i * step;
      // 纵向线
      double x1 = pos, y1 = -gridCount * step;
      double x2 = pos, y2 = gridCount * step;

      Offset p1 = Offset(center.dx + x1, center.dy + y1 * math.cos(rotX));
      Offset p2 = Offset(center.dx + x2, center.dy + y2 * math.cos(rotX));
      canvas.drawLine(p1, p2, gridPaint);

      // 横向线
      Offset p3 = Offset(center.dx + y1, center.dy + pos * math.cos(rotX));
      Offset p4 = Offset(center.dx + y2, center.dy + pos * math.cos(rotX));
      canvas.drawLine(p3, p4, gridPaint);
    }

    // 绘制扫描波束平面 (往复移动)
    double scanY = (math.sin(progress * 2 * math.pi) * gridCount * step);
    double projY = center.dy + scanY * math.cos(rotX);

    final scanPaint = Paint()
      ..color = const Color(0xFF22D3EE).withOpacity(0.8)
      ..strokeWidth = 2.0;

    canvas.drawLine(
      Offset(center.dx - gridCount * step, projY),
      Offset(center.dx + gridCount * step, projY),
      scanPaint,
    );

    // 扫描平面光晕发光
    final glowPaint = Paint()
      ..color = const Color(0xFF67E8F9).withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    canvas.drawRect(
      Rect.fromLTRB(
        center.dx - gridCount * step,
        projY - 4,
        center.dx + gridCount * step,
        projY + 4,
      ),
      glowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _HoloScannerPainter oldDelegate) => true;
}
