part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/03/27
///

class LoadingWidgetAbc extends StatefulWidget {
  const LoadingWidgetAbc({super.key});

  @override
  State<LoadingWidgetAbc> createState() => _LoadingWidgetAbcState();
}

class _LoadingWidgetAbcState extends State<LoadingWidgetAbc>
    with BaseAbcStateMixin {
  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      paintWidget((canvas, size) {
        final paint = Paint()
          ..color = Colors.black12
          ..strokeWidth = 10
          ..style = PaintingStyle.stroke;
        final rect = Offset.zero & size;
        canvas.drawArc(rect, 0, 360.hd, false, paint);

        /*canvas.drawRect(
            // Rectangle
            Offset.zero & size,
            Paint()
              ..color = Colors.black12
              ..style = PaintingStyle.fill);*/
      }, size: const Size(double.infinity, 200)),
      const StrokeLoadingWidget().wh(100, 100),
      const StrokeLoadingWidget(
        contentSize: Size(40, 40),
        color: Colors.red,
      ).wh(100, 100),
      const ProgressBar(
        progress: 1,
        radius: 0,
      ).wh(10, 10),
      Empty.height(kH),
      const ProgressBar(
        progress: 1,
      ).wh(10, 60),
      Empty.height(kH),
      const ProgressBar(
        progress: 1,
      ),
      Empty.height(kH),
      const ProgressBar(
        progress: 1,
        radius: 0,
      ),
      Empty.height(kH),
      const DangerWarningWidget().size(size: 100),
      const SweepGradientLoadingWidget().size(size: 100),
    ];
  }
}
