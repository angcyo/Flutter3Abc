part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2024/01/30
/// 手势相关abc
class GestureAbc extends StatefulWidget {
  const GestureAbc({super.key});

  @override
  State<GestureAbc> createState() => _GestureAbcState();
}

class _GestureAbcState extends State<GestureAbc> with BaseAbcStateMixin {
  @override
  Widget buildAbc(BuildContext context) {
    //return super.buildAbc(context);
    return GestureHitInterceptScope(
      child: super.buildAbc(context),
    );
  }

  @override
  List<Widget> buildBodyList(BuildContext context) {
    //return super.buildBodyList(context);
    return [
      const GestureTestWidget(),
      const GestureTestWidget(),
    ];
  }

  @override
  Widget buildBody(BuildContext context) {
    // return Placeholder();
    return SizedBox(
      height: 400,
      child: GestureDetector(
        onTapDown: (details) {
          l.i(details);
        },
      ),
    );
  }
}

/// ---

class GestureTestWidget extends LeafRenderObjectWidget {
  const GestureTestWidget({super.key});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return GestureTestBox(context);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant GestureTestBox renderObject) {
    super.updateRenderObject(context, renderObject);
  }

/*@override
  List<DiagnosticsNode> debugDescribeChildren() {
    final List<DiagnosticsNode> children = <DiagnosticsNode>[];
    children.add(toDiagnosticsNode(name: 'child ~~~'));
    //return super.debugDescribeChildren();
    return children;
  }*/
}

class GestureTestBox extends RenderBox {
  /// 用来保存所有的手指事件
  final pointerMap = <int, PointerEvent>{};

  /// 用来保存所有的手指颜色
  final pointerColorMap = <int, Color>{};

  BuildContext context;

  GestureTestBox(this.context);

  Color getPointerColor(int pointer) {
    return pointerColorMap.putIfAbsent(pointer, () => randomColor());
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    debugger();
    return super.computeDryLayout(constraints);
  }

  @override
  Size getDryLayout(BoxConstraints constraints) {
    debugger();
    return super.getDryLayout(constraints);
  }

  @override
  void performLayout() {
    size = Size(constraints.maxWidth, constraints.maxWidth / 2);
  }

  @override
  bool get isRepaintBoundary => true;

  @override
  void paint(PaintingContext context, Offset offset) {
    //context.canvas.drawColor(Colors.redAccent, BlendMode.src);
    final canvas = context.canvas;
    canvas.withTranslate(offset.dx, offset.dy, () {
      canvas.drawRect(
        paintBounds,
        Paint()..color = Colors.grey,
      );
      TextPainter(
        text: TextSpan(
            text: "在此区域的手势会阻止`ListView`的滚动\n${pointerMap.length}",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            )),
        textDirection: TextDirection.ltr,
      )
        ..layout(maxWidth: paintBounds.width)
        ..paint(canvas, Offset.zero);

      //绘制map
      const radius = 30.0;
      final paint = Paint()
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke;

      //debugger();
      pointerMap.forEach((key, pointer) {
        //debugger();
        paint.color = getPointerColor(key);
        canvas.drawLine(Offset(0, pointer.localPosition.dy),
            Offset(size.width, pointer.localPosition.dy), paint);
        canvas.drawLine(Offset(pointer.localPosition.dx, 0),
            Offset(pointer.localPosition.dx, size.height), paint);
        canvas.drawCircle(pointer.localPosition, radius, paint);

        /*TextPainter(
        text: TextSpan(
            text:
                "$key ${value.runtimeType}\n${value.position}\n${value.localPosition}",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 8,
            )),
        textDirection: TextDirection.ltr,
      )
        ..layout(maxWidth: paintBounds.width)
        ..paint(context.canvas, offset);*/
      });
    });
  }

  /// 1.命中测试入口
  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    //debugger();
    return super.hitTest(result, position: position);
  }

  /// 2.是否有child命中
  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return super.hitTestChildren(result, position: position);
  }

  /// 3.自身是否命中
  @override
  bool hitTestSelf(Offset position) {
    //debugger();
    return super.hitTestSelf(position) || true;
  }

  /// 只有命中通过之后, 才会回调事件
  /// [GestureBinding.handlePointerEvent] -> [GestureBinding._handlePointerEventImmediately] -> [HitTestResult.addWithPaintTransform]
  @override
  void handleEvent(PointerEvent event, covariant BoxHitTestEntry entry) {
    //debugger();
    //GestureBinding.instance.gestureArena.close(event.pointer);
    //GestureBinding.instance.gestureArena.hold(event.pointer);
    //GestureBinding.instance.gestureArena.release(event.pointer);

    var hitInterceptBox = GestureHitInterceptScope.of(context);
    hitInterceptBox?.interceptHitBox = this;
    if (event.isTouchEvent) {
      //debugger();
      pointerMap[event.pointer] = event;
    }

    if (event is PointerDownEvent) {
      //debugger();
      l.i('${event.pointer} ${event.runtimeType} ${event.device} ${event.position} ${event.localPosition} ${event.distance} ${event.size}');
      l.w(entry);
    } else if (event.isPointerMove) {
      //l.i('${event.pointer} ${event.runtimeType} ${event.delta}');
    } else if (event.isPointerFinish) {
      l.i('${event.pointer} ${event.runtimeType} ${event.device} ${event.position} ${event.localPosition}');
      l.w(entry);
      pointerMap.remove(event.pointer);
    }
    markNeedsPaint();
    super.handleEvent(event, entry);
  }

  @override
  bool debugHandleEvent(PointerEvent event, HitTestEntry<HitTestTarget> entry) {
    debugger();
    return super.debugHandleEvent(event, entry);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}
