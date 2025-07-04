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
    loadAssetImage(Assets.png.face.keyName).getValue().then((value) {
      _face = value;
      updateState();
    });
    super.initState();
  }

  @override
  WidgetList? buildScrollBody(BuildContext context) {
    testMatrix();
    return [
      $any(onPaint: (render, canvas, size, offset) {
        final matrix = perspectiveMatrix(from, to);
        canvas.withMatrix(
            matrix * createTranslateMatrix(tx: from[0].dx, ty: from[0].dy), () {
          canvas.drawImageInRect(_face,
              fit: BoxFit.fill,
              dst: Rect.fromLTWH(0, 0, right - left, bottom - top));
          canvas.drawText(
            matrix.toMatrixString(lineNumber: false, padWidth: 20),
            fontSize: 12,
            offset: from[0],
            textColor: Colors.white,
            bold: true,
            shadow: true,
          );
        });
        _drawPoint(canvas, from, Colors.black);
        _drawPoint(canvas, to, Colors.red);
      }).size(height: 120).click(() {
        setState(() {
          to.reset(from);
        });
      }).bounds(),
      $any(onPaint: (render, canvas, size, offset) {
        Matrix4 matrix = perspectiveMatrix(from, to);
        final transformString = matrix.toTransformString();
        l.d("transformString: $transformString");
        matrix = transformString.transformMatrix!;
        canvas.withMatrix(
            matrix * createTranslateMatrix(tx: from[0].dx, ty: from[0].dy), () {
          canvas.drawImageInRect(_face,
              fit: BoxFit.fill,
              dst: Rect.fromLTWH(0, 0, right - left, bottom - top));
          canvas.drawText(
            matrix.toMatrixString(lineNumber: false, padWidth: 20),
            fontSize: 12,
            offset: from[0],
            textColor: Colors.white,
            bold: true,
            shadow: true,
          );
        });
        _drawPoint(canvas, from, Colors.black);
        _drawPoint(canvas, to, Colors.red);
      }).size(height: 120).click(() {
        setState(() {
          to.reset(from);
        });
      }).bounds(),
      ..._buildToSlider(context, 0),
      ..._buildToSlider(context, 1),
      ..._buildToSlider(context, 2),
      ..._buildToSlider(context, 3),
    ];
  }

  WidgetList _buildToSlider(BuildContext context, int index) {
    final globalTheme = GlobalTheme.of(context);
    final offset = to[index];
    return [
      buildSliderWidget(context, progressIn(offset.x, minX, maxX),
          activeTrackColor: globalTheme.primaryColor, onChanged: (value) {
        setState(() {
          to[index] = Offset(value * (maxX - minX) + minX, offset.y);
        });
      }),
      buildSliderWidget(context, progressIn(offset.y, minY, maxY),
          activeTrackColor: globalTheme.primaryColorDark, onChanged: (value) {
        setState(() {
          to[index] = Offset(offset.x, value * (maxY - minY) + minY);
        });
      }),
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

/// 透视矩阵变换, 4个原始点, 4个目标点, 计算透视矩阵
///
/// https://franklinta.com/2014/09/08/computing-css-matrix3d-transforms/
Matrix4 perspectiveMatrix(List<Offset> from, List<Offset> to) {
  assert(from.length == 4 && to.length == 4);

  List<List<double>> A = []; // 8x8 matrix
  for (int i = 0; i < 4; i++) {
    A.add([
      from[i].x,
      from[i].y,
      1,
      0,
      0,
      0,
      -from[i].x * to[i].x,
      -from[i].y * to[i].x
    ]);
    A.add([
      0,
      0,
      0,
      from[i].x,
      from[i].y,
      1,
      -from[i].x * to[i].y,
      -from[i].y * to[i].y
    ]);
  }

  List<double> b = []; // 8x1 vector
  for (int i = 0; i < 4; i++) {
    b.add(to[i].x);
    b.add(to[i].y);
  }

  // Solve A * h = b for h (homogeneous coordinates)
  List<double> h = solve(A, b);

  // Construct the transformation matrix H
  List<List<double>> H = [
    [h[0], h[1], 0, h[2]],
    [h[3], h[4], 0, h[5]],
    [0, 0, 1, 0],
    [h[6], h[7], 0, 1]
  ];

  return Matrix4.fromList([
    H[0][0],
    H[1][0],
    H[2][0],
    H[3][0],
    H[0][1],
    H[1][1],
    H[2][1],
    H[3][1],
    H[0][2],
    H[1][2],
    H[2][2],
    H[3][2],
    H[0][3],
    H[1][3],
    H[2][3],
    H[3][3],
  ]);
}

/// 线性方程组求解
List<double> solve(List<List<double>> A, List<double> b) {
  int n = A.length;

  // 增强矩阵 A，将常数项 b 添加到 A 的最后一列
  for (int i = 0; i < n; i++) {
    A[i].add(b[i]);
  }

  // 前向消元
  for (int i = 0; i < n; i++) {
    // 找到当前列中的最大元素
    double maxEl = A[i][i].abs();
    int maxRow = i;
    for (int k = i + 1; k < n; k++) {
      if (A[k][i].abs() > maxEl) {
        maxEl = A[k][i].abs();
        maxRow = k;
      }
    }

    // 将最大行与当前行交换
    if (maxRow != i) {
      List<double> temp = A[maxRow];
      A[maxRow] = A[i];
      A[i] = temp;
    }

    // 使主元素下方的元素等于零
    for (int k = i + 1; k < n; k++) {
      double c = -A[k][i] / A[i][i]; // 计算消元因子
      for (int j = i; j < n + 1; j++) {
        if (i == j) {
          A[k][j] = 0; // 主对角线元素置为零
        } else {
          A[k][j] += c * A[i][j]; // 更新当前行
        }
      }
    }
  }

  // 回代过程
  List<double> x = List<double>.filled(n, 0); // 初始化解向量
  for (int i = n - 1; i >= 0; i--) {
    x[i] = A[i][n] / A[i][i]; // 计算每个变量的值
    for (int k = i - 1; k >= 0; k--) {
      A[k][n] -= A[k][i] * x[i]; // 更新前面行的常数项
    }
  }

  return x; // 返回解向量
}
