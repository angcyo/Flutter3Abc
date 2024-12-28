part of '../../flutter3_abc.dart';

///
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2023/11/05
///

/*class WidgetAbc extends BaseAbc {
  const WidgetAbc({super.key});

  @override
  buildBody(BuildContext context) {
    return AfterLayout(
        callback: (parentContext, childRenderObject) {
          l.d('AfterLayout[${childRenderObject?.getRenderObjectBounds(context.findRenderObject())}]->↓\n$parentContext\n$childRenderObject');
        },
        child: randomWidget("...test..."));
  }
}*/

class WidgetAbc extends StatefulWidget {
  const WidgetAbc({super.key});

  @override
  State<WidgetAbc> createState() => _WidgetAbcState();
}

class _WidgetAbcState extends State<WidgetAbc>
    with BaseAbcStateMixin, TileMixin {
  bool _isSet = false;
  String _sizeText = "...test...";
  late double height;

  double _value = 0;
  double _secondValue = 1;

  @override
  void initState() {
    useScroll = true;
    height =
        nextDouble(kMinInteractiveDimension, platformMediaQueryData.size.width);
    super.initState();
  }

  @override
  Widget buildBody(BuildContext context) {
    return [
      AfterLayout(
          afterLayoutAction: (parentContext, childRenderBox) {
            postFrameCallback((duration) {
              final bounds =
                  childRenderBox.getGlobalBounds(context.findRenderObject());
              l.d('AfterLayout[$bounds]->↓\n$parentContext\n$childRenderBox');
              final newText = bounds.toString();
              if (_sizeText != newText) {
                setState(() {
                  _sizeText = newText;
                });
              }
            });
          },
          child: randomWidget(text: _sizeText, height: height)),
      [
        "1"
            .text()
            .container(
              alignment: Alignment.center,
              color: Colors.black26,
              width: 60,
              height: 60,
            )
            .ink(() {}),
        "2"
            .text()
            .container(
              alignment: Alignment.center,
              color: Colors.black26,
              width: 60,
              height: 60,
            )
            .ink(() {})
            .position(right: 0, bottom: 0),
        "3"
            .text()
            .align(Alignment.center)
            .size(
              width: 60,
              height: 60,
            )
            .ink(() {})
            .align(Alignment.center),
      ]
          .stack()!
          .container(color: Colors.black12)
          .size(width: double.infinity, height: 200),
      FlowLayout(
        children: [
          const CustomPaint(
            painter: TrianglePainter(
                color: Colors.redAccent, direction: AxisDirection.left),
          ).wh(20, 30),
          const CustomPaint(
            painter: TrianglePainter(
                color: Colors.redAccent, direction: AxisDirection.up),
          ).wh(30, 20),
          const CustomPaint(
            painter: TrianglePainter(
                color: Colors.redAccent, direction: AxisDirection.right),
          ).wh(20, 30),
          const CustomPaint(
            painter: TrianglePainter(
                color: Colors.redAccent, direction: AxisDirection.down),
          ).wh(30, 20),
        ],
      ),
      SliderTheme(
        data: const SliderThemeData(
            showValueIndicator: ShowValueIndicator.always),
        child: Slider(
          value: _value,
          min: -1,
          max: 1,
          divisions: 200,
          label: _value.toDigits(),
          onChanged: (value) {
            _value = value;
            updateState();
          },
        ),
      ),
      buildSliderWidget(
        context,
        _value,
        minValue: -1,
        maxValue: 1,
        divisions: 200,
        activeTrackGradientColors: EngraveTileMixin.sActiveTrackGradientColors,
        label: _value.toDigits(),
        onChanged: (value) {
          _value = value;
          updateState();
        },
      ),
      buildSliderWidget(
        context,
        _value,
        minValue: -1,
        maxValue: 1,
        divisions: 200,
        useCenteredTrackShape: true,
        activeTrackGradientColors: EngraveTileMixin.sActiveTrackGradientColors,
        label: _value.toDigits(),
        onChanged: (value) {
          _value = value;
          updateState();
        },
      ),
      buildRangeSliderWidget(
        context,
        _value,
        _secondValue,
        minValue: -1,
        maxValue: 1,
        startLabel: _value.toDigits(),
        endLabel: _secondValue.toDigits(),
        onChanged: (values) {
          _value = values.start;
          _secondValue = values.end;
          updateState();
        },
      ),
      buildRangeSliderWidget(
        context,
        _value,
        _secondValue,
        minValue: -1,
        maxValue: 1,
        divisions: 200,
        useCenteredTrackShape: true,
        activeTrackGradientColors: EngraveTileMixin.sActiveTrackGradientColors,
        startLabel: _value.toDigits(),
        endLabel: _secondValue.toDigits(),
        onChanged: (values) {
          _value = values.start;
          _secondValue = values.end;
          updateState();
        },
      ),
    ].scroll(axis: Axis.vertical)!;
  }
}
