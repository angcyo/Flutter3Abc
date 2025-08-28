part of '../flutter3_abc.dart';

///
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2024/02/06
///
class MatrixAbc extends StatefulWidget {
  const MatrixAbc({super.key});

  @override
  State<MatrixAbc> createState() => _MatrixAbcState();
}

class _MatrixAbcState extends State<MatrixAbc> with BaseAbcStateMixin {
  Matrix4 matrix4 = Matrix4.identity();

  String result = '';

  /// 旋转步长, 弧度单位 30 = 0.5235987755982988
  double rotateStep = 45.toRadians; //pi / 8;

  /// 平移步长, 距离
  double translateStep = 10.0;

  /// 缩放步长, 比例
  double scaleStep = 1.1;

  /// 倾斜步长, 比例
  double skewStep = 0.1;

  void _translateX() {
    matrix4.translate(translateStep);
    setState(() {
      result = matrix4.toString();
    });
  }

  void _translateY() {
    matrix4.translate(0.0, translateStep);
    setState(() {
      result = matrix4.toString();
    });
  }

  void _translateZ() {
    matrix4.translate(0.0, 0, translateStep);
    setState(() {
      result = matrix4.toString();
    });
  }

  void _scaleX() {
    matrix4.scale(scaleStep, 1.0, 1.0);
    setState(() {
      result = matrix4.toString();
    });
  }

  void _scaleY() {
    matrix4.scale(1.0, scaleStep, 1.0);
    setState(() {
      result = matrix4.toString();
    });
  }

  void _scaleZ() {
    matrix4.scale(1.0, 1.0, scaleStep);
    setState(() {
      result = matrix4.toString();
    });
  }

  /// 旋转X轴, 弧度单位
  void _rotateX() {
    matrix4.rotateX(rotateStep);
    setState(() {
      result = matrix4.toString();
    });
  }

  void _rotateY() {
    matrix4.rotateY(rotateStep);
    setState(() {
      result = matrix4.toString();
    });
  }

  /// 意义上的旋转, 其实就是旋转Z轴
  void _rotateZ() {
    matrix4.rotateZ(rotateStep);
    setState(() {
      result = matrix4.toString();
    });
  }

  void _skewX() {
    matrix4.skewBy(kx: skewStep);
    setState(() {
      result = matrix4.toString();
    });
  }

  void _skewY() {
    matrix4.skewBy(ky: skewStep);
    setState(() {
      result = matrix4.toString();
    });
  }

  @implementation
  void _skewZ() {
    toastInfo('暂不支持');
  }

  /// 重置
  void _reset() {
    translateStep = translateStep.inverted;
    scaleStep = scaleStep.inverted;
    skewStep = skewStep.inverted;
    rotateStep = rotateStep.inverted;

    matrix4 = Matrix4.identity();
    setState(() {
      result = matrix4.toString();
    });
  }

  /// 重置平移
  void _resetTranslate() {
    translateStep = translateStep.inverted;

    matrix4 = matrix4.clone()..setTranslation(Vector3.zero());
    setState(() {
      result = matrix4.toString();
    });
  }

  /// 重置缩放
  void _resetScale() {
    scaleStep = scaleStep.inverted();

    matrix4 = matrix4.clone()..scaleTo(sx: 1.0, sy: 1.0, sz: 1.0);
    setState(() {
      result = matrix4.toString();
    });
  }

  /// 重置旋转
  void _resetRotate() {
    rotateStep = rotateStep.inverted();

    matrix4 = matrix4.clone()..setRotation(Matrix3.identity());
    setState(() {
      result = matrix4.toString();
    });
  }

  void _resetSkew() {
    skewStep = skewStep.inverted();

    matrix4 = matrix4.clone()..skewTo(kx: 0.0, ky: 0.0);
    setState(() {
      result = matrix4.toString();
    });
  }

  @override
  List<Widget> buildBodyList(BuildContext context) {
    const height = 30.0;
    const digits = 6;
    const digits2 = 1;
    const fontSize = 12.0;
    const tipFontSize = 14.0;
    postCallback(() {
      matrix4.decomposeTest();
    });
    /*final qua = Quaternion.fromRotation(matrix4.getRotation());
    debugger();*/

    testMatrix();

    final qrList = matrix4.qrDecomposition();
    final qrMatrix = Matrix4.identity()
      ..skewTo(kx: qrList[3], ky: qrList[4])
      ..scaleBy(sx: qrList[1], sy: qrList[2])
      ..rotateBy(qrList[0])
      ..translateTo(
          x: matrix4.translateX, y: matrix4.translateY, z: matrix4.translateZ);
    return [
      [
        matrix4.toMatrixString().trim().text(fontSize: fontSize).expanded(),
        "-->".text(
            fontSize: fontSize,
            textColor: Colors.pinkAccent,
            textAlign: TextAlign.center),
        matrix4
            .getRotation()
            .toMatrixString()
            .trim()
            .text(fontSize: fontSize, textColor: Colors.pinkAccent)
            .expanded(),
      ].row()!,
      [
        matrix4
            .toMatrix3()
            .toMatrixString()
            .trim()
            .text(fontSize: fontSize, textColor: Colors.greenAccent)
            .expanded(),
        "-->".text(
            fontSize: fontSize,
            textColor: Colors.greenAccent,
            textAlign: TextAlign.center),
        matrix4
            .toMatrix3()
            .toMatrix4()
            .toMatrixString()
            .trim()
            .text(fontSize: fontSize, textColor: Colors.greenAccent)
            .expanded(),
      ].row()!,
      //matrix4.toString().trim().text(fontSize: 8),
      GradientButton.min(
        onTap: _reset,
        child: "重置".text(),
      ).paddingAll(kH),
      [
        GradientButton.min(
          onTap: _resetTranslate,
          child: "重置($translateStep)".text(),
        ),
        GradientButton.min(
          onTap: _translateX,
          child: "平移x".text(),
        ),
        GradientButton.min(
          onTap: _translateY,
          child: "平移y".text(),
        ),
        GradientButton.min(
          onTap: _translateZ,
          child: "平移z".text(),
        ),
      ].wrap()!.padding(kH, 2),
      [
        GradientButton.min(
          onTap: _resetScale,
          child: "重置($scaleStep)".text(),
        ),
        GradientButton.min(
          onTap: _scaleX,
          child: "缩放x".text(),
        ),
        GradientButton.min(
          onTap: _scaleY,
          child: "缩放y".text(),
        ),
        GradientButton.min(
          onTap: _scaleZ,
          child: "缩放z".text(),
        ),
      ].wrap()!.padding(kH, 2),
      [
        GradientButton.min(
          onTap: _resetSkew,
          child: "重置($skewStep)".text(),
        ),
        GradientButton.min(
          onTap: _skewX,
          child: "倾斜x".text(),
        ),
        GradientButton.min(
          onTap: _skewY,
          child: "倾斜y".text(),
        ),
        GradientButton.min(
          onTap: _skewZ,
          child: "倾斜z".text(),
        ),
      ].wrap()!.padding(kH, 2),
      [
        GradientButton.min(
          onTap: _resetRotate,
          child: "重置(${rotateStep.toDegrees}°)".text(),
        ),
        GradientButton.min(
          onTap: _rotateX,
          child: "旋转x".text(),
        ),
        GradientButton.min(
          onTap: _rotateY,
          child: "旋转y".text(),
        ),
        GradientButton.min(
          onTap: _rotateZ,
          child: "旋转z".text(),
        ),
      ].wrap()!.padding(kH, 2),
      [
        const FlutterLogo()
            .colorFiltered(blendMode: BlendMode.srcIn)
            .ratio(1.9),
        const FlutterLogo()
            .colorFiltered(color: Colors.redAccent, blendMode: BlendMode.srcIn)
            .transform(matrix4.toMatrix3().toMatrix4())
            .ratio(1.9),
        const FlutterLogo()
            .colorFiltered(
                color: Colors.amberAccent, blendMode: BlendMode.srcIn)
            .transform(qrMatrix)
            .ratio(1.9),
        const FlutterLogo().transform(matrix4).ratio(1.9),
      ].stack()!,
      [
        textSpanBuilder((builder) {
          builder.addText("平移:\n",
              style: const TextStyle(fontSize: tipFontSize, color: Colors.red));
          builder.addText(
              "x: ${matrix4.translateX.toDigits(digits: digits)}\ny: ${matrix4.translateY.toDigits(digits: digits)}\nz: ${matrix4.translateZ.toDigits(digits: digits)}");
        }).expanded(),
        textSpanBuilder((builder) {
          builder.addText("缩放:\n",
              style: const TextStyle(fontSize: tipFontSize, color: Colors.red));
          builder.addText(
              "x: ${matrix4.scaleX.toDigits(digits: digits2)}\ny: ${matrix4.scaleY.toDigits(digits: digits2)}\nz: ${matrix4.scaleZ.toDigits(digits: digits2)}");
        }).expanded(),
        textSpanBuilder((builder) {
          builder.addText("倾斜:\n",
              style: const TextStyle(fontSize: tipFontSize, color: Colors.red));
          builder.addText(
              "x: ${matrix4.skewX.toDigits(digits: digits2)}\ny: ${matrix4.skewY.toDigits(digits: digits2)}\nz: ${matrix4.skewZ.toDigits(digits: digits2)}");
        }).expanded(),
        textSpanBuilder((builder) {
          builder.addText("倾斜(°):\n",
              style: const TextStyle(fontSize: tipFontSize, color: Colors.red));
          builder.addText(
              "x: ${matrix4.skewX.toDegrees.toDigits(digits: digits2)}\ny: ${matrix4.skewY.toDegrees.toDigits(digits: digits2)}\nz: ${matrix4.skewZ.toDegrees.toDigits(digits: digits2)}");
        }).expanded(),
        textSpanBuilder((builder) {
          builder.addText("旋转:\n",
              style: const TextStyle(fontSize: tipFontSize, color: Colors.red));
          builder.addText(
              "x: ${matrix4.rotationX.toDigits(digits: digits2)}\ny: ${matrix4.rotationY.toDigits(digits: digits2)}\nz: ${matrix4.rotationZ.toDigits(digits: digits2)}");
        }).expanded(),
        textSpanBuilder((builder) {
          builder.addText("旋转(°):\n",
              style: const TextStyle(fontSize: tipFontSize, color: Colors.red));
          builder.addText(
              "x: ${matrix4.rotationX.toDegrees.toDigits(digits: digits2)}\ny: ${matrix4.rotationY.toDegrees.toDigits(digits: digits2)}\nz: ${matrix4.rotationZ.toDegrees.toDigits(digits: digits2)}");
        }).expanded(),
      ].row()!,
      [
        textSpanBuilder((builder) {
          builder.addText("QR分解:\n",
              style: const TextStyle(fontSize: tipFontSize, color: Colors.red));
          builder.addText("旋转: ${qrList[0].toDigits(digits: digits2)}\n"
              "旋转: ${qrList[0].toDegrees.toDigits(digits: digits2)}°\n"
              "缩放x:${qrList[1].toDigits(digits: digits2)} y:${qrList[2].toDigits(digits: digits2)}\n"
              "倾斜x:${qrList[3].toDigits(digits: digits2)} y:${qrList[4].toDigits(digits: digits2)}\n"
              "倾斜x:${qrList[3].toDegrees.toDigits(digits: digits2)}° y:${qrList[4].toDegrees.toDigits(digits: digits2)}°");
        }).expanded(),
        "-->".text(
            fontSize: fontSize,
            textColor: Colors.pinkAccent,
            textAlign: TextAlign.center),
        qrMatrix
            .toMatrixString()
            .trim()
            .text(fontSize: fontSize, textColor: Colors.pinkAccent)
            .expanded(),
      ].row()!,
    ];
  }

  void testMatrix() {
    const rect = Rect.fromLTWH(0, 0, 10, 10);
    final matrix1 = Matrix4.identity();
    matrix1.skewBy(kx: -45.hd);
    final resultRect = matrix1.mapRect(rect);
    l.d('rect:$resultRect');
  }
}
