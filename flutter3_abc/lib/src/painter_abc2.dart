part of '../../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/10/21
///
///
class PainterAbc2 extends StatefulWidget {
  const PainterAbc2({super.key});

  @override
  State<PainterAbc2> createState() => _PainterAbc2State();
}

class _PainterAbc2State extends State<PainterAbc2> with BaseAbcStateMixin {
  @override
  WidgetList buildBodyList(BuildContext context) {
    return [
      paintWidget((canvas, size) {
        final bounds = Offset.zero & size;
        canvas.drawRect(
          bounds,
          Paint()
            ..color = Colors.purpleAccent
            ..strokeWidth = 2
            ..style = PaintingStyle.stroke,
        );

        final r1 = 8.0;
        final r1Offset = Offset(0, 1.24);
        //绘制模糊阴影
        canvas.drawCircle(
          bounds.center + r1Offset,
          r1,
          Paint()
            ..color = Colors.green.withOpacity(0.4)
            ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5),
        );
        //绘制白色圆内容
        canvas.drawCircle(
          bounds.center,
          r1,
          Paint()..color = Colors.white,
        );
        final r2 = r1 - 2;
        //绘制绿色圆内容
        canvas.drawCircle(
          bounds.center,
          r2,
          Paint()..color = Colors.green,
        );
      }, size: Size(double.infinity, 200))
    ];
  }
}
