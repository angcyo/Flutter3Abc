import 'package:flutter/material.dart';
import 'package:flutter3_app/flutter3_app.dart';

import '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/02
///
/// 行政区划信息页面
class XzqhAbc extends StatefulWidget {
  const XzqhAbc({super.key});

  @override
  State<XzqhAbc> createState() => _XzqhAbcState();
}

class _XzqhAbcState extends State<XzqhAbc> with BaseAbcStateMixin {
  static final List<XzqhBean> _xzqhList = [];

  @override
  void initState() {
    super.initState();
    if (_xzqhList.isEmpty) {
      loadAssetString(Assets.json.xzqh).get((value, error) {
        if (!isNil(value)) {
          final json = (value as String).fromJson();
          final children = json["data"]["children"];
          _xzqhList.resetAll(
            (children as Iterable).map((e) => XzqhBean.fromJson(e)),
          );
          updateState();
        }
      });
    }
  }

  @override
  WidgetList buildBodyList(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return [
      if (_xzqhList.isNotEmpty)
        textSpanBuilder((builder) {
          //**3 个省、5 个自治区、4 个直辖市、2 个特别行政区**，合计 **34 个省级行政区**。
          final provinceCount = _xzqhList
              .where((e) => e.type == "省")
              .length; //省
          final autonomousRegionCount = _xzqhList
              .where((e) => e.type == "自治区")
              .length; //自治区
          final municipalityCount = _xzqhList
              .where((e) => e.type == "直辖市")
              .length; //直辖市
          final specialAdministrativeRegionCount = _xzqhList
              .where((e) => e.type == "特别行政区")
              .length; //特别行政区
          final all =
              provinceCount +
              autonomousRegionCount +
              municipalityCount +
              specialAdministrativeRegionCount;
          final numberStyle = globalTheme.textTitleStyle.copyWith(
            fontWeight: .bold,
          );
          builder
            ..addText("$provinceCount", style: numberStyle)
            ..addText(" 个省、") //--
            ..addText(" $autonomousRegionCount", style: numberStyle)
            ..addText(" 个自治区、") //--
            ..addText(" $municipalityCount", style: numberStyle)
            ..addText(" 个直辖市、") //--
            ..addText(" $specialAdministrativeRegionCount", style: numberStyle)
            ..addText(" 个特别行政区") //--
            ..addText(" : 合计")
            ..addText(" $all", style: numberStyle)
            ..addText(" 个省级行政区") //--
            ;
        }).insets(all: kH),
      if (_xzqhList.isNotEmpty)
        ..._xzqhList.map(
          (e) => XzqhTile(
            bean: e,
          ).card().rGridTile($bpGrid(), childAspectRatio: 1 / 0.3),
        ),
      if (_xzqhList.isEmpty) AdapterStateWidget(widgetState: .loading).rFill(),
    ];
  }
}

/// 行政区划列表项
class XzqhTile extends StatefulWidget {
  final XzqhBean bean;

  const XzqhTile({required this.bean, super.key});

  @override
  State<XzqhTile> createState() => _XzqhTileState();
}

class _XzqhTileState extends State<XzqhTile> {
  @override
  Widget build(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    final bean = widget.bean;
    final subLength = bean.children?.length ?? 0;
    return ListTile(
      leading: bean.shortName?.text(style: globalTheme.textTitleBigStyle),
      title: bean.name?.text(),
      subtitle: bean.type
          ?.connect(subLength > 1 ? " ($subLength)" : null)
          .text(style: globalTheme.textDesStyle),
    );
  }
}

/// 行政区划数据结构
/// ```
/// "code": "110000000000",
/// "name": "北京市",
/// "shortName": "京",
/// "zipCode": "100000",
/// "level": 1,
/// "type": "直辖市",
/// "children": []
/// ```
class XzqhBean {
  String? code;
  String? name;
  String? shortName;
  String? zipCode;
  int? level;
  String? type;
  List<XzqhBean>? children;

  XzqhBean({
    this.code,
    this.name,
    this.shortName,
    this.zipCode,
    this.level,
    this.type,
    this.children,
  });

  /// fromJson
  factory XzqhBean.fromJson(Map<String, dynamic> json) => XzqhBean(
    code: json["code"],
    name: json["name"],
    shortName: json["shortName"],
    zipCode: json["zipCode"],
    level: json["level"],
    type: json["type"],
    children: json["children"] == null
        ? []
        : List<XzqhBean>.from(
            json["children"].map((x) => XzqhBean.fromJson(x)),
          ),
  );
}
