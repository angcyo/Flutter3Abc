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
  @override
  WidgetList? buildScrollBody(BuildContext context) {
    return [
      PathWidget(
        path:
            "m23.167,330.833v-7h4.667v7h5.833v-9.333h3.5l-11.667-10.5-11.667,10.5h3.5v9.333h5.833Z"
                .toUiPath(),
      ).bounds(),
      HttpDeviceXyzControlWidget().bounds(),
    ];
  }
}
