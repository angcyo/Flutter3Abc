part of '../../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/03/02
///

class PainterAbc extends StatefulWidget {
  const PainterAbc({super.key});

  @override
  State<PainterAbc> createState() => _PainterAbcState();
}

class _PainterAbcState extends State<PainterAbc> with BaseAbcStateMixin {
  /// ![](https://flutter.github.io/assets-for-api-docs/assets/dart-ui/path_add_arc_dark.png#gh-dark-mode-only)
  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      paintWidget((canvas, size) {
        //中点
        Offset center = Offset(size.width / 4, size.height / 4);
        //final center = Offset(100, 100);
        Paint paint = Paint()
          ..color = Colors.red
          ..strokeWidth = 10
          ..shader = sweepGradientShader(
            [Colors.blueAccent, Colors.redAccent],
            center: center,
          )
          ..style = PaintingStyle.fill;
        canvas.drawCircle(center, 30, paint);

        center = Offset(size.width / 2, size.height / 2);
        //final center = Offset(100, 100);
        paint = Paint()
          ..color = Colors.red
          ..strokeWidth = 10
          ..shader = radialGradientShader(
            30,
            [Colors.blueAccent, Colors.redAccent],
            center: center,
          )
          ..style = PaintingStyle.fill;
        canvas.drawCircle(center, 30, paint);

        center = Offset(size.width * 3 / 4, size.height * 3 / 4);
        //final center = Offset(100, 100);
        paint = Paint()
          ..color = Colors.red
          ..strokeWidth = 10
          ..shader = linearGradientShader(
            [Colors.blueAccent, Colors.redAccent],
            from: center + const Offset(-15, 0),
            to: center + const Offset(15, 0),
          )
          ..style = PaintingStyle.fill;
        canvas.drawCircle(center, 30, paint);

        //--
        const pointWidth = 15.0;
        final points = [
          Offset(pointWidth, size.height - pointWidth),
          Offset(pointWidth * 4, size.height - pointWidth),
          Offset(pointWidth * 8, size.height - pointWidth),
          Offset(pointWidth * 12, size.height - pointWidth),
        ];
        paint
          ..style = PaintingStyle.fill //style属性无效
          ..strokeCap = StrokeCap.round
          ..strokeWidth = pointWidth;
        canvas.translate(0, -100);
        canvas.drawPoints(PointMode.points, points, paint);
        canvas.translate(0, 30);
        canvas.drawPoints(PointMode.lines, points, paint);
        canvas.translate(0, 30);
        canvas.drawPoints(PointMode.polygon, points, paint);
      }).constrainedBox(
          BoxConstraints(minWidth: double.maxFinite, maxHeight: screenWidth)),
      paintWidget((canvas, size) {
        //中点
        final center = Offset(size.width / 2, size.height / 2);
        //绘制十字线
        final paint = Paint()
          ..color = Colors.red
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke;
        canvas.drawLine(
          Offset(0, center.dy),
          Offset(size.width, center.dy),
          paint,
        );
        canvas.drawLine(
          Offset(center.dx, 0),
          Offset(center.dx, size.height),
          paint,
        );
        //间隔角度
        const intervalAngle = 30;
        const radius = 100.0;
        //每隔指定的弧度绘制角度信息
        for (var i = 0; i < 360; i += intervalAngle) {
          final angle = i.toRadians;
          final offset = center.translate(
            radius * cos(angle),
            radius * sin(angle),
          );
          canvas.drawLine(center, offset, paint);
          canvas.drawCircle(offset, 2, paint);
          canvas.withTranslate(center.dx, center.dy, () {
            canvas.withRotate(i, () {
              canvas.drawText('$i° ${angle.toDigits()}',
                  offset: const Offset(radius, 0), getOffset: (painter) {
                return Offset(10, painter.height / -2);
              });
            });
          });
        }
      }).constrainedBox(
          BoxConstraints(minWidth: double.maxFinite, maxHeight: screenWidth)),
      paintWidget((canvas, size) {
        //中点
        final center = Offset(size.width / 2, size.height / 2);
        //绘制十字线
        final paint = Paint()
          ..color = Colors.red
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke;
        canvas.drawLine(
          Offset(0, center.dy),
          Offset(size.width, center.dy),
          paint,
        );
        canvas.drawLine(
          Offset(center.dx, 0),
          Offset(center.dx, size.height),
          paint,
        );
        //弧度列表
        const angleList = [
          0.0,
          pi / 4,
          -pi / 4,
          pi / 2,
          -pi / 2,
          -pi,
          pi * 3 / 4,
          -pi * 3 / 4,
        ];
        const radius = 100.0;
        //每隔指定的弧度绘制角度信息
        for (final angle in angleList) {
          final offset = center.translate(
            radius * cos(angle),
            radius * sin(angle),
          );
          canvas.drawLine(center, offset, paint);
          canvas.drawCircle(offset, 2, paint);
          canvas.withTranslate(center.dx, center.dy, () {
            canvas.withRotateRadians(angle, () {
              canvas.drawText('${angle.toDegrees}° ${angle.toDigits()}',
                  offset: const Offset(radius, 0), getOffset: (painter) {
                return Offset(10, painter.height / -2);
              });
            });
          });
        }
      }).constrainedBox(
          BoxConstraints(minWidth: double.maxFinite, maxHeight: screenWidth)),
      paintWidget((canvas, size) {
        final circlePath = Path()
          ..addOval(
              Rect.fromCircle(center: const Offset(100, 100), radius: 100));
        final arcPath = Path()
          ..addArc(
              const Rect.fromLTWH(0, 0, 200, 250), 0.toRadians, 360.toRadians);
        drawPathTest(arcPath, canvas, size);
      }).constrainedBox(
          BoxConstraints(minWidth: double.maxFinite, maxHeight: screenWidth)),
      paintWidget((canvas, size) {
        final arcPath = Path()
          ..addArc(
              const Rect.fromLTWH(0, 0, 200, 250), 0.toRadians, -360.toRadians);
        drawPathTest(arcPath, canvas, size);
      }).constrainedBox(
          BoxConstraints(minWidth: double.maxFinite, maxHeight: screenWidth)),
      paintWidget((canvas, size) {
        //--
        canvas.withTranslate(100, 100, () {
          final path = Path()..addRect(const Rect.fromLTWH(0, 0, 10, 10));
          canvas.drawPath(
              path,
              Paint()
                ..color = Colors.red
                ..style = PaintingStyle.stroke);

          final matrix1 = Matrix4.identity()..skewBy(kx: 45.toRadians);
          canvas.drawPath(
              path.transformPath(matrix1),
              Paint()
                ..color = Colors.amber
                ..style = PaintingStyle.stroke);

          final matrix2 = Matrix4.identity()..skewBy(ky: -45.toRadians);
          canvas.drawPath(
              path.transformPath(matrix2),
              Paint()
                ..color = Colors.blue
                ..style = PaintingStyle.stroke);
        });
        //--
        /*const initialRect = Rect.fromLTWH(0, 0, 80, 50);
        canvas.drawRect(
            initialRect,
            Paint()
              ..style = PaintingStyle.stroke
              ..color = Colors.purpleAccent);*/
        final initialProperty = PaintProperty()
          /*..left = 100
          ..top = 100*/
          ..width = 80
          ..height = 50;
        canvas.drawRect(
            initialProperty.paintBounds,
            Paint()
              ..style = PaintingStyle.stroke
              ..color = Colors.purpleAccent);
        //-
        initialProperty.translateTo(
          const Offset(100, 100),
          anchorAlignment: Alignment.center,
        );
        initialProperty.rotateTo(
          angle: 90,
          anchorAlignment: Alignment.center,
        );
        canvas.drawRect(
            initialProperty.paintBounds,
            Paint()
              ..style = PaintingStyle.stroke
              ..color = Colors.purpleAccent);
        canvas.withMatrix(initialProperty.operateMatrix, () {
          BaseTextPainter.createTextPainter(text: "angcyo")
              .paint(canvas, Offset.zero);
        });
      }).constrainedBox(
          BoxConstraints(minWidth: double.maxFinite, maxHeight: screenWidth)),
      paintWidget((canvas, size) {
        const rect = Rect.fromLTWH(0, 0, 50, 50);
        drawCrossLine(canvas, rect.rb, Colors.blueAccent);
        final element = Path()..addRect(rect);
        final elementMatrix = Matrix4.identity()
          ..translate(50.0, 50)
          ..rotateBy(45.hd, anchor: const Offset(25, 25));
        canvas.drawPath(
            element.transformPath(elementMatrix),
            Paint()
              ..color = Colors.purpleAccent
              ..style = PaintingStyle.stroke);
        final mapRect = elementMatrix.mapRect(rect);
        canvas.drawRect(
            mapRect,
            Paint()
              ..color = Colors.redAccent
              ..style = PaintingStyle.stroke);
        //--
        final boundsRect = Rect.fromLTRB(0, 0, mapRect.right, mapRect.bottom);
        final operateMatrix = Matrix4.identity()..scaleBy(sx: 1, sy: 3);
        canvas.drawRect(
            operateMatrix.mapRect(boundsRect),
            Paint()
              ..color = Colors.blueAccent
              ..style = PaintingStyle.stroke);
        canvas.drawPath(
            element.transformPath(elementMatrix.postConcatIt(operateMatrix)),
            Paint()
              ..color = Colors.purpleAccent
              ..style = PaintingStyle.stroke);
        canvas.drawRect(
            (elementMatrix.postConcatIt(operateMatrix)).mapRect(rect),
            Paint()
              ..color = Colors.redAccent
              ..style = PaintingStyle.stroke);
        /*drawCrossLine(
            canvas,
            elementMatrix.postConcatIt(operateMatrix).mapPoint(rect.center),
            Colors.blueAccent);*/
        /*drawCrossLine(
            canvas, operateMatrix.mapPoint(mapRect.center), Colors.blueAccent);*/ /*drawCrossLine(
            canvas, operateMatrix.mapPoint(mapRect.center), Colors.blueAccent);*/

        /*final property = PaintProperty();
        property.qrDecomposition(elementMatrix.postConcatIt(operateMatrix));
        canvas.withTranslate(100, 100, () {
          canvas.drawPath(
              element.transformPath(property.scaleRotateMatrix),
              Paint()
                ..color = Colors.yellowAccent
                ..style = PaintingStyle.stroke);
        });
        elementMatrix.postConcatIt(operateMatrix).decomposeTest();*/

        //debugger();
      }).constrainedBox(
          BoxConstraints(minWidth: double.maxFinite, maxHeight: screenWidth)),
      paintWidget((canvas, size) {
        canvas.withTranslate(100, 100, () {
          const rect = Rect.fromLTWH(0, 0, 50, 50);
          drawCrossLine(canvas, rect.lt, Colors.blueAccent);
          final path = Path()..addRect(rect);
          final matrix = Matrix4.identity()
            ..skewBy(kx: -0.8)
            ..postScale(sx: 1.5)
            ..postRotate(45.hd);
          canvas.drawPath(
              path.transformPath(matrix),
              Paint()
                ..color = Colors.red
                ..style = PaintingStyle.stroke);
          canvas.drawRect(
              matrix.mapRect(rect),
              Paint()
                ..color = Colors.blue
                ..style = PaintingStyle.stroke);
        });
      }).constrainedBox(
          BoxConstraints(minWidth: double.maxFinite, maxHeight: screenWidth)),
      paintWidget((canvas, size) {
        //canvas.drawColor(Colors.black12, BlendMode.srcOver);
        canvas.drawRect(
          Offset.zero & size,
          Paint()
            ..color = Colors.black12
            ..style = PaintingStyle.fill,
        );
        const text = "aGg jEh ajPp赢\n\nFf中赢چاچی";
        //const text = "angcyo";
        //const text = "a";
        //const text = "a a\n\na  ";
        //const text = "چاچی";
        NormalTextPainter()
          ..debugPaintBounds = true
          ..text = text
          ..fontSize = 14
          /*..strutHeight = 1*/
          ..initPainter()
          ..painterText(canvas, Offset.zero);
        NormalTextPainter()
          ..debugPaintBounds = true
          ..text = text
          ..fontSize = 14
          ..orientation = kVertical
          ..initPainter()
          ..painterText(canvas, const Offset(100, 0));
        SingleCharTextPainter()
          ..debugPaintBounds = true
          ..text = text.wrapBidi()
          ..fontSize = 20
          ..isItalic = true
          ..textAlign = TextAlign.right
          ..crossTextAlign = TextAlign.center
          ..initPainter()
          ..painterText(canvas, const Offset(10, 60));
        SingleCharTextPainter()
          ..debugPaintBounds = true
          ..text = text
          ..isItalic = true
          ..fontSize = 20
          ..textAlign = TextAlign.left
          ..crossTextAlign = TextAlign.center
          ..orientation = kVertical
          ..initPainter()
          ..painterText(canvas, const Offset(320, 10));
        const curvature = 180.0;
        canvas.withTranslate(10, 160, () {
          final textPainter = SingleCurveCharTextPainter()
            ..debugPaintBounds = true
            ..text = text.wrapBidi()
            ..isItalic = false
            ..fontSize = 20
            ..curvature = curvature
            ..textAlign = TextAlign.left
            ..crossTextAlign = TextAlign.center
            ..orientation = kHorizontal
            ..strutHeight = 1
            ..initPainter()
            ..painterText(canvas, Offset.zero);
          canvas.drawCircle(
              textPainter.curveCenter,
              textPainter.curveRadius,
              Paint()
                ..style = PaintingStyle.stroke
                ..color = Colors.red);
          drawCrossLine(canvas, textPainter.curveCenter, Colors.red);
        });
        canvas.withTranslate(200, 260, () {
          final textPainter = SingleCurveCharTextPainter()
            ..debugPaintBounds = true
            ..text = text
            ..isItalic = false
            ..fontSize = 20
            ..curvature = curvature.inverted
            ..textAlign = TextAlign.left
            ..crossTextAlign = TextAlign.center
            ..orientation = kHorizontal
            ..strutHeight = 1
            ..initPainter()
            ..painterText(canvas, Offset.zero);
          canvas.drawCircle(
              textPainter.curveCenter,
              textPainter.curveRadius,
              Paint()
                ..style = PaintingStyle.stroke
                ..color = Colors.red);
          drawCrossLine(canvas, textPainter.curveCenter, Colors.red);
        });
      }).constrainedBox(
          BoxConstraints(minWidth: double.maxFinite, maxHeight: screenWidth)),
      paintWidget((canvas, size) {
        const rect = Rect.fromLTWH(0, 0, 50, 50);
        const offset = Offset(100, 100);

        final translate = Matrix4.identity()..translate(offset.dx, offset.dy);
        final scale = Matrix4.identity()..scale(1.5, 1.2);
        final rotate = Matrix4.identity()..rotateZ(30.hd);
        final Matrix4 operateMatrix = translate * rotate * scale;
        canvas.drawRect(
            rect + offset,
            Paint()
              ..style = PaintingStyle.stroke
              ..color = Colors.purpleAccent);
        canvas.withMatrix(
            offset.translateMatrix * operateMatrix.keepAnchor(rect.centerRight),
            () {
          canvas.drawRect(
              rect,
              Paint()
                ..style = PaintingStyle.stroke
                ..color = Colors.redAccent);
        });

        //---
        final rect2 = rect + offset;
        final afterRect2 = rect2.applyMatrix(scale,
            anchor: Offset(rect2.width / 2, rect2.height));
        canvas.drawRect(
            afterRect2,
            Paint()
              ..style = PaintingStyle.stroke
              ..color = Colors.purpleAccent);
      }).constrainedBox(
          BoxConstraints(minWidth: double.maxFinite, maxHeight: screenWidth)),
      paintWidget((canvas, size) {
        final circlePath = Path()
          ..addOval(const Rect.fromLTWH(100, 100, 100, 100));
        final cutPathList = circlePath.toCutPathList(
          cutDataStep: 0.5,
          cutDataWidth: 1,
        );

        for (final path in cutPathList) {
          canvas.drawPath(
              path,
              Paint()
                ..style = PaintingStyle.stroke
                ..color = Colors.purpleAccent);
        }
        /*canvas.drawPath(
            circlePath,
            Paint()
              ..style = PaintingStyle.stroke
              ..color = Colors.purpleAccent);*/
      }).constrainedBox(
          BoxConstraints(minWidth: double.maxFinite, maxHeight: screenWidth)),
    ];
  }

  @entryPoint
  void drawPathTest(Path path, Canvas canvas, Size size) {
    final drawPath = path;

    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    canvas.withTranslate(100, 100, () {
      canvas.drawPath(drawPath, paint);

      drawPath.eachPathMetrics(
          (posIndex, ratio, contourIndex, position, angle, isClosed) {
        canvas.withRotateRadians(angle, () {
          final p = position + const Offset(20, 0);
          canvas.drawLine(position, p, paint);
          //绘制一个向右的三角形
          canvas.drawPath(
              Path()
                ..moveTo(p.dx, p.dy - 5)
                ..lineTo(p.dx + 10, p.dy)
                ..lineTo(p.dx, p.dy + 5)
                ..close(),
              paint);
          canvas.drawText("${angle.toDegrees.toDigits()}°" /*angle.toDigits()*/,
              offset: p, getOffset: (painter) {
            return Offset(10, painter.height / -2);
          }, fontSize: 8);
        }, anchor: position);
      }, 30.0);
    });
  }

  /// 绘制十字线
  void drawCrossLine(Canvas canvas, Offset local, Color color) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(0, local.dy),
      Offset(canvas.getLocalClipBounds().width, local.dy),
      paint,
    );
    canvas.drawLine(
      Offset(local.dx, 0),
      Offset(local.dx, canvas.getLocalClipBounds().height),
      paint,
    );
  }
}
