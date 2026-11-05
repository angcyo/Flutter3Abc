import 'package:flutter/material.dart';
import 'package:flutter3_basics/flutter3_basics.dart';
import 'package:flutter3_canvas/flutter3_canvas.dart';

import '../../flutter3_abc.dart';
import '../xzqh_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/04
///
/// 中国地图绘制界面
/// - Geo数据来源: https://geojson.cn/data
class ChinaMapScreen extends StatefulWidget {
  const ChinaMapScreen({super.key});

  @override
  State<ChinaMapScreen> createState() => _ChinaMapScreenState();
}

class _ChinaMapScreenState extends State<ChinaMapScreen>
    with BaseAbcStateMixin {
  static final List<Map<String, dynamic>> _chinaFeaturesList = [];

  ///
  final loadingPainter = LoadingElementPainter();

  late final canvasListener = CanvasListener(
    onCanvasViewBoxChangedAction:
        (canvasViewBox, fromInitialize, isFirstInitialize, isCompleted) {
          if (isFirstInitialize) {
            canvasViewBox.scaleTo(
              scale: 1,
              anim: false,
              completedAction: (value) {
                canvasViewBox.canvasDelegate.followPainter(
                  elementPainter: loadingPainter,
                );
              },
            );
          }
        },
  );

  /// 画布代理
  late final canvasDelegate = CanvasDelegate()
    ..addCanvasListener(canvasListener);

  @override
  void initState() {
    super.initState();
    canvasDelegate.canvasStyle
      ..axisUnit = .dp
      ..enableElementExactSelect = true
      ..enableHoverTopDraw = isDesktopOrWeb
      ..enablePureMode();
    canvasDelegate.canvasElementManager.addElement(loadingPainter);
    loadData();
  }

  void loadData({bool? reload}) {
    postDelayCallback(() {
      if (_chinaFeaturesList.isEmpty) {
        loadAssetString(Assets.json.china).get((value, error) {
          if (!isNil(value)) {
            final json = (value as String).fromJson();
            final features = json["features"];
            _chinaFeaturesList.resetAll(
              (features as Iterable).map((e) => e as Map<String, dynamic>),
            );
            //updateState();
            loadFeatures(_chinaFeaturesList, reload: reload);
          }
        });
      } else {
        loadFeatures(_chinaFeaturesList, reload: reload);
      }
    }, 1.seconds);
  }

  /// 加载地图数据
  Future loadFeatures(
    List<Map<String, dynamic>> features, {
    bool? reload,
  }) async {
    canvasDelegate.canvasElementManager.removeAllElement();
    await for (final feature in features.stream) {
      canvasDelegate.canvasElementManager.addElement(
        FeatureElementPainter(feature),
      );
    }
    if (reload == true) {
      //no op
    } else {
      canvasDelegate.followRect();
    }
  }

  @override
  Widget buildAbc(BuildContext context) {
    return CanvasWidget(canvasDelegate);
  }

  @override
  void reassemble() {
    super.reassemble();
    _chinaFeaturesList.clear();
    loadData(reload: true);
  }
}

/// 经纬度点
class LngLat {
  /// 经度
  final double lng;

  /// 纬度
  final double lat;

  LngLat(this.lng, this.lat);
}

/// 投影转换器：简单矩形平铺（适合静态地图预览，WGS84）
/// 如果你用 flutter_map / amap_flutter_map，替换成SDK自带的投影方法
class GeoProjection {
  final double minLng;
  final double maxLng;
  final double minLat;
  final double maxLat;
  final Size canvasSize;

  GeoProjection({
    this.minLng = 115.4,
    this.maxLng = 117.6,
    this.minLat = 39.4,
    this.maxLat = 41.1,
    this.canvasSize = const Size(100, 100),
  });

  Offset project(LngLat ll) {
    final x = (ll.lng - minLng) / (maxLng - minLng) * canvasSize.width;
    // 注意：Canvas Y轴向下，纬度越大越靠上，需要反转Y
    final y = (maxLat - ll.lat) / (maxLat - minLat) * canvasSize.height;
    return Offset(x, y);
  }
}

/// 核心：解析 geometry Map，返回 Flutter Path
Path geometryToPath(Map<String, dynamic> geometry, GeoProjection proj) {
  final path = Path();
  final type = geometry['type'] as String;
  final coords = geometry['coordinates'] as List;

  if (type == 'Polygon') {
    _parsePolygonRings(coords, path, proj);
  } else if (type == 'MultiPolygon') {
    for (final polyRings in coords) {
      _parsePolygonRings(polyRings, path, proj);
    }
  }
  // 填充规则：EvenOdd 才能正确挖洞
  path.fillType = PathFillType.evenOdd;
  return path;
}

/// 解析一个Polygon的环数组：[外环, 内环1, 内环2...]
void _parsePolygonRings(List rings, Path path, GeoProjection proj) {
  for (int ringIdx = 0; ringIdx < rings.length; ringIdx++) {
    final ringPoints = rings[ringIdx] as List;
    final offsets = <Offset>[];
    for (final p in ringPoints) {
      final lng = (p[0] as num).toDouble();
      final lat = (p[1] as num).toDouble();
      offsets.add(proj.project(LngLat(lng, lat)));
    }
    if (offsets.isEmpty) continue;
    if (ringIdx == 0) {
      // 外环
      path.moveTo(offsets.first.dx, offsets.first.dy);
      for (int i = 1; i < offsets.length; i++) {
        path.lineTo(offsets[i].dx, offsets[i].dy);
      }
      path.close();
    } else {
      // 内环（挖洞）evenOdd模式自动识别
      path.moveTo(offsets.first.dx, offsets.first.dy);
      for (int i = 1; i < offsets.length; i++) {
        path.lineTo(offsets[i].dx, offsets[i].dy);
      }
      path.close();
    }
  }
}

/// 地图要素绘制器
class FeatureElementPainter extends PathElementPainter {
  /// 地图要素数据
  Map<String, dynamic> feature;

  /// 名称
  /// - 河北
  String? name;

  /// 完整名称
  /// - 河北省
  String? fullName;

  /// 中心点
  Offset? center;

  /// 省会名称 / 首府
  String? capital;

  //String? get capital => capitalMap[fullName];

  Color? get fillColor => fullName?.endsWith("省") == true
      ? XzqhAbc.provinceFillColor
      : fullName?.endsWith("市") == true
      ? XzqhAbc.municipalityFillColor
      : fullName?.endsWith("自治区") == true
      ? XzqhAbc.autonomousRegionFillColor
      : fullName?.endsWith("行政区") == true
      ? XzqhAbc.specialAdministrativeRegionFillColor
      : null;

  Color? get strokeColor => fullName?.endsWith("省") == true
      ? XzqhAbc.provinceStrokeColor
      : fullName?.endsWith("市") == true
      ? XzqhAbc.municipalityStrokeColor
      : fullName?.endsWith("自治区") == true
      ? XzqhAbc.autonomousRegionStrokeColor
      : fullName?.endsWith("行政区") == true
      ? XzqhAbc.specialAdministrativeRegionStrokeColor
      : null;

  FeatureElementPainter(this.feature) {
    final properties = feature["properties"];
    name = properties?["name"];
    fullName = properties?["fullname"];
    capital = feature["properties"]?["capital"];
    final proj = GeoProjection();
    initFromPath(geometryToPath(feature["geometry"], proj));

    final centerCoords = properties?["center"] as List?;
    final centerOffsetCoords = properties?["centerOffset"] as List?;
    if (centerCoords != null) {
      final ll = LngLat(
        (centerCoords[0] as num).toDouble() +
            (centerOffsetCoords?.getOrNull(0).toDouble() ?? 0),
        (centerCoords[1] as num).toDouble() +
            (centerOffsetCoords?.getOrNull(1)?.toDouble() ?? 0),
      );
      center = proj.project(ll);
    }

    //--
    if (fillColor != null) {
      paintColor = fillColor!;
      paintStyle = .fill;
    }
  }

  @override
  void onPaintingSelf(Canvas canvas, PaintMeta paintMeta) {
    super.onPaintingSelf(canvas, paintMeta);
    if (paint.style == .fill) {
      paint
        ..style = .stroke
        ..color = Colors.black
        ..strokeWidth = paint.strokeWidth / paintMeta.canvasScale;
      super.onPaintingSelf(canvas, paintMeta);
    }
    canvas.drawText(
      (fullName ?? name)?.connect(capital?.wph.connect(null, "\n")),
      bold: isDesktopOrWeb,
      textAlign: .center,
      /*offset: elementsBounds!.center,*/
      alignment: .center,
      textColor: strokeColor ?? paint.color,
      bounds: center == null
          ? elementsBounds
          : Rect.fromCenter(
              center: center!,
              width: elementsBounds!.width,
              height: elementsBounds!.height,
            ),
      fontSize: (isDesktopOrWeb ? kDefaultFontSize : 8) / paintMeta.canvasScale,
    );
  }
}
