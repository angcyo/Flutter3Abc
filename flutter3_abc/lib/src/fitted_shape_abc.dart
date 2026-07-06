import 'package:flutter/material.dart';
import 'package:flutter3_app/flutter3_app.dart';

import '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/07/03
///
/// 图形拟合测试页面
class FittedShapeAbc extends StatefulWidget {
  const FittedShapeAbc({super.key});

  @override
  State<FittedShapeAbc> createState() => _FittedShapeAbcState();
}

class _FittedShapeAbcState extends State<FittedShapeAbc>
    with BaseAbcStateMixin {
  /// 涂鸦核心类
  final GraffitiDelegate graffitiDelegate = GraffitiDelegate();

  ///事件监听
  late final GraffitiListener graffitiListener = GraffitiListener(
    onPointerEvent: (event) {
      if (event.isTouchPointerEvent) {
        if (event.isPointerDown) {
          _points.clear();
        }
        if (_points.isEmpty || event.localPosition.d(_points.last) >= 10) {
          _points.add(event.localPosition);
        }
        updateState();
      }
    },
  );

  late final _points = <Offset>[];

  late final _testPainter = GraffitiFountainPenPainter()
    ..tag = "TestPainter"
    ..paint.color = Colors.redAccent
    ..pointPath = Path();

  @override
  void initState() {
    super.initState();
    graffitiDelegate.addGraffitiListener(graffitiListener);
    graffitiDelegate.graffitiEventManager.updatePointEventHandler(
      GraffitiFountainShapePenHandler()..checkLongPress = true,
    );
    graffitiDelegate.graffitiElementManager.addAfterElement(_testPainter);
    /*_testPainter.pointPath = Path() */ /*..addCircle(Offset(100, 100), 100)*/ /*;*/
  }

  late final _lineFieldConfig = TextFieldConfig(
    labelText: "线: 斜率,偏移",
    onChanged: (text) {
      _resetShapeFitted();
    },
  ).hive("_fitted_shape_line");
  late final _circleFieldConfig = TextFieldConfig(
    labelText: "圆: cx,cy,r",
    onChanged: (text) {
      _resetShapeFitted();
    },
  ).hive("_fitted_shape_circle");
  late final _rectangleFieldConfig = TextFieldConfig(
    labelText: "矩形: min_x,min_y,max_x,max_y",
    onChanged: (text) {
      _resetShapeFitted();
    },
  ).hive("_fitted_shape_rect");
  late final _rectangleRotatedFieldConfig = TextFieldConfig(
    labelText: "旋转矩形: obb(4个点,8个值)",
    onChanged: (text) {
      _resetShapeFitted();
    },
  ).hive("_fitted_shape_obb");
  late final _ellipseFieldConfig = TextFieldConfig(
    labelText: "椭圆: cx,cy,a,b,angle",
    onChanged: (text) {
      _resetShapeFitted();
    },
  ).hive("_fitted_shape_ellipse");
  late final _vArrowFieldConfig = TextFieldConfig(
    labelText: "v箭头: tx,ty,lx,ly,rx,ry",
    onChanged: (text) {
      _resetShapeFitted();
    },
  ).hive("_fitted_shape_vArrow");
  late final _triangleFieldConfig = TextFieldConfig(
    labelText: "三角形: p1,p2,p3",
    onChanged: (text) {
      _resetShapeFitted();
    },
  ).hive("_fitted_shape_triangle");
  late final _pentagonFieldConfig = TextFieldConfig(
    labelText: "五边形: cx,cy,r,angle,p...",
    onChanged: (text) {
      _resetShapeFitted();
    },
  ).hive("_fitted_shape_pentagon");
  late final _starFieldConfig = TextFieldConfig(
    labelText: "五角星: cx,cy,or,ir,angle",
    onChanged: (text) {
      _resetShapeFitted();
    },
  ).hive("_fitted_shape_star");
  late final _heartFieldConfig = TextFieldConfig(
    labelText: "心形: cx,cy,w,h",
    onChanged: (text) {
      _resetShapeFitted();
    },
  ).hive("_fitted_shape_heart");
  late final _polygonFieldConfig = TextFieldConfig(
    labelText: "多边形: x,y,x,y,x,y",
    onChanged: (text) {
      _resetShapeFitted();
    },
  ).hive("_fitted_shape_polygon");

  @override
  Widget buildAbc(BuildContext context) {
    return [
      GraffitiWidget(graffitiDelegate).expanded(),
      [
            _points
                .map((e) => "${e.dx},${e.dy}")
                .join('\n')
                .text(selectable: true)
                .constrainedMax(maxHeight: 200)
                .matchParentWidth(),
            [
              GradientButton.min(
                onTap: () {
                  _testPainter.pointPath = null;
                  graffitiDelegate.clearElements();
                },
                child: "清屏".text(),
              ),
            ].flowLayout(gap: kH)?.insets(all: kH).matchParentWidth(),
            SingleInputWidget(config: _lineFieldConfig),
            SingleInputWidget(config: _circleFieldConfig),
            SingleInputWidget(config: _rectangleFieldConfig),
            SingleInputWidget(config: _rectangleRotatedFieldConfig),
            SingleInputWidget(config: _ellipseFieldConfig),
            SingleInputWidget(config: _vArrowFieldConfig),
            SingleInputWidget(config: _triangleFieldConfig),
            SingleInputWidget(config: _pentagonFieldConfig),
            SingleInputWidget(config: _starFieldConfig),
            SingleInputWidget(config: _heartFieldConfig),
            SingleInputWidget(config: _polygonFieldConfig),
          ]
          .column(gap: kX)!
          .scroll()
          .matchParentHeight()
          .insets(all: 10)
          .card()
          .insets(all: 4)
          .size(width: $wXlBp()),
    ].row()!;
  }

  void _resetShapeFitted() {
    final path = Path();
    _testPainter.pointPath = path;
    final linePoint = _lineFieldConfig.text
        .split(",")
        .filterNullOrEmpty<String>();
    if (linePoint.length >= 2) {
      final k = linePoint[0].toDouble();
      final b = linePoint[1].toDouble();
      final fx = _points.firstOrNull?.dx ?? 0;
      final lx = _points.lastOrNull?.dx ?? 0;
      Shapes.buildLinePath(path: path, slope: k, intercept: b, x1: fx, x2: lx);
    }
    final circlePoint = _circleFieldConfig.text
        .split(",")
        .filterNullOrEmpty<String>();
    if (circlePoint.length >= 3) {
      final cx = circlePoint[0].toDouble();
      final cy = circlePoint[1].toDouble();
      final r = circlePoint[2].toDouble();
      Shapes.buildCirclePath(path: path, cx: cx, cy: cy, radius: r);
    }
    final rectanglePoint = _rectangleFieldConfig.text
        .split(",")
        .filterNullOrEmpty<String>();
    if (rectanglePoint.length >= 4) {
      final minX = rectanglePoint[0].toDouble();
      final minY = rectanglePoint[1].toDouble();
      final maxX = rectanglePoint[2].toDouble();
      final maxY = rectanglePoint[3].toDouble();
      Shapes.buildRectPath(
        path: path,
        minX: minX,
        minY: minY,
        maxX: maxX,
        maxY: maxY,
      );
    }
    final rectangleRotatedPoint = _rectangleRotatedFieldConfig.text
        .split(",")
        .filterNullOrEmpty<String>();
    if (rectangleRotatedPoint.length >= 8) {
      final x1 = rectangleRotatedPoint[0].toDouble();
      final y1 = rectangleRotatedPoint[1].toDouble();
      final x2 = rectangleRotatedPoint[2].toDouble();
      final y2 = rectangleRotatedPoint[3].toDouble();
      final x3 = rectangleRotatedPoint[4].toDouble();
      final y3 = rectangleRotatedPoint[5].toDouble();
      final x4 = rectangleRotatedPoint[6].toDouble();
      final y4 = rectangleRotatedPoint[7].toDouble();
      Shapes.buildOBBPath(
        path: path,
        x1: x1,
        y1: y1,
        x2: x2,
        y2: y2,
        x3: x3,
        y3: y3,
        x4: x4,
        y4: y4,
      );
    }
    final ellipsePoint = _ellipseFieldConfig.text
        .split(",")
        .filterNullOrEmpty<String>();
    if (ellipsePoint.length >= 5) {
      final cx = ellipsePoint[0].toDouble();
      final cy = ellipsePoint[1].toDouble();
      final a = ellipsePoint[2].toDouble();
      final b = ellipsePoint[3].toDouble();
      final angle = ellipsePoint[4].toDouble();

      path.addPath(
        Shapes.buildEllipsePath(
          cx: cx,
          cy: cy,
          axisA: a,
          axisB: b,
          angle: angle,
        ),
        .zero,
      );
    }
    final vArrowPoint = _vArrowFieldConfig.text
        .split(",")
        .filterNullOrEmpty<String>();
    if (vArrowPoint.length >= 6) {
      final tx = vArrowPoint[0].toDouble();
      final ty = vArrowPoint[1].toDouble();
      final lx = vArrowPoint[2].toDouble();
      final ly = vArrowPoint[3].toDouble();
      final rx = vArrowPoint[4].toDouble();
      final ry = vArrowPoint[5].toDouble();

      Shapes.buildVArrowPath(
        path: path,
        tx: tx,
        ty: ty,
        lx: lx,
        ly: ly,
        rx: rx,
        ry: ry,
      );
    }
    final trianglePoint = _triangleFieldConfig.text
        .split(",")
        .filterNullOrEmpty<String>();
    if (trianglePoint.length >= 6) {
      final x1 = trianglePoint[0].toDouble();
      final y1 = trianglePoint[1].toDouble();
      final x2 = trianglePoint[2].toDouble();
      final y2 = trianglePoint[3].toDouble();
      final x3 = trianglePoint[4].toDouble();
      final y3 = trianglePoint[5].toDouble();

      Shapes.buildTrianglePath(
        path: path,
        x1: x1,
        y1: y1,
        x2: x2,
        y2: y2,
        x3: x3,
        y3: y3,
      );
    }
    final pentagonPoint = _pentagonFieldConfig.text
        .split(",")
        .filterNullOrEmpty<String>();
    if (pentagonPoint.length >= 4) {
      Shapes.buildPentagonPath(
        path: path,
        points: pentagonPoint.map((e) => e.toDouble()).toList(),
      );
    }
    final starPoint = _starFieldConfig.text
        .split(",")
        .filterNullOrEmpty<String>();
    if (starPoint.length >= 5) {
      final cx = starPoint[0].toDouble();
      final cy = starPoint[1].toDouble();
      final or = starPoint[2].toDouble();
      final ir = starPoint[3].toDouble();
      final angle = starPoint[4].toDouble();
      path.addPath(
        Shapes.buildStarPath(
          cx: cx,
          cy: cy,
          outerRadius: or,
          innerRadius: ir,
          angle: angle,
        ),
        .zero,
      );
    }
    final heartPoint = _heartFieldConfig.text
        .split(",")
        .filterNullOrEmpty<String>();
    if (heartPoint.length >= 4) {
      final cx = heartPoint[0].toDouble();
      final cy = heartPoint[1].toDouble();
      final w = heartPoint[2].toDouble();
      final h = heartPoint[3].toDouble();

      path.addPath(Shapes.buildHeartPath(cx: cx, cy: cy, w: w, h: h), .zero);
    }
    final polygonPoint = _polygonFieldConfig.text
        .split(",")
        .filterNullOrEmpty<String>();
    if (polygonPoint.length >= 4) {
      Shapes.buildPentagonPath(
        path: path,
        points: polygonPoint.map((e) => e.toDouble()).toList(),
      );
    }
    _testPainter.refresh();
  }
}
