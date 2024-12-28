part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/11/10
///

class BoxShadowAbc extends StatefulWidget {
  const BoxShadowAbc({super.key});

  @override
  State<BoxShadowAbc> createState() => _BoxShadowAbcState();
}

class _BoxShadowAbcState extends State<BoxShadowAbc> with BaseAbcStateMixin {
  double offsetX = 0;
  double offsetY = 3;
  double offsetMinValue = -100;
  double offsetMaxValue = 100;

  double blurRadius = 0;
  double blurRadiusMinValue = 0;
  double blurRadiusMaxValue = 100;

  double spreadRadius = 0;
  double spreadRadiusMinValue = -100;
  double spreadRadiusMaxValue = 100;

  BlurStyle blurStyle = BlurStyle.normal;

  @override
  List<Widget> buildBodyList(BuildContext context) {
    List<ButtonSegment> segments = [
      const ButtonSegment(value: BlurStyle.normal, label: Text("normal")),
      const ButtonSegment(value: BlurStyle.solid, label: Text("solid")),
      const ButtonSegment(value: BlurStyle.outer, label: Text("outer")),
      const ButtonSegment(value: BlurStyle.inner, label: Text("inner")),
    ];
    return [
      Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 100,
          height: 100,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: spreadRadius,
                  blurRadius: blurRadius,
                  blurStyle: blurStyle,
                  offset: Offset(
                    offsetX,
                    offsetY,
                  ), // changes position of shadow
                ),
              ],
            ),
            child: randomTextWidget(),
          ),
        ).paddingAll(100),
      ),
      SegmentedButton(
          segments: segments,
          selected: {blurStyle},
          style: const ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap, //收紧大小
            visualDensity: VisualDensity(horizontal: -4, vertical: -1), //最小视觉密度
          ),
          onSelectionChanged: (value) {
            setState(() {
              blurStyle = value.first;
            });
          }),
      Row(
        children: [
          const Text("blurRadius:"),
          SliderTheme(
              data: const SliderThemeData(
                showValueIndicator: ShowValueIndicator.always,
              ),
              child: Slider(
                value: blurRadius,
                min: blurRadiusMinValue,
                max: blurRadiusMaxValue,
                label: blurRadius.toDigits(),
                onChanged: (v) => setState(() => blurRadius = v),
              ).expanded()),
        ],
      ),
      Row(
        children: [
          const Text("spreadRadius:"),
          SliderTheme(
              data: const SliderThemeData(
                showValueIndicator: ShowValueIndicator.always,
              ),
              child: Slider(
                value: spreadRadius,
                min: spreadRadiusMinValue,
                max: spreadRadiusMaxValue,
                label: spreadRadius.toDigits(),
                onChanged: (v) => setState(() => spreadRadius = v),
              ).expanded()),
        ],
      ),
      Row(
        children: [
          const Text("Offset X:"),
          SliderTheme(
              data: const SliderThemeData(
                showValueIndicator: ShowValueIndicator.always,
              ),
              child: Slider(
                value: offsetX,
                min: offsetMinValue,
                max: offsetMaxValue,
                label: offsetX.toDigits(),
                onChanged: (v) => setState(() => offsetX = v),
              ).expanded()),
        ],
      ),
      Row(
        children: [
          const Text("Offset Y:"),
          SliderTheme(
            data: const SliderThemeData(
              showValueIndicator: ShowValueIndicator.always,
            ),
            child: Slider(
              value: offsetY,
              min: offsetMinValue,
              max: offsetMaxValue,
              label: offsetY.toDigits(),
              onChanged: (v) => setState(() => offsetY = v),
            ).expanded(),
          ),
        ],
      )
    ];
  }
}
