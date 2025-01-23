part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/11/27
///
class SimulationAbc extends StatefulWidget {
  /// 指定需要仿真的gcode, 不指定则支持输入
  final String? gcode;

  const SimulationAbc({
    super.key,
    this.gcode,
  });

  @override
  State<SimulationAbc> createState() => _SimulationAbcState();
}

class _SimulationAbcState extends State<SimulationAbc>
    with AbsScrollPage, TileMixin {
  /// gcode内容
  final TextFieldConfig gcodeTextConfig = TextFieldConfig(
    text: gcode,
    // text: gcodeShort,
  );

  /// 更新信号
  final _resultUpdateSignal = createUpdateSignal();

  /// 仿真数据更新信号
  final _resultSimulationUpdateSignal = createUpdateSignal();

  /// 滑块更新信号
  final _sliderUpdateSignal = createUpdateSignal();

  /// 仿真数据更新信号
  final _simulationUpdateSignal = createUpdateSignal();

  /// 画布代理, 用来绘制仿真数据
  final CanvasDelegate canvasDelegate = CanvasDelegate()
    ..canvasStyle.showAxis = true
    ..canvasStyle.showGrid = true
    ..canvasStyle.enableElementControl = false;

  late final PathSimulationPainter pathSimulationPainter =
      PathSimulationPainter()
        ..onSimulationDistanceChangedAction = () {
          _sliderUpdateSignal.updateValue();
          _simulationUpdateSignal.updateValue();
        };

  /// 仿真速度列表
  final simulationSpeedList = [
    "0.1X",
    "0.2X",
    "0.5X",
    "1X",
    "2X",
    "5X",
    "10X",
    "20X",
    "40X",
  ];

  @override
  void initState() {
    //gcodeTextConfig.updateText(gcode);
    super.initState();
    canvasDelegate.canvasElementManager.addElement(pathSimulationPainter);
    if (widget.gcode != null) {
      _parseGCodeSimulation(widget.gcode);
    }
  }

  @override
  Widget buildBody(BuildContext context, WidgetList? children) {
    return GestureHitInterceptScope(
      child: super.buildBody(context, children),
    );
  }

  /// 是否激活输入编辑
  bool get enableEdit => widget.gcode == null;

  @override
  WidgetList? buildScrollBody(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return [
      if (enableEdit)
        SingleInputWidget(
          config: gcodeTextConfig,
          labelText: "gcode内容",
          maxLines: 5,
        ).paddingItem(),
      if (enableEdit)
        [
          FillGradientButton(
            text: "解析GCode",
            onTap: () async {
              final path = gcodeTextConfig.text.toUiPathFromGCode();
              _resultUpdateSignal.updateValue(path);
            },
          ),
          FillGradientButton(
            text: "解析GCode仿真",
            onTap: () {
              _parseGCodeSimulation(gcodeTextConfig.text);
            },
          ),
        ].flowLayout(padding: edgeOnly(all: kX), childGap: kX)!,
      _resultUpdateSignal.buildFn(() {
        final value = _resultUpdateSignal.value;
        if (value is Path) {
          return PathWidget(path: value);
        }
        return empty;
      }),
      _resultSimulationUpdateSignal.buildFn(() {
        final value = _resultSimulationUpdateSignal.value;
        if (value is PathSimulationInfo) {
          return [
            CanvasWidget(canvasDelegate),
            _sliderUpdateSignal.buildFn(() {
              return buildSliderWidget(
                context,
                maxOf(pathSimulationPainter.distance, 0),
                minValue: 0.0,
                maxValue: pathSimulationPainter.simulationInfo?.length ?? 0,
                onChanged: (value) {
                  pathSimulationPainter.distance = value;
                  pathSimulationPainter.pauseSimulation();
                  pathSimulationPainter.refresh();
                  _sliderUpdateSignal.updateValue();
                  _simulationUpdateSignal.updateValue();
                },
              );
            }),
            _simulationUpdateSignal.buildFn(() {
              return [
                lpCanvasSvgWidget(pathSimulationPainter.isStartSimulation
                        ? "pause.svg"
                        : "play.svg")
                    .icon(() {
                      pathSimulationPainter.startSimulation(
                        start: !pathSimulationPainter.isStartSimulation,
                        speed: 1,
                      );
                      _simulationUpdateSignal.updateValue();
                    })
                    .align(Alignment.centerLeft)
                    .expanded(),
                //--
                [
                  "${pathSimulationPainter.simulationSpeedScale.toDigits(digits: 1, ensureInt: true)}X"
                      .text(),
                  [
                    lpCanvasSvgWidget("upward.svg").paddingOnly(all: kM),
                    lpCanvasSvgWidget("downward.svg").paddingOnly(all: kM),
                  ].column(),
                ].row()?.paddingOnly(all: kL).inkWellCircle(() async {
                  final index =
                      await buildContext?.showWidgetDialog(WheelDialog(
                    initValue:
                        "${pathSimulationPainter.simulationSpeedScale.toDigits(digits: 1, ensureInt: true)}X",
                    values: simulationSpeedList,
                  ));
                  if (index is int) {
                    final speed =
                        simulationSpeedList[index].getDoubleOrNull ?? 1;
                    pathSimulationPainter.simulationSpeedScale = speed;
                    _simulationUpdateSignal.updateValue();
                  }
                }),
              ].row()!;
            }),
            LabelSwitchTile(
              label: "移动路径",
              value: pathSimulationPainter.enableMovePath,
              onValueChanged: (value) {
                pathSimulationPainter.enableMovePath = value;
                pathSimulationPainter.refresh();
              },
            ),
          ].column()!;
        }
        return empty;
      }),
    ];
  }

  /// 解析GCode仿真
  void _parseGCodeSimulation(String? gcode) {
    final simulationBuilder = gcode?.toSimulationFromGCode();
    if (simulationBuilder == null) {
      return;
    }
    final pathSimulationInfo = simulationBuilder.build();
    //长度:1074.3467254638672
    //长度:2148.6934509277344
    l.i("路径长度:${pathSimulationInfo.length}");
    pathSimulationPainter.simulationInfo = pathSimulationInfo;
    if (isDebug) {
      //pathSimulationPainter.distance = 1800;
    }
    postFrameCallback((_) {
      canvasDelegate.followRect();
    });
    _resultSimulationUpdateSignal.updateValue(pathSimulationInfo);
  }
}

///
const gcodeShort = '''G21
G90
;svg > g#4aea85cdfef44f688e6008407ceb9e0e > path
M98L3
G0 X126.594 Y95.726 F3000
G1 X126.821 Y95.983 F600
G1 X127.86 Y95.072
G1 X128.632 Y95.948
G1 X128.85 Y95.758
G1 X128.08 Y94.881
G1 X128.881 Y94.175
G1 X129.792 Y95.21
G1 X130.011 Y95.019
G1 X128.875 Y93.726
G1 X126.594 Y95.726
M99
''';

///
const gcode = '''G21
G90
;svg > g#4aea85cdfef44f688e6008407ceb9e0e > path
M98L3
G0 X108.347 Y90.534
G1 X108.859 Y91.077 F600
G1 X107.763 Y92.111
G1 X109.097 Y93.528
G1 X109.297 Y93.341
G1 X109.12 Y93.153
G1 X110.015 Y92.305
G1 X110.952 Y93.295
G1 X111.161 Y93.098
G1 X110.228 Y92.105
G1 X111.128 Y91.256
G1 X111.293 Y91.429
G1 X111.501 Y91.234
G1 X110.181 Y89.833
G1 X109.07 Y90.878
G1 X108.559 Y90.336
G1 X108.347 Y90.534
G0 X108.93 Y92.952 F3000
G1 X108.149 Y92.124 F600
G1 X109.047 Y91.276
G1 X109.828 Y92.104
G1 X108.93 Y92.952
G0 X110.941 Y91.056 F3000
G1 X110.04 Y91.905 F600
G1 X109.259 Y91.078
G1 X110.159 Y90.227
G1 X110.941 Y91.056
;svg > g#4aea85cdfef44f688e6008407ceb9e0e > path
G0 X115.682 Y88.632 F3000
G1 X116.163 Y88.895 F600
G1 X116.24 Y88.95
G1 X116.384 Y88.78
G1 X116.004 Y88.558
G1 X115.824 Y88.48
G1 X115.682 Y88.632
G0 X114.412 Y89.637 F3000
G1 X114.488 Y89.862 F600
G1 X116.666 Y89.131
G1 X116.592 Y88.904
G1 X115.591 Y89.24
G1 X115.354 Y88.541
G1 X116.171 Y88.266
G1 X116.093 Y88.036
G1 X115.278 Y88.309
G1 X115.077 Y87.717
G1 X115.987 Y87.409
G1 X115.908 Y87.175
G1 X113.878 Y87.858
G1 X113.957 Y88.092
G1 X114.827 Y87.8
G1 X115.028 Y88.391
G1 X114.272 Y88.648
G1 X114.349 Y88.879
G1 X115.105 Y88.625
G1 X115.342 Y89.322
G1 X114.412 Y89.637
G0 X113.069 Y87.457 F3000
G1 X114.221 Y90.876 F600
G1 X114.487 Y90.788
G1 X114.422 Y90.588
G1 X117.119 Y89.678
G1 X117.186 Y89.876
G1 X117.464 Y89.784
G1 X116.313 Y86.364
G1 X113.069 Y87.457
G0 X114.339 Y90.343 F3000
G1 X113.418 Y87.611 F600
G1 X116.115 Y86.702
G1 X117.036 Y89.433
G1 X114.339 Y90.343
;svg > g#4aea85cdfef44f688e6008407ceb9e0e > path
G0 X125.537 Y86.799 F3000
G1 X125.185 Y87.619 F600
G1 X124.833 Y88.206
G1 X124.447 Y88.674
G1 X124.028 Y89.038
G1 X123.579 Y89.303
G1 X123.095 Y89.479
G1 X122.701 Y89.552
G1 X122.832 Y89.81
G1 X122.894 Y89.823
G1 X123.419 Y89.692
G1 X123.904 Y89.472
G1 X124.358 Y89.16
G1 X124.784 Y88.745
G1 X125.179 Y88.218
G1 X125.212 Y88.167
G1 X125.188 Y88.863
G1 X125.257 Y89.478
G1 X125.409 Y90.015
G1 X125.637 Y90.479
G1 X125.939 Y90.88
G1 X126.019 Y90.963
G1 X126.25 Y90.825
G1 X126.261 Y90.781
G1 X125.946 Y90.401
G1 X125.706 Y89.959
G1 X125.543 Y89.449
G1 X125.462 Y88.865
G1 X125.474 Y88.206
G1 X125.586 Y87.497
G1 X125.825 Y86.906
G1 X125.773 Y86.884
G1 X125.537 Y86.799
;svg > g#4aea85cdfef44f688e6008407ceb9e0e > path
G0 X112.268 Y97.028 F3000
G1 X113.334 Y95.8 F600
G1 X113.122 Y95.613
G1 X112.715 Y96.077
G1 X110.643 Y94.277
G1 X110.471 Y94.472
G1 X110.362 Y94.815
G1 X110.225 Y95.07
G1 X110.388 Y95.215
G1 X110.745 Y94.808
G1 X112.497 Y96.327
G1 X112.053 Y96.84
G1 X112.268 Y97.028
;svg > g#4aea85cdfef44f688e6008407ceb9e0e > path
G0 X113.752 Y95.404 F3000
G1 X115.291 Y94.321 F600
G1 X115.125 Y94.086
G1 X114.068 Y94.851
G1 X114.017 Y94.893
G1 X114.152 Y94.026
G1 X114.163 Y93.433
G1 X114.087 Y92.997
G1 X113.941 Y92.665
G1 X113.729 Y92.411
G1 X113.485 Y92.257
G1 X113.224 Y92.202
G1 X113.207 Y92.201
G1 X112.933 Y92.25
G1 X112.651 Y92.404
G1 X112.432 Y92.628
G1 X112.287 Y92.918
G1 X112.214 Y93.253
G1 X112.489 Y93.293
G1 X112.561 Y92.964
G1 X112.7 Y92.731
G1 X112.903 Y92.575
G1 X113.126 Y92.513
G1 X113.338 Y92.55
G1 X113.541 Y92.691
G1 X113.716 Y92.939
G1 X113.829 Y93.279
G1 X113.867 Y93.752
G1 X113.806 Y94.422
G1 X113.638 Y95.24
G1 X113.752 Y95.404
;svg > g#4aea85cdfef44f688e6008407ceb9e0e > path
G0 X116.714 Y93.773 F3000
G1 X117.01 Y93.615 F600
G1 X117.224 Y93.4
G1 X117.345 Y93.15
G1 X117.372 Y92.876
G1 X117.301 Y92.59
G1 X117.152 Y92.362
G1 X116.937 Y92.205
G1 X116.665 Y92.128
G1 X116.563 Y92.122
G1 X116.438 Y92.13
G1 X116.487 Y92.065
G1 X116.662 Y91.835
G1 X116.736 Y91.586
G1 X116.713 Y91.319
G1 X116.597 Y91.058
G1 X116.418 Y90.877
G1 X116.182 Y90.776
G1 X116.003 Y90.756
G1 X115.685 Y90.807
G1 X115.385 Y90.948
G1 X115.142 Y91.17
G1 X114.961 Y91.451
G1 X115.206 Y91.594
G1 X115.377 Y91.324
G1 X115.595 Y91.144
G1 X115.844 Y91.057
G1 X116.065 Y91.07
G1 X116.242 Y91.173
G1 X116.366 Y91.361
G1 X116.414 Y91.602
G1 X116.363 Y91.81
G1 X116.208 Y92.002
G1 X115.917 Y92.18
G1 X115.782 Y92.235
G1 X115.871 Y92.485
G1 X116.291 Y92.374
G1 X116.585 Y92.378
G1 X116.793 Y92.465
G1 X116.941 Y92.634
G1 X117.026 Y92.878
G1 X117.012 Y93.108
G1 X116.905 Y93.309
G1 X116.705 Y93.468
G1 X116.418 Y93.564
G1 X116.264 Y93.578
G1 X115.959 Y93.528
G1 X115.759 Y93.446
G1 X115.673 Y93.714
G1 X116.009 Y93.837
G1 X116.345 Y93.857
G1 X116.702 Y93.777
G1 X116.714 Y93.773
;svg > g#4aea85cdfef44f688e6008407ceb9e0e > path
G0 X118.342 Y93.331 F3000
G1 X118.477 Y93.261 F600
G1 X118.546 Y93.121
G1 X118.523 Y92.953
G1 X118.42 Y92.833
G1 X118.293 Y92.797
G1 X118.144 Y92.844
G1 X118.052 Y92.966
G1 X118.046 Y93.134
G1 X118.126 Y93.271
G1 X118.268 Y93.334
G1 X118.342 Y93.331
;svg > g#4aea85cdfef44f688e6008407ceb9e0e > path
G0 X119.696 Y93.188 F3000
G1 X119.983 Y93.136 F600
G1 X120.295 Y92.972
G1 X120.446 Y92.854
G1 X120.468 Y92.912
G1 X120.495 Y93.125
G1 X120.768 Y93.123
G1 X120.751 Y91.62
G1 X120.683 Y91.283
G1 X120.551 Y91.054
G1 X120.359 Y90.908
G1 X120.097 Y90.84
G1 X120.001 Y90.835
G1 X119.649 Y90.885
G1 X119.272 Y91.044
G1 X119.127 Y91.133
G1 X119.26 Y91.373
G1 X119.592 Y91.188
G1 X119.894 Y91.119
G1 X120.129 Y91.147
G1 X120.287 Y91.253
G1 X120.387 Y91.445
G1 X120.42 Y91.712
G1 X119.782 Y91.832
G1 X119.405 Y91.978
G1 X119.185 Y92.149
G1 X119.069 Y92.353
G1 X119.042 Y92.611
G1 X119.103 Y92.858
G1 X119.244 Y93.04
G1 X119.455 Y93.154
G1 X119.696 Y93.188
G0 X119.785 Y92.913 F3000
G1 X119.78 Y92.913 F600
G1 X119.562 Y92.871
G1 X119.427 Y92.76
G1 X119.369 Y92.579
G1 X119.396 Y92.378
G1 X119.516 Y92.22
G1 X119.769 Y92.082
G1 X120.248 Y91.966
G1 X120.42 Y91.942
G1 X120.428 Y92.595
G1 X120.119 Y92.824
G1 X119.864 Y92.908
G1 X119.785 Y92.913
;svg > g#4aea85cdfef44f688e6008407ceb9e0e > path
G0 X123.124 Y94.738 F3000
G1 X123.372 Y94.796 F600
G1 X123.578 Y94.754
G1 X123.761 Y94.611
G1 X123.929 Y94.334
G1 X124.917 Y91.964
G1 X124.605 Y91.832
G1 X123.607 Y94.222
G1 X123.471 Y94.432
G1 X123.337 Y94.498
G1 X123.316 Y94.499
G1 X123.138 Y94.443
G1 X123.013 Y94.351
G1 X122.852 Y94.562
G1 X123.092 Y94.724
G1 X123.124 Y94.738
G0 X124.942 Y91.451 F3000
G1 X125.089 Y91.466 F600
G1 X125.21 Y91.386
G1 X125.266 Y91.238
G1 X125.225 Y91.102
G1 X125.096 Y91.014
G1 X125.022 Y91.002
G1 X124.889 Y91.047
G1 X124.806 Y91.18
G1 X124.812 Y91.327
G1 X124.91 Y91.435
G1 X124.942 Y91.451
;svg > g#4aea85cdfef44f688e6008407ceb9e0e > path
G0 X124.045 Y95.041 F3000
G1 X124.324 Y95.232 F600
G1 X124.975 Y94.268
G1 X125.121 Y94.595
G1 X125.309 Y94.809
G1 X125.56 Y94.944
G1 X125.849 Y94.992
G1 X126.15 Y94.942
G1 X126.447 Y94.791
G1 X126.722 Y94.539
G1 X126.96 Y94.181
G1 X127.091 Y93.834
G1 X127.112 Y93.534
G1 X127.039 Y93.274
G1 X126.873 Y93.051
G1 X126.636 Y92.885
G1 X126.335 Y92.805
G1 X126.148 Y92.795
G1 X125.97 Y92.802
G1 X125.985 Y92.742
G1 X126.078 Y92.562
G1 X125.849 Y92.404
G1 X124.045 Y95.041
G0 X125.469 Y94.574 F3000
G1 X125.286 Y94.388 F600
G1 X125.15 Y94.102
G1 X125.171 Y93.997
G1 X125.821 Y93.047
G1 X126.21 Y93.034
G1 X126.461 Y93.104
G1 X126.655 Y93.259
G1 X126.759 Y93.453
G1 X126.771 Y93.686
G1 X126.673 Y93.981
G1 X126.453 Y94.319
G1 X126.205 Y94.546
G1 X125.952 Y94.66
G1 X125.802 Y94.678
G1 X125.572 Y94.631
G1 X125.469 Y94.574
;svg > g#4aea85cdfef44f688e6008407ceb9e0e > path
G0 X126.594 Y95.726 F3000
G1 X126.821 Y95.983 F600
G1 X127.86 Y95.072
G1 X128.632 Y95.948
G1 X128.85 Y95.758
G1 X128.08 Y94.881
G1 X128.881 Y94.175
G1 X129.792 Y95.21
G1 X130.011 Y95.019
G1 X128.875 Y93.726
G1 X126.594 Y95.726
''';
