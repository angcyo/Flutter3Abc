import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter3_abc/flutter3_abc.dart';
import 'package:flutter3_app/flutter3_app.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/09/21
///
/// 液态玻璃小部件
class LiquidGlassAbc extends StatefulWidget {
  const LiquidGlassAbc({super.key});

  @override
  State<LiquidGlassAbc> createState() => _LiquidGlassAbcState();
}

class _LiquidGlassAbcState extends State<LiquidGlassAbc>
    with BaseAbcStateMixin, TileMixin {
  @override
  void initState() {
    LiquidGlassWidgets.initialize(
      enablePerformanceMonitor: isDebugFlag,
      warmUpMode: .auto,
    ).ignore();
    super.initState();
  }

  int selectedIndex = 0;

  /// [build]
  /// [buildAbc]
  @override
  Widget build(BuildContext context) {
    final globalConfig = GlobalConfig.of(context);
    final globalTheme = globalConfig.globalTheme;
    return LiquidGlassWidgets.wrap(
      /*child: super.build(context),*/
      child: GlassScaffold(
        backgroundColor: backgroundColor,
        /*background: Image.asset('assets/wallpaper.jpg', fit: BoxFit.cover),*/
        statusBarStyle: GlassStatusBarStyle.auto,
        appBar: GlassAppBar(
          title: Text("${title ?? '${widget.runtimeType}'} $selectedIndex"),
        ),
        body: buildAbc(context),
        bottomBar: GlassTabBar.bottom(
          tabs: [
            GlassTab(
              label: "Label1",
              icon: loadAbcSvgWidget(Assets.svg.pathUnion),
              glowColor: Colors.redAccent,
            ),
            GlassTab(
              label: "Label2",
              activeIcon: loadAbcSvgWidget(Assets.svg.pathDifference),
              glowColor: Colors.purpleAccent,
            ),
            GlassTab(
              label: "Label3",
              icon: loadAbcSvgWidget(Assets.svg.pathIntersect),
              glowColor: Colors.indigoAccent,
            ),
          ],
          selectedIndex: selectedIndex,
          onTabSelected: (value) {
            selectedIndex = value;
            updateState();
            //toastInfo("GlassTab $value");
            //GlassToast(message: "GlassTab $value");
          },
          /*tabPadding: insets(all: 30),*/
          horizontalPadding: 50,
          verticalPadding: 30,
          indicatorExpansion: insets(all: 20),
          /*interactionGlowColor: Colors.greenAccent,*/
          barBorderRadius: 30,
          indicatorBorderRadius: 30,
        ),
      ),
      brightnessResolver: (ctx) => globalConfig.themeModeBrightness,
      adaptiveQuality: true, // auto-benchmarks device, degrades gracefully
      theme: GlassThemeData.simple(
        // optional app-wide glass defaults
        blur: blur,
        thickness: thickness,
        lightIntensity: lightIntensity,
        ambientStrength: ambientStrength,
        saturation: saturation,
        quality: .standard,
      ),
    ).material();
  }

  /// 模糊半径
  /// [LiquidGlassSettings.blur]
  double blur = 10;

  /// 玻璃厚度
  /// [LiquidGlassSettings.thickness]
  double thickness = 30;

  /// 光强度
  /// [LiquidGlassSettings.lightIntensity]
  double lightIntensity = 0.5;

  /// 饱和度
  /// [LiquidGlassSettings.saturation]
  double saturation = 1.5;

  /// 环境强度
  /// [LiquidGlassSettings.ambientStrength]
  double ambientStrength = 0.5;

  double stepper = 0;
  bool switchValue = false;

  @override
  WidgetList buildBodyList(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return [
      Empty.height(kToolbarHeight),
      Center(
        child: GlassCard(
          child: 'Hello, GlassCard!'.text(selectable: true),
        ).insets(all: kH),
      ),
      GlassDivider(),
      Center(
        child: GlassContainer(
          child: 'Hello, GlassContainer!'.text(selectable: true),
        ).insets(all: kH),
      ),
      GlassDivider(),
      GlassGroupedSection(
        children: [
          'Hello, GlassGroupedSection 1!'.text(selectable: true),
          'Hello, GlassGroupedSection 2!'.text(selectable: true),
          'Hello, GlassGroupedSection 3!'.text(selectable: true),
        ],
      ),
      GlassDivider(),
      GlassListTile(
        title: 'Hello, GlassListTile!'.text(selectable: true),
        onTap: () {},
      ).insets(all: kX),
      GlassDivider(),
      GlassStepper(
        value: stepper,
        onChanged: (value) {
          stepper = value;
          updateState();
        },
      ).insets(all: kX),
      Center(
        child: GlassButton(
          label: "GlassButton",
          icon: Icon(Icons.home),
          onTap: () {},
        ),
      ),
      Center(
        child: GlassButton(
          shape: LiquidRoundedRectangle(borderRadius: 20),
          width: 200,
          icon: [
            Icon(Icons.mail),
            "GlassButton".text(),
          ].row(mainAxisAlignment: .center)?.insets(h: 20),
          onTap: () {},
        ),
      ),
      GlassDivider(),
      Center(
        child: GlassIconButton(icon: Icon(Icons.home), onPressed: () {}),
      ),
      Center(
        child: GlassIconButton(
          icon: Icon(Icons.home),
          onPressed: () {},
          shape: .roundedSquare,
        ),
      ),
      Center(
        child: GlassChip(
          label: "GlassChip",
          icon: Icon(Icons.home),
          onTap: () {},
        ),
      ),
      Center(
        child: GlassChip(
          label: "GlassChip",
          icon: Icon(Icons.home),
          selected: true,
          onTap: () {},
        ),
      ),
      Center(
        child: GlassChip(
          label: "GlassChip",
          icon: Icon(Icons.home),
          selected: true,
          selectedColor: Colors.purple,
          onTap: () {},
        ),
      ),
      GlassDivider(),
      Center(
        child: GlassSwitch(
          value: switchValue,
          onChanged: (value) {
            switchValue = value;
            updateState();
          },
        ),
      ),
      Center(
        child: GlassSwitch(
          value: switchValue,
          /*inactiveColor: globalTheme.primaryColor,*/
          activeColor: globalTheme.accentColor,
          onChanged: (value) {
            switchValue = value;
            updateState();
          },
        ),
      ),
      GlassDivider(),
      GlassSegmentedControl(
        direction: .vertical,
        height: 44,
        // cross-axis width in vertical mode
        segmentExtent: 52,
        segments: const [
          GlassSegment(
            icon: Icon(CupertinoIcons.square_grid_2x2),
            semanticLabel: 'Canvas',
          ),
          GlassSegment(
            icon: Icon(CupertinoIcons.circle_grid_hex),
            semanticLabel: 'Flow',
          ),
          GlassSegment(
            icon: Icon(CupertinoIcons.circle_grid_3x3),
            semanticLabel: 'Grid',
          ),
        ],
        selectedIndex: selectedIndex,
        onSegmentSelected: (value) {
          selectedIndex = value;
          updateState();
        },
      ).insets(h: 50, v: 20),
      GlassSegmentedControl(
        direction: .horizontal,
        height: 44,
        // cross-axis width in vertical mode
        segmentExtent: 52,
        segments: const [
          GlassSegment(
            icon: Icon(CupertinoIcons.square_grid_2x2),
            semanticLabel: 'Canvas',
          ),
          GlassSegment(
            icon: Icon(CupertinoIcons.circle_grid_hex),
            semanticLabel: 'Flow',
          ),
          GlassSegment(
            icon: Icon(CupertinoIcons.circle_grid_3x3),
            semanticLabel: 'Grid',
          ),
        ],
        selectedIndex: selectedIndex,
        onSegmentSelected: (value) {
          selectedIndex = value;
          updateState();
        },
      ).insets(h: 50, bottom: 20),
      GlassDivider(),
      GlassPullDownButton(
        menuWidth: 400,
        /*icon: Icon(Icons.home),*/
        items: [
          GlassMenuItem(
            icon: Icon(Icons.cable),
            title: "GlassMenuItem 1",
            onTap: () {},
          ),
          GlassMenuItem(
            icon: Icon(Icons.ac_unit),
            title: "GlassMenuItem 2",
            onTap: () {},
          ),
          GlassMenuItem(
            icon: Icon(Icons.back_hand),
            title: "GlassMenuItem 3",
            onTap: () {},
          ),
        ],
        onSelected: (value) {
          toastInfo(value);
        },
      ).insets(h: 50, v: 20),
      GlassDivider(),
      GlassButtonGroup(
        children: [
          GlassButton(
            label: "GlassButton",
            icon: Icon(Icons.home),
            onTap: () {},
          ),
          GlassButton(
            label: "GlassButton",
            icon: Icon(Icons.home),
            onTap: () {},
          ),
          GlassButton(
            shape: LiquidRoundedRectangle(borderRadius: 20),
            width: 200,
            icon: [
              Icon(Icons.mail),
              "GlassButton".text(),
            ].row(mainAxisAlignment: .center)?.insets(h: 20),
            onTap: () {},
          ),
        ],
      ).insets(h: 50, v: 20),
      GlassDivider(),
      GlassBadge(
        count: 99,
        child: GlassButton(
          label: "GlassButton",
          icon: Icon(Icons.home),
          onTap: () {},
        ),
      ).center(),
      GlassDivider(),
      GlassPageControl(
        count: 3,
        currentPage: selectedIndex,
        onPageChanged: (value) {
          selectedIndex = value;
          updateState();
        },
      ).insets(h: 50, v: 20),
      GlassDivider(),
      GlassTextField().insets(h: 50, v: 20),
      GlassTextArea().insets(h: 50, v: 20),
      GlassPasswordField().insets(h: 50, v: 20),
      GlassSearchBar().insets(h: 50, v: 20),
      GlassFormField(child: GlassTextField()).insets(h: 50, v: 20),
      GlassPicker(
        value: "GlassPicker",
        onTap: () {
          GlassPicker.showSheet(
            context: context,
            items: ["item1", "item2", "item3"],
            itemBuilder: (item) {
              return item.text();
            },
          );
        },
      ).insets(h: 50, v: 20),
      GlassDivider(),
      GlassProgressIndicator.linear().insets(h: 50, v: 20),
      GlassProgressIndicator.circular().center(),
      GlassToast(message: "GlassToast", type: .error).insets(h: 50, v: 20),
      GlassToast(message: "GlassToast", type: .info).insets(h: 50, v: 20),
      GlassToast(message: "GlassToast", type: .warning).insets(h: 50, v: 20),
      GlassToast(message: "GlassToast", type: .success).insets(h: 50, v: 20),
      GlassToast(message: "GlassToast", type: .neutral).insets(h: 50, v: 20),
      GlassDivider(),
      "blur".text(textAlign: .start).insets(h: kX),
      buildSliderWidget(
        context,
        blur,
        minValue: 0,
        maxValue: 100,
        onChanged: (value) {
          blur = value;
          updateState();
        },
      ),
      "thickness".text(textAlign: .start).insets(h: kX),
      buildSliderWidget(
        context,
        thickness,
        minValue: 0,
        maxValue: 100,
        onChanged: (value) {
          thickness = value;
          updateState();
        },
      ),
      "lightIntensity".text(textAlign: .start).insets(h: kX),
      GlassSlider(
        value: lightIntensity,
        min: 0,
        max: 100,
        label: "$lightIntensity",
        onChanged: (value) {
          lightIntensity = value;
          updateState();
        },
      ).insets(h: kX, v: kH),
      "ambientStrength".text(textAlign: .start).insets(h: kX),
      GlassSlider(
        value: ambientStrength,
        min: 0,
        max: 100,
        label: "$ambientStrength",
        onChanged: (value) {
          ambientStrength = value;
          updateState();
        },
      ).insets(h: kX, v: kH),
      "saturation".text(textAlign: .start).insets(h: kX),
      GlassSlider(
        value: saturation,
        min: 0,
        max: 100,
        label: "$saturation",
        onChanged: (value) {
          saturation = value;
          updateState();
        },
      ).insets(h: kX, v: kH),
      Empty.height(160),
    ];
  }
}
