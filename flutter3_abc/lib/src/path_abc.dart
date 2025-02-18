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
      PathWidget(
        path: p1,
        shader: sweepGradientShader(
          [Colors.blueAccent, Colors.redAccent],
          rect: p1.getBounds(),
        ),
      ).bounds(),
      HttpDeviceXyzControlWidget().bounds(),
      //--
      Divider(),
      PathWidget(
        path: p2,
        shader: linearGradientShader(
          [Colors.blueAccent, Colors.redAccent],
          rect: p2.getBounds(),
        ),
      ).bounds(),
      if (!isNil(svgPath)) svgPath!.text(),
      [
        GradientButton.min(
          child: "each path".text(),
          onTap: () {
            svgPath = stringBuilder((b) {
              p2.eachPathMetrics(
                  (posIndex, ratio, contourIndex, position, angle, isClose) {
                b.append(
                    "[$contourIndex/$posIndex] position:${position.log}, angle:$angle, isClose:$isClose $ratio\n");
              }, 1 /*kPathAcceptableError*/);
            });
            updateState();
          },
        ),
        GradientButton.min(
          child: "each path(async)".text(),
          onTap: () async {
            StringBuffer buffer = StringBuffer();
            await p2.eachPathMetricsAsync(
                (posIndex, ratio, contourIndex, position, angle, isClose) {
              buffer.write(
                  "[$contourIndex/$posIndex] position:${position.log}, angle:$angle, isClose:$isClose $ratio\n");
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
      ].flowLayout(padding: edgeOnly(all: kH), childGap: kH)!,
    ];
  }
}
