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
    final path = Path();
    path.moveTo(10, 10);
    path.lineTo(100, 20);
    return [
      PathWidget(
        path:
            "m23.167,330.833v-7h4.667v7h5.833v-9.333h3.5l-11.667-10.5-11.667,10.5h3.5v9.333h5.833Z"
                .toUiPath(),
      ).bounds(),
      HttpDeviceXyzControlWidget().bounds(),
      //--
      Divider(),
      PathWidget(path: path).bounds(),
      if (!isNil(svgPath)) svgPath!.text(),
      [
        GradientButton.min(
          child: "each path".text(),
          onTap: () {
            svgPath = stringBuilder((b) {
              path.eachPathMetrics(
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
            await path.eachPathMetricsAsync(
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
            svgPath = await path.toSvgPathStringAsync(
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
            svgPath = await path.toSvgPathStringAsync(
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
            svgPath = await path.toSvgPathStringAsync(
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
            svgPath = path.toSvgPathString(
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
