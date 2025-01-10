part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2024/02/01
///
class CanvasAbc extends StatefulWidget {
  const CanvasAbc({super.key});

  @override
  State<CanvasAbc> createState() => _CanvasAbcState();
}

class _CanvasAbcState extends State<CanvasAbc>
    with BaseAbcStateMixin, CreationMixin {
  late CanvasListener canvasListener2 = CanvasListener(
      onCanvasViewBoxChangedAction: (canvasViewBox, isInitialize, isCompleted) {
    assert(() {
      const deflate = 30.0;
      canvasViewBox.canvasBounds = canvasViewBox.paintBounds.deflate(deflate);

      //
      /*canvasViewBox
          .updateCanvasContentBounds(const Rect.fromLTWH(100, 100, 1000, 1000));*/
      return true;
    }());
  });

  @override
  void initState() {
    super.initState();
    canvasDelegate.addCanvasListener(canvasListener2);

    loadAssetImage("all_in2.webp", package: Assets.package)
        .getValue((image, error) async {
      //debugger();
      if (image != null) {
        //final base64 = await image.toBase64();
        final element = ImageElementPainter();
        element.initFromImage(image);
        element.paintProperty?.left = -1000;
        element.paintProperty?.top = -1000;
        canvasDelegate.canvasElementManager.beforeElements.add(element);
      }
    });

    loadAssetImage("flutter.png", package: Assets.package)
        .getValue((image, error) async {
      //debugger();
      if (image != null) {
        //final base64 = await image.toBase64();
        final element = ImageElementPainter();
        element.initFromImage(image);
        const sx = 0.5;
        const sy = 0.5;
        element.paintProperty?.left = -element.paintProperty!.width * sx;
        element.paintProperty?.top = -element.paintProperty!.height * sy;
        element.paintProperty?.scaleX = sx;
        element.paintProperty?.scaleY = sy;
        canvasDelegate.canvasElementManager.beforeElements.add(element);
      }
    });
  }

  @override
  void dispose() {
    canvasDelegate.removeCanvasListener(canvasListener2);
    canvasDelegate.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    //initCanvasDelegateElement();
    canvasDelegate.canvasPaintManager.contentManager
        .followCanvasContentTemplate();
  }

  @override
  Widget build(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    backgroundColor = context.isThemeDark ? globalTheme.whiteSubBgColor : null;
    return super.build(context);
  }

  @override
  Widget buildAbc(BuildContext context) {
    //return super.buildAbc(context);
    l.d('build canvas abc');
    return GestureHitInterceptScope(
      child: buildCreationContainer(context, super.buildAbc(context)),
    );
  }

  final resultUpdateSignal = createUpdateSignal();

  @override
  List<Widget> buildBodyList(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);

    const height = 35.0;
    const origin = Offset(0, 0);

    const rect = Rect.fromLTWH(10, 10, 20, 20);
    final scaleMatrix = Matrix4.identity()..scaleBy(sx: 1, sy: 1);
    final flipMatrix = Matrix4.identity()
      ..scaleBy(sx: -1, sy: -1, anchor: rect.center);

    final r1 = scaleMatrix.mapRect(rect);
    final r2 = flipMatrix.mapRect(rect);

    //final bean = ElementBean().toJsonString();

    //debugger();

    /*const rect = Rect.fromLTWH(10, 10, 20, 20);
    final matrix = Matrix4.identity()..rotateBy(180.hd, anchor: rect.center);
    final rect2 = matrix.mapRect(rect);
    debugger();*/

    /*final rotateMatrix1 = Matrix4.identity();
    rotateMatrix1.translateBy(x: 100, y: 100);

    final rotateMatrix2 = Matrix4.identity()..rotateBy(180.hd);
    rotateMatrix2.translateBy(x: 100, y: 100);

    final rotateMatrix3 = Matrix4.identity()..rotateBy(180.hd);
    rotateMatrix3.postTranslateBy(x: 100, y: 100);

    final rotateMatrix4 = Matrix4.identity()..rotateBy(180.hd);
    final translateMatrix = Matrix4.identity()..translateTo(x: 100, y: 100);
    rotateMatrix4.postConcat(translateMatrix);

    final testMatrix = rotateMatrix2 * translateMatrix;
    final testMatrix2 = translateMatrix * rotateMatrix2;

    debugger();*/

    /*final list = [1, 2, 3, 4];
    final list2 = list.clone();
    list.remove(2);
    debugger();*/

    return [
      const DeviceConnectStateInfoTile().stackOf(
          const DeviceRequestStateTile().position(top: 0, left: 0, right: 0)),
      [
        CanvasWidget(canvasDelegate),
        CanvasUndoWidget(canvasDelegate)
            .shadowRadius(
              color: globalTheme.themeWhiteColor,
              decorationColor: globalTheme.themeWhiteColor,
              radius: kCanvasIcoItemRadiusSize,
            )
            .position(right: 10, bottom: 10),
      ].stack()!,
      [
        GradientButton.normal(
          () => canvasDelegate.canvasViewBox.scaleBy(sx: 1.5, sy: 1.5),
          child: "缩放画布".text(),
        ),
        GradientButton.normal(
          () => canvasDelegate.canvasViewBox
              .scaleBy(sx: 1.5, sy: 1.5, pivot: const Offset(100, 100)),
          child: "定点缩放".text(),
        ),
        GradientButton.normal(
          () => context.pushWidget(const AddDevicePage()),
          child: "添加设备".text(),
        ),
        GradientButton.normal(
          () {},
          onContextTap: (context) {
            context.showArrowPopupRoute(
              CommandTestPopup(
                canvasDelegate,
                resultUpdateSignal: resultUpdateSignal,
              ),
            );
          },
          child: "指令...".text(),
        ),
        GradientButton.normal(
          () async {
            final elementList = canvasDelegate.canvasElementManager
                .getAllSelectedElement(exportSingleElement: true)
                ?.filterCast<LpElementMixin>((e) => e is LpElementMixin);
            if (elementList == null || elementList.isEmpty) {
              toastInfo('未选择元素');
            } else if (!$deviceManager.hasDeviceConnected()) {
              toastInfo('未连接设备');
            } else {
              context.showWidgetDialog(SingleEngraveConfigDialog(
                elementList: elementList,
              ));
            }
          },
          child: "雕刻...".text(),
        ),
        GradientButton.normal(
          () {},
          onContextTap: (context) {
            context.showArrowPopupRoute(
              [
                GradientButton.normal(
                  () async {
                    final list = await context.pushWidget(
                      const ImportFileManagerPage(
                        selectFileCount: 1,
                      ),
                    );
                    l.d(list);
                  },
                  child: "导入的文件".text(),
                ),
                GradientButton.normal(
                  () {
                    context.showWidgetDialog(const CanvasEngraveTestDialog());
                  },
                  child: "直接雕刻...".text(),
                ),
                GradientButton.normal(
                  () {
                    context.pushRoute(TestRoute());
                  },
                  child: "test-route".text(),
                ),
              ].flowLayout(childGap: kL)!,
            );
          },
          child: "更多...".text(),
        ),
        GradientButton.normal(
          () {
            //context.push(TestRoute());
            //_test(context);
            buildContext?.showWidgetDialog(
                CanvasFollowTestDialog(canvasDelegate),
                barrierColor: Colors.transparent);
          },
          child: "test".text(),
        ),
        /*GradientButton.normal( () {
            Matrix4 matrix = Matrix4.identity();
            matrix.translateTo(x: 50, y: 50);
            canvasDelegate.canvasElementManager.canvasElementControlManager
                .elementSelectComponent
                .scaleElementWithCenter(matrix);
          },
          child: "移动元素".text(),
        ),
        GradientButton.normal( () {
            canvasDelegate.canvasElementManager.canvasElementControlManager
                .elementSelectComponent
                .rotateBy(15.toRadians);
          },
          child: "旋转元素".text(),
        ),
        GradientButton.normal( () {
            final matrix = Matrix4.identity();
            final anchor = canvasDelegate
                .canvasElementManager
                .canvasElementControlManager
                .elementSelectComponent
                .paintProperty
                ?.anchor;
            const sx = 1.2;
            const sy = 1.2;
            matrix.scaleBy(
              sx: sx,
              sy: sy,
              anchor: anchor,
            );
            canvasDelegate.canvasElementManager.canvasElementControlManager
                .elementSelectComponent
                .scaleElement(sx: sx, sy: sy, anchor: anchor);
          },
          child: "等比缩放元素".text(),
        ),
        GradientButton.normal( () {
            l.d(canvasDelegate.canvasElementManager.canvasElementControlManager
                .elementSelectComponent.paintProperty?.paintScaleRotateBounds);
            final matrix = Matrix4.identity();
            final anchor = canvasDelegate
                .canvasElementManager
                .canvasElementControlManager
                .elementSelectComponent
                .paintProperty
                ?.anchor;
            const sx = 1.2;
            const sy = 1.5;
            matrix.scaleBy(
              sx: sx,
              sy: sy,
              anchor: anchor,
            );
            canvasDelegate.canvasElementManager.canvasElementControlManager
                .elementSelectComponent
                .scaleElement(sx: sx, sy: sy, anchor: anchor);
          },
          child: "不等比缩放元素".text(),
        ),*/
      ].wrap()!,
      [
        textSpanBuilder((builder) {
          /*builder.addText("绘制:");
          builder.addTextStyle("${canvasDelegate.paintCount}",
              color: Colors.red);
          builder.addText(" 刷新请求:");
          builder.addTextStyle("${canvasDelegate.refreshCount}\n",
              color: Colors.red);

          builder.addText("画布原点:");
          builder.addTextStyle(
              "$origin->${canvasDelegate.canvasViewBox.toViewPoint(origin)}\n",
              color: Colors.red);

          builder.addText("可见区域:");
          builder.addTextStyle(
              "${canvasDelegate.canvasViewBox.canvasBounds.log}->${canvasDelegate.canvasViewBox.canvasVisibleBounds.log}\n",
              color: Colors.red);

          final pointerMap = canvasDelegate.canvasEventManager.pointerMap;
          if (pointerMap.isNotEmpty) {
            builder.addText("指针:");
            pointerMap.forEach((key, value) {
              builder.addTextStyle(
                  "$key:${value.localPosition}->${canvasDelegate.canvasViewBox.toScenePoint(value.localPosition)}\n",
                  color: Colors.red);
            });
          }
          final selectBounds = canvasDelegate.canvasElementManager
              .canvasElementControlManager.elementSelectComponent.selectBounds;
          if (selectBounds != null) {
            builder.addText("选择框:");
            builder.addTextStyle("$selectBounds\n", color: Colors.red);
          }
          final selectElement = canvasDelegate.canvasElementManager
              .canvasElementControlManager.elementSelectComponent;
          if (selectElement.isSelectedElement) {
            builder.addText("选择[${selectElement.children?.length}]:");
            builder.addTextStyle(
                "${selectElement.paintProperty?.paintRectBounds}\n",
                color: Colors.red);
          }*/
        }),
      ].wrap()!,
      rebuild(resultUpdateSignal, (context, data) => data?.toString().text()),
      SliverFillRemaining(
        hasScrollBody: false,
        fillOverscroll: true,
        child: CanvasDesignLayoutWidget(
          canvasDelegate: canvasDelegate,
        ).align(Alignment.bottomCenter),
      ),
    ];
  }

  void initCanvasDelegateElement() {
    canvasDelegate.canvasElementManager.clearElements();
    /*final path = "M0 0 L100 0 L100 100 L0 100z"
        .toPath()
        */ /*.transformPath(Matrix4.identity()..translateTo(x: 100, y: 100))*/ /*;*/

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(100, 0)
      ..lineTo(100, 100)
      ..lineTo(0, 100)
      ..lineTo(0, 0)
      ..close()
      ..moveTo(0, 0)
      ..lineTo(1, 1)
      ..close()
      ..moveTo(-50, -50)
      ..lineTo(-100, -100) /*..close()*/;

    path.eachPathMetrics(
        (posIndex, ratio, contourIndex, position, angle, isClose) {
      l.d('$isClose posIndex:$posIndex ratio:$ratio contourIndex:$contourIndex '
          'position:$position angle:${angle.toDegrees}° $angle ');
    }, 50);

    const width = 100.0;
    const height = 100.0;
    const kappa = 0.5522848; // 4 * ((√(2) - 1) / 3)
    const ox = (width / 2.0) * kappa; // control point offset horizontal
    const oy = (height / 2.0) * kappa; // control point offset vertical

    const cx = width / 2.0; // center x
    const cy = height / 2.0; // center y

    const p1 = Offset(0, 0);
    const cc = Offset(width / 2, 0);
    const p2 = Offset(width, 0);
    // l.d(stringBuilder((builder) {
    //   /*builder.write("M${cx - width / 2} ${cy}");
    //   //半圆到p2
    //   builder.write(
    //       "C${cx - width / 2} ${cy - oy} ${cx - ox} ${cy - height / 2} $cx ${cy - height / 2}");*/
    //   builder.write("M${p1.dx} ${p1.dy}");
    //   builder.write("A${width / 2} ${height / 2} 0 0 1 ${p2.dx} ${p2.dy}");
    // }));

    l.d(stringBuilder((builder) {
      builder.write("M${p1.dx} ${p1.dy}");
      final c = calculateControlPoints(p1, p2, cc);
      builder.write(
          "C${c[0].dx} ${c[0].dy} ${c[1].dx} ${c[1].dy} ${p2.dx} ${p2.dy}");
    }));

    /*final path = Path()
      ..moveTo(0, 0)
      ..lineTo(100, 100)
      ..lineTo(100, 0)
      ..close();*/

    /*canvasDelegate.canvasElementManager.addElement(PathElementPainter()
      ..paintProperty = (PaintProperty()
        ..width = 10
        ..height = 10)
      ..path = (Path()..addOval(const Rect.fromLTWH(0, 0, 10, 10))));*/

    final element1 = PathElementPainter()
      ..updatePaintProperty((PaintProperty()
        ..angle = 15.hd
        ..left = -100
        ..top = -100
        ..width = 50
        ..height = 50))
      ..painterPath = (Path()..addRect(const Rect.fromLTWH(0, 0, 50, 50)));
    final element2 = PathElementPainter()
      ..updatePaintProperty(PaintProperty()
        ..angle = 0.hd
        ..left = -50
        ..top = -50
        ..width = 80
        ..height = 50)
      ..painterPath = (Path()..addOval(const Rect.fromLTWH(0, 0, 80, 50)));
    final rectGroupElement = ElementGroupPainter()
      ..resetChildren([element1, element2]);
    canvasDelegate.canvasElementManager.addElement(rectGroupElement);

    final ovalElement = PathElementPainter()
      ..updatePaintProperty(PaintProperty()
        ..left = 50
        ..top = 50
        ..width = 50
        ..height = 50)
      ..painterPath = (Path()..addOval(const Rect.fromLTWH(0, 0, 50, 50)));
    canvasDelegate.canvasElementManager.addElement(ovalElement);

    final rectElement = PathElementPainter()
      ..updatePaintProperty(PaintProperty()
        ..angle = 0.hd
        ..left = 10
        ..top = 10
        ..width = 50
        ..height = 50)
      ..painterPath = (Path()..addRect(const Rect.fromLTWH(0, 0, 50, 50)));
    canvasDelegate.canvasElementManager.addElement(rectElement);

    final flipRectElement = PathElementPainter()
      ..updatePaintProperty(PaintProperty()
        ..angle = 15.hd
        ..left = 0
        ..top = 0
        ..flipX = true
        ..flipY = false
        ..width = 50
        ..height = 50)
      ..painterPath = (Path()..addRect(const Rect.fromLTWH(0, 0, 50, 50)));
    canvasDelegate.canvasElementManager.addElement(flipRectElement);

    //const text = "测";
    const text = "测试文本\nangcyo\nمرحبا بالعالم Hello World";
    const bidiText =
        'چو چپ راست کرد و خم آورد راست، خروش از خم چرخ چاچی بخاست.';
    final textElement = TextElementPainter()
      ..initElementFromText(text)
      ..paintProperty?.let((it) => it
        ..angle = 0.hd
        ..left = 100
        ..top = 100
        ..skewX = 0.hd
        ..flipX = false
        ..flipY = false);
    canvasDelegate.canvasElementManager.addElement(textElement);

    Offset startPoint = const Offset(100, 100);
    Offset endPoint = const Offset(300, 100);
    Offset curvePoint = const Offset(120, 80);

    List<Offset> controlPoints =
        calculateControlPoints(startPoint, endPoint, curvePoint);

    l.d(buildString((builder) {
      builder.addText('M ${startPoint.dx},${startPoint.dy}');
      builder.addText(
          'C ${controlPoints[0].dx},${controlPoints[0].dy} ${controlPoints[1].dx},${controlPoints[1].dy} ${endPoint.dx},${endPoint.dy}');
    }));

    canvasDelegate.canvasElementManager.clearElements();
  }

  List<Offset> calculateControlPoints(
      Offset startPoint, Offset endPoint, Offset curvePoint) {
    double x1 = startPoint.dx + (2.0 / 3.0) * (curvePoint.dx - startPoint.dx);
    double y1 = startPoint.dy + (2.0 / 3.0) * (curvePoint.dy - startPoint.dy);

    double x2 = endPoint.dx + (2.0 / 3.0) * (curvePoint.dx - endPoint.dx);
    double y2 = endPoint.dy + (2.0 / 3.0) * (curvePoint.dy - endPoint.dy);

    return [Offset(x1, y1), Offset(x2, y2)];
  }

  @testPoint
  void _test(BuildContext context) {
    /*canvasDelegate.showRect(enableZoomIn: false, enableZoomOut: false);
            LpConfigHelper.fetchDeviceSettingConfig(
                LpConfigHelper.DEVICE_SETTING_CONFIG_URL,
                LpConfigHelper.DEVICE_SETTING_CONFIG_FILE_NAME);*/

    //context.showDialog(TooLargeWarnDialog())

    /*final image = await captureScreenImage();
            final rotate = Matrix4.identity()
              ..rotateZ(90.hd)
              ..scale(2.0, 2.0);
            final newImage = await image?.transform(rotate);
            final base64 = await newImage?.toBase64();*/
    //debugger();

    /*buildContext?.showWidgetDialog(EngraveRestoreDialog(
              "",
              QueryWorkStateBean(),
            ));*/

    /*final image = await Text("test1234567890" * 30).captureImage();
            final path = await cacheFilePath("test.png");
            await image.saveToFilePath(path);
            buildContext?.showWidgetDialog(SinglePhotoDialog(
              content: image,
            ));
            l.d(path);*/
  }
}

/// 指令测试弹窗
class CommandTestPopup extends StatelessWidget {
  final CanvasDelegate? canvasDelegate;
  final UpdateValueNotifier? resultUpdateSignal;

  const CommandTestPopup(
    this.canvasDelegate, {
    super.key,
    this.resultUpdateSignal,
  });

  @override
  Widget build(BuildContext context) {
    return [
      GradientButton.normal(
        () {
          $deviceManager.sendDeviceRequest(ExitRequest());
        },
        child: "退出".text(),
      ),
      GradientButton.normal(
        () {
          $deviceManager
              .sendDeviceRequest(QueryRequest(QueryState.work))
              .get((value, error) {
            if (value is List) {
              resultUpdateSignal?.updateValue(value.first);
            }
          });
        },
        child: "查询状态".text(),
      ),
      GradientButton.normal(
        () {
          $deviceManager
              .sendDeviceRequest(QueryRequest(QueryState.setting))
              .get((value, error) {
            if (value is List) {
              resultUpdateSignal?.updateValue(value.first);
            }
          });
        },
        child: "查询设置".text(),
      ),
      GradientButton.normal(
        () {
          $deviceManager
              .sendDeviceRequest(
            QueryRequest(QueryState.fileList),
            throwError: true,
          )
              .get((value, error) {
            if (value is List) {
              resultUpdateSignal?.updateValue(value.first);
            } else if (error != null) {
              toastInfo('$error');
            }
          });
        },
        child: "查询文件列表".text(),
      ),
      GradientButton.normal(
        () {
          $deviceManager
              .sendDeviceRequest(
            QueryRequest(QueryState.fileNameList),
            throwError: true,
          )
              .get((value, error) {
            //debugger();
            if (value is List) {
              resultUpdateSignal?.updateValue(value.first);
            } else if (error != null) {
              toastInfo('$error');
            }
          });
        },
        child: "查询文件名列表".text(),
      ),
      GradientButton.normal(
        () {
          final bounds = canvasDelegate
              ?.canvasElementManager.elementSelectComponent?.elementsBounds;
          if (bounds == null) {
            toastInfo('未选择元素,预览100,100');
            final bounds = const Rect.fromLTWH(30, 30, 100, 100).toRectMm();
            $deviceManager.sendDeviceRequest(PreviewRequest.range(bounds));
          } else {
            $deviceManager.sendDeviceRequest(PreviewRequest.range(bounds));
          }
        },
        child: "预览".text(),
      ),
      GradientButton.normal(
        () async {
          final elementList = canvasDelegate?.canvasElementManager
              .getAllSelectedElement(exportSingleElement: true);
          if (elementList == null || elementList.isEmpty) {
            toastInfo('未选择元素');
          } else {
            final pathList = elementList.getAllElementOutputPathList();
            if (pathList.isEmpty) {
              toastInfo('无数据');
            } else {
              final bounds = pathList.getExactBounds();
              final gcode = pathList.toGCodeString();
              final bytes = gcode!.bytes;
              final resultList = await $deviceManager
                  .sendDeviceRequest(DataModeRequest.dataMode(bytes.size()));
              //debugger();
              consoleLog(gcode);
              toastInfo(
                  '进入大数据模式[${bytes.size().toSizeStr()}]${(!resultList.hasError()).toDC()}');
              if (!resultList.hasError()) {
                final index = generateEngraveIndex();
                final request = DataRequest.gcode(
                    bytes, bounds, index, gcode.lines().size());
                final resultList =
                    await $deviceManager.sendDeviceRequest(request);
                toastInfo('数据传输:${(!resultList.hasError()).toDC()}');
                if (!resultList.hasError()) {
                  //flash预览
                  final resultList = await $deviceManager
                      .sendDeviceRequest(PreviewRequest.flash(index));
                  toastInfo('flash预览:${(!resultList.hasError()).toDC()}');
                }
              }
            }
          }
        },
        child: "矢量预览".text(),
      ),
      GradientButton.normal(
        () {
          const size = 10;
          $deviceManager
              .sendDeviceRequest(DataModeRequest.dataMode(size))
              .get((value, error) {
            if (value is List) {
              final bean = value.first;
              if (bean is BatchResult) {
                final response = bean.response;
                if (response is BytesRequestResponseBean) {
                  toastInfo(
                      '进入大数据模式[${size.toSizeStr()}]${response.isSuccess.toDC()}');
                }
              }
            }
          });
        },
        child: "进入大数据模式".text(),
      ),
      GradientButton.normal(
        () async {
          final elementList = canvasDelegate?.canvasElementManager
              .getAllSelectedElement(exportSingleElement: true);
          if (elementList == null || elementList.isEmpty) {
            toastInfo('未选择元素');
          } else {
            final pathList = elementList.getAllElementOutputPathList();
            if (pathList.isEmpty) {
              toastInfo('无数据');
            } else {
              final bounds = pathList.getExactBounds();
              final gcode = pathList.toGCodeString();
              final bytes = gcode!.bytes;
              final resultList = await $deviceManager
                  .sendDeviceRequest(DataModeRequest.dataMode(bytes.size()));
              //debugger();
              consoleLog(gcode);
              toastInfo(
                  '进入大数据模式[${bytes.size().toSizeStr()}]${(!resultList.hasError()).toDC()}');
              if (!resultList.hasError()) {
                final index = generateEngraveIndex();
                final request = DataRequest.gcode(
                    bytes, bounds, index, gcode.lines().size());
                final resultList =
                    await $deviceManager.sendDeviceRequest(request);
                toastInfo('数据传输:${(!resultList.hasError()).toDC()}');
                if (!resultList.hasError()) {
                  //雕刻
                  final resultList = await $deviceManager.sendDeviceRequest(
                    EngraveRequest(EngraveRequestState.startEngraveIndex)
                      ..index = index,
                  );
                  toastInfo('雕刻:${(!resultList.hasError()).toDC()}');
                }
              }
            }
          }
        },
        child: "雕刻".text(),
      ),
      GradientButton.normal(
        () async {
          final elementList =
              canvasDelegate?.canvasElementManager.getAllSelectedElement(
            exportSingleElement: true,
            exportAllElementIfNoSelected: true,
          );
          if (elementList == null || elementList.isEmpty) {
            toastInfo('未选择元素');
          } else {
            final manager = DeviceEngraveManager();
            for (final element in elementList) {
              if (element is LpElementMixin) {
                manager.addEspIndexEngraveTask(
                    ElementEngraveDataProvider(element));
              }
            }
            final result = await manager
                .start(reason: '开始雕刻元素共:[${elementList.size()}]个')
                .get((value, error) {
              if (error != null) {
                toastInfo('$error');
              }
            });
            //debugger();
          }
        },
        child: "雕刻任务".text(),
      ),
    ].flowLayout(childGap: kS)!.material();
  }
}

/// 测试路由
/// ```
/// 直接继承`Route<String>`报错:
/// Failed assertion: line 2997 pos 12: 'route.overlayEntries.isNotEmpty': is not true.
/// ```
class TestRoute<String> extends OverlayRoute<String> {
  @override
  Iterable<OverlayEntry> createOverlayEntries() {
    return <OverlayEntry>[
      OverlayEntry(
        builder: (context) => const TestRoutePage(),
        opaque: false,
      ),
    ];
  }
}

class TestRoutePage extends StatelessWidget {
  const TestRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    //IgnorePointer()
    return [
      GradientButton(
          onTap: () {
            toastInfo("...button");
          },
          child: "child".text()),
      GradientButton(
          onTap: () {
            toastInfo("...button");
          },
          child: "child".text()),
      GradientButton(
          onTap: () {
            toastInfo("...button");
          },
          child: "child".text()),
      "TestRoute"
          .text()
          .backgroundDecoration(fillDecoration(color: Colors.redAccent))
          .ink(() {
        toastInfo("...text");
      }),
    ]
        .scroll(axis: Axis.vertical)!
        .size(height: 80)
        .align(Alignment.bottomCenter)
        .backgroundDecoration(fillDecoration(color: Colors.black26))
        .material()
        .ignoreSelfPointer();
  }
}

/// 直接雕刻对话框
/// 比如, 直接雕刻GCode字符串数据
class CanvasEngraveTestDialog extends StatefulWidget with DialogMixin {
  const CanvasEngraveTestDialog({super.key});

  @override
  State<CanvasEngraveTestDialog> createState() =>
      _CanvasEngraveTestDialogState();
}

class _CanvasEngraveTestDialogState extends State<CanvasEngraveTestDialog> {
  late final TextFieldConfig _lastDataUrlConfig = TextFieldConfig(
    hintText: "在线数据地址",
    text: "_lastDataUrlConfig".hiveGet(),
    textInputAction: TextInputAction.done,
    onChanged: (value) {
      "_lastDataUrlConfig".hivePut(value);
    },
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return widget.buildBottomChildrenDialog(context, [
      const CoreDialogTitle(
        title: "雕刻在线数据",
        invisibleTrailing: true,
      ),
      SingleInputWidget(
        config: _lastDataUrlConfig,
        maxLines: 6,
        border: underlineInputBorder(color: globalTheme.borderColor),
        focusedBorder: underlineInputBorder(color: globalTheme.accentColor),
      ),
      [
        GradientButton.normal(
          () async {
            final text = _lastDataUrlConfig.text;
            if (text.isHttpUrl) {
              //在线地址
              final url = text;
              final data = await url.dioGetString();
              //debugger();
              if (data?.isGCodeContent == true) {
                _engraveGCodeData(context, data!);
              } else if (data?.isSvgContent == true) {
                _handleSvgXmlData(context, data!);
              } else {
                toastInfo("无效的在线数据");
              }
            } else if (text.isGCodeContent) {
              //GCode内容
              _engraveGCodeData(context, text);
            } else if (text.isSvgContent) {
              //svg xml内容
              _handleSvgXmlData(context, text);
            } else {
              toastInfo("不支持的数据");
            }
          },
          child: "雕刻".text(),
        ),
      ].flowLayout(
        padding: const EdgeInsets.all(8),
        childGap: 8,
        selfWidthType: ConstraintsType.matchParent,
      ),
    ]).scaffold();
  }

  /// 处理svg xml数据
  void _handleSvgXmlData(BuildContext context, String text) async {
    final pathList = await text.toUiPathFromXml();
    final gcode = pathList.toGCodeString(autoLaser: true);
    if (isNil(gcode)) {
      toastInfo("无效的数据");
    } else {
      _engraveGCodeData(context, gcode!);
    }
  }

  /// 直接雕刻GCode数据
  void _engraveGCodeData(BuildContext context, String gcode) {
    //debugger();
    final index = generateEngraveIndex();

    //1: 先进入空闲状态
    final exitRequest = ExitRequest();

    //2: 进入大数据模式
    final bytes = gcode.bytes;
    final size = bytes.size();
    final dataModeRequest = DataModeRequest.dataMode(size);

    //3: 发送数据
    final dataRequest = DataRequest.gcode(
      bytes,
      gcode.toUiPathFromGCode()?.getExactBounds() ?? Rect.zero,
      index,
      gcode.lines().length,
    );

    //4: 发送雕刻指令
    final laserOption = LpEngraveHelper.findLaserOptionCollectionByDataMode(
        DeviceDataMode.gcode.name);
    final engraveRequest = EngraveRequest.engraveIndex(
      index: index,
      laserOption: laserOption,
    );

    //5: 查询工作状态
    final queryRequest = QueryRequest(QueryState.work)
      ..onReceiveResponseAction = (deviceId, response, error) {
        if (response.data != null) {
          $deviceManager.updateAnyDeviceWorkState(
              $operateDeviceId, response.data);
          EngraveRestoreDialog.checkDeviceEngraveRestore(
            context,
            $operateDeviceId ?? "",
            workBean: response.data,
          );
        }
      };

    //send
    $deviceManager.sendDeviceRequestList([
      exitRequest,
      dataModeRequest,
      dataRequest,
      engraveRequest,
      queryRequest,
    ], errorToast: true);
  }
}
