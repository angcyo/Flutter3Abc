part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/12/12
///
class MatrixAbc2 extends StatefulWidget {
  const MatrixAbc2({super.key});

  @override
  State<MatrixAbc2> createState() => _MatrixAbc2State();
}

class _MatrixAbc2State extends State<MatrixAbc2> with AbsScrollPage, TileMixin {
  final minX = 0.0;
  final maxX = 400.0;

  final minY = 0.0;
  final maxY = 200.0;

  final left = 10.0;
  final right = 300.0;
  final top = 10.0;
  final bottom = 100.0;

  late final List<Offset> from = [
    Offset(left, top),
    Offset(right, top),
    Offset(right, bottom),
    Offset(left, bottom),
  ];

  late final List<Offset> to = [
    Offset(20, 20),
    Offset(250, 10),
    Offset(100, 100),
    Offset(30, 80),
  ];

  UiImage? _face;

  @override
  void initState() {
    loadAssetImage(Assets.png.face.keyName).getValue(null).then((value) {
      _face = value;
      updateState();
    });
    super.initState();
  }

  Rect _testRect = .zero;
  Matrix4? _testMatrix;

  @override
  WidgetList? buildScrollBody(BuildContext context) {
    testMatrix();
    return [
      $any(
        onPaint: (render, canvas, size, offset) {
          final matrix = createPerspectiveMatrix(from, to);
          canvas.withMatrix(
            createTranslateMatrix(tx: offset.dx, ty: offset.dy) *
                matrix *
                createTranslateMatrix(tx: from[0].dx, ty: from[0].dy),
            () {
              canvas.drawImageInRect(
                _face,
                fit: BoxFit.fill,
                dst: Rect.fromLTWH(0, 0, right - left, bottom - top),
              );
              canvas.drawText(
                matrix.toMatrixString(lineNumber: false, padWidth: 20),
                fontSize: 12,
                offset: from[0],
                textColor: Colors.white,
                bold: true,
                shadow: true,
              );
              //--
              if (_testMatrix != null) {
                canvas.withMatrix(_testMatrix, () {
                  canvas.drawImageInRect(
                    _face,
                    fit: BoxFit.fill,
                    dst: _testRect,
                  );
                });
                canvas.drawText(
                  _testMatrix!.toMatrixString(lineNumber: false, padWidth: 20),
                  /*"$_testMatrix",*/
                  fontSize: 12,
                  offset: Offset(from[1].dx * 2, from[1].dy),
                  textColor: Colors.white,
                  bold: true,
                  shadow: true,
                );
              }
            },
          );
          _drawPoint(canvas, from, Colors.black);
          _drawPoint(canvas, to, Colors.red);
        },
      ).size(height: 120).click(() {
        setState(() {
          to.reset(from);
        });
      }).bounds(),
      $any(
        onPaint: (render, canvas, size, offset) {
          Matrix4 matrix = createPerspectiveMatrix(from, to);
          final transformString = matrix.toTransformString();
          l.d("transformString: $transformString");
          matrix = transformString.transformMatrix!;
          canvas.withMatrix(
            createTranslateMatrix(tx: offset.dx, ty: offset.dy) *
                matrix *
                createTranslateMatrix(tx: from[0].dx, ty: from[0].dy),
            () {
              canvas.drawImageInRect(
                _face,
                fit: BoxFit.fill,
                dst: Rect.fromLTWH(0, 0, right - left, bottom - top),
              );
              canvas.drawText(
                matrix.toMatrixString(lineNumber: false, padWidth: 20),
                fontSize: 12,
                offset: from[0],
                textColor: Colors.white,
                bold: true,
                shadow: true,
              );
            },
          );
          _drawPoint(canvas, from, Colors.black);
          _drawPoint(canvas, to, Colors.red);
        },
      ).size(height: 120).click(() {
        setState(() {
          to.reset(from);
        });
      }).bounds(),
      _MatrixTestRenderWidget(
        onPaintMatrixAction: (matrix, rect) {
          _testRect = rect;
          _testMatrix = matrix;
          updateState();
        },
      ).size(height: 200).bounds(),
      ..._buildToSlider(context, 0, "左上坐标↓"),
      ..._buildToSlider(context, 1, "右上坐标↓"),
      ..._buildToSlider(context, 2, "右下坐标↓"),
      ..._buildToSlider(context, 3, "左下坐标↓"),
    ];
  }

  WidgetList _buildToSlider(BuildContext context, int index, String label) {
    final globalTheme = GlobalTheme.of(context);
    final offset = to[index];
    return [
      label.text().insets(left: kH),
      buildSliderWidget(
        context,
        progressIn(offset.x, minX, maxX),
        activeTrackColor: globalTheme.primaryColor,
        onChanged: (value) {
          setState(() {
            to[index] = Offset(value * (maxX - minX) + minX, offset.y);
          });
        },
      ),
      buildSliderWidget(
        context,
        progressIn(offset.y, minY, maxY),
        activeTrackColor: globalTheme.primaryColorDark,
        onChanged: (value) {
          setState(() {
            to[index] = Offset(offset.x, value * (maxY - minY) + minY);
          });
        },
      ),
    ];
  }

  /// 绘制点
  void _drawPoint(Canvas canvas, List<Offset> points, Color color) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;
    final path = Path();
    for (var i = 0; i < points.length; i++) {
      final point = points[i];
      canvas.drawCircle(point, 4, paint);
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    paint.style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);
  }

  void testMatrix() {
    //toString() row
    //```
    //[0] [1.0,0.0,0.0]
    //[1] [0.0,1.0,0.0]
    //[2] [0.0,0.0,1.0]
    //旋转15°
    //[0] [0.9659258262890683(sx),  -0.25881904510252074(kx),  0.0(tx)]
    //[1] [0.25881904510252074(ky),  0.9659258262890683(sy),   0.0(ty)]
    //[2] [0.0,                      0.0,                      1.0]
    //0.9659258262890683(sx),0.25881904510252074(ky),0.0, -0.25881904510252074(kx),0.9659258262890683(sy),0.0, 0.0(tx),0.0(ty),1.0
    //```
    final matrix3 = Matrix3.identity()..setRotationZ(15.hd);
    //1.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,1.0
    //0.9659258262890683(sx), 0.25881904510252074(ky), 0.0, -0.25881904510252074(kx), 0.9659258262890683(sy), 0.0, 0.0(tx), 0.0(ty), 1.0
    //
    //0.9659258262890683,0.25881904510252074,0.0,
    //-0.25881904510252074,0.9659258262890683,0.0,
    //0.0,0.0,1.0
    matrix3.storage;
    //toString() row
    //```
    //[0] 1.0,0.0,0.0,0.0
    //[1] 0.0,1.0,0.0,0.0
    //[2] 0.0,0.0,1.0,0.0
    //[3] 0.0,0.0,0.0,1.0
    //先平移, 旋转15°
    //[0] 0.9659258262890683(sx),  -0.25881904510252074(kx), 0.0,     50.0(tx)
    //[1] 0.25881904510252074(ky),  0.9659258262890683(sy),  0.0,     100.0(ty)
    //[2] 0.0,                      0.0,                     1.0(sz), 0.0(tz)
    //[3] 0.0,                      0.0,                     0.0,     1.0
    //0.9659258262890683(sx),0.25881904510252074(ky),0.0,0.0, -0.25881904510252074(kx),0.9659258262890683(sy),0.0,0.0, 0.0,0.0,1.0(sz),0.0, 50.0(tx),100.0(ty),0.0(tz),1.0
    //```
    final matrix4 = Matrix4.identity()
      ..translate(50.0, 100.0)
      ..setRotationZ(15.hd);
    //1.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0
    //0.9659258262890683,0.25881904510252074,0.0,0.0,-0.25881904510252074,0.9659258262890683,0.0,0.0,0.0,0.0,1.0,0.0,50.0,100.0,0.0,1.0
    //
    //0.9659258262890683,   0.25881904510252074, 0.0, 0.0,
    //-0.25881904510252074, 0.9659258262890683,  0.0, 0.0,
    //0.0,                  0.0,                 1.0, 0.0,
    //50.0,                 100.0,               0.0, 1.0
    matrix4.storage;
    final string = matrix4.toTransformString();
    final matrix4_ = string.transformMatrix;
    //debugger();
  }
}

class _MatrixTestRenderWidget extends LeafRenderObjectWidget {
  final void Function(Matrix4 matrix, Rect rect)? onPaintMatrixAction;

  const _MatrixTestRenderWidget({super.key, this.onPaintMatrixAction});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _MatrixTestRenderBox()..onPaintMatrixAction = onPaintMatrixAction;
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _MatrixTestRenderBox renderObject,
  ) {
    renderObject..onPaintMatrixAction = onPaintMatrixAction;
  }
}

class _MatrixTestRenderBox extends RenderBox {
  void Function(Matrix4 matrix, Rect rect)? onPaintMatrixAction;

  final Rect rect = Rect.fromLTWH(500, 50, 100, 100);
  Matrix4 matrix = Matrix4.identity();

  @override
  bool hitTestSelf(Offset position) {
    return true;
  }

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    //super.paint(context, offset);
    final Matrix4 drawMatrix = matrix * opMatrix;
    onPaintMatrixAction?.call(drawMatrix, rect);

    final canvas = context.canvas;
    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    canvas.save();
    canvas.transform(drawMatrix.storage);
    canvas.drawRect(
      rect,
      Paint()
        ..color = Colors.blue
        ..strokeWidth = 2
        ..style = .stroke,
    );
    canvas.restore();
    canvas.drawRect(
      drawMatrix.mapRect(rect),
      Paint()
        ..color = Colors.red
        ..strokeWidth = 2
        ..style = .stroke,
    );
    canvas.restore();
  }

  Offset _downPoint = Offset.zero;

  Matrix4 opMatrix = Matrix4.identity();

  @override
  void handleEvent(PointerEvent event, covariant BoxHitTestEntry entry) {
    //l.d("handleEvent: $event");
    if (event.isPointerDown) {
      _downPoint = event.localPosition;
    } else if (event.isPointerMove) {
      final movePoint = event.localPosition;
      final oldWidth = _downPoint.dx - rect.lt.dx;
      final newWidth = movePoint.dx - rect.lt.dx;
      final oldHeight = _downPoint.dy - rect.lt.dy;
      final newHeight = movePoint.dy - rect.lt.dy;

      final sx = newWidth / oldWidth;
      final sy = newHeight / oldHeight;

      opMatrix = Matrix4.identity()
        ..translate(rect.lt.dx, rect.lt.dy)
        ..scale(sx, sy)
        ..translate(-rect.lt.dx, -rect.lt.dy);
      markNeedsPaint();
    } else if (event.isPointerFinish) {
      matrix = matrix * opMatrix;
      opMatrix = Matrix4.identity();
    }
  }
}
