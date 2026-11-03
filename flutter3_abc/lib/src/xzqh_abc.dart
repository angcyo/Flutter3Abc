import 'package:flutter/gestures.dart';
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

class _XzqhAbcState extends State<XzqhAbc>
    with BaseAbcStateMixin, WidgetsBindingObserver, MediaQueryDataChangeMixin {
  static final List<XzqhBean> _xzqhList = [];

  /// 点击过的行政区划列表
  static final Set<XzqhBean> _clickedXzqhList = {};

  /// 省
  static final Color _provinceStrokeColor = Color(0xff0072b2);
  static final Color _provinceFillColor = Color(0xffdbeafe);

  /// 自治区
  static final Color _autonomousRegionStrokeColor = Color(0xff009e73);
  static final Color _autonomousRegionFillColor = Color(0xffd1fae5);

  /// 直辖市
  static final Color _municipalityStrokeColor = Color(0xffe69f00);
  static final Color _municipalityFillColor = Color(0xfffef3c7);

  /// 特别行政区
  static final Color _specialAdministrativeRegionStrokeColor = Color(
    0xffcc79a7,
  );
  static final Color _specialAdministrativeRegionFillColor = Color(0xfffce7f3);

  //--

  /// 需要显示的行政区划列表
  /// - 过滤后的行政区划列表
  List<XzqhBean>? _showXzqhList;

  List<XzqhBean> get showXzqhList => _showXzqhList ?? _xzqhList;

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
    final gridCount = $bpGrid();
    return [
      if (_xzqhList.isNotEmpty)
        textSpanBuilder((builder) {
          //**3 个省、5 个自治区、4 个直辖市、2 个特别行政区**，合计 **34 个省级行政区**。
          final provinceList = _xzqhList.where((e) => e.type == "省").toList();
          final provinceCount = provinceList.length; //省
          final autonomousRegionList = _xzqhList
              .where((e) => e.type == "自治区")
              .toList();
          final autonomousRegionCount = autonomousRegionList.length;
          final municipalityList = _xzqhList
              .where((e) => e.type == "直辖市")
              .toList();
          final municipalityCount = municipalityList.length; //直辖市
          final specialAdministrativeRegionList = _xzqhList
              .where((e) => e.type == "特别行政区")
              .toList();
          final specialAdministrativeRegionCount =
              specialAdministrativeRegionList.length;
          final all =
              provinceCount +
              autonomousRegionCount +
              municipalityCount +
              specialAdministrativeRegionCount;
          final allAndSub = all + _xzqhList.fold(0, (a, b) => a + b.childCount);
          final numberStyle = globalTheme.textTitleStyle.copyWith(
            fontWeight: .bold,
          );
          builder
            ..addText(
              "$provinceCount",
              style: numberStyle,
              color: _provinceStrokeColor,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _showXzqhList = provinceList;
                  updateState();
                },
            )
            ..addText(" 个省、") //--
            ..addText(
              " $autonomousRegionCount",
              style: numberStyle,
              color: _autonomousRegionStrokeColor,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _showXzqhList = autonomousRegionList;
                  updateState();
                },
            )
            ..addText(" 个自治区、") //--
            ..addText(
              " $municipalityCount",
              color: _municipalityStrokeColor,
              style: numberStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _showXzqhList = municipalityList;
                  updateState();
                },
            )
            ..addText(" 个直辖市、") //--
            ..addText(
              color: _specialAdministrativeRegionStrokeColor,
              " $specialAdministrativeRegionCount",
              style: numberStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _showXzqhList = specialAdministrativeRegionList;
                  updateState();
                },
            )
            ..addText(" 个特别行政区") //--
            ..addText(" : 合计")
            ..addText(
              " $all",
              style: numberStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _showXzqhList = null;
                  updateState();
                },
            )
            ..addText(" 个省级行政区") //--
            ..addText(" : 约")
            ..addText(" $allAndSub", style: numberStyle)
            ..addText(" 个城市") //--
            ;
        }).insets(all: kH),
      if (showXzqhList.isNotEmpty)
        ...showXzqhList.map(
          (e) => XzqhTile(bean: e)
              .card(
                margin: isDesktopOrWeb ? insets(h: kH, v: kL) : null,
                color: e.fillColor,
              )
              .rGridTile(
                gridCount,
                childAspectRatio:
                    1 /
                    (gridCount >= 6
                        ? 0.25
                        : gridCount >= 3
                        ? 0.3
                        : 0.4),
              ),
        ),
      if (showXzqhList.isEmpty)
        AdapterStateWidget(widgetState: .loading).rFill(),
    ];
  }
}

/// 行政区划列表项
class XzqhTile extends StatefulWidget {
  /// 是否子项样式
  final bool? isInChildStyle;

  final XzqhBean bean;

  const XzqhTile({required this.bean, this.isInChildStyle, super.key});

  @override
  State<XzqhTile> createState() => _XzqhTileState();
}

class _XzqhTileState extends State<XzqhTile> {
  @override
  Widget build(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    final bean = widget.bean;
    final subLength = bean.children?.length ?? 0;
    final childStyle = widget.isInChildStyle ?? bean.shortName == null;
    return ListTile(
      leading: bean.shortName?.text(
        style: globalTheme.textTitleBigStyle.copyWith(color: bean.strokeColor),
      ),
      trailing: childStyle
          ? bean.zipCode?.text(style: globalTheme.textTitleStyle)
          : null,
      title: bean.name?.text(),
      subtitle: bean.type
          ?.connect(subLength > 1 ? " ($subLength)" : null)
          .text(style: globalTheme.textDesStyle),
      dense: !isDesktopOrWeb,
      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
      //最小视觉密度
      contentPadding: insets(h: kH, v: kL),
      tileColor: _XzqhAbcState._clickedXzqhList.contains(bean)
          ? globalTheme.pressColor
          : null,
      onTap: () {
        _XzqhAbcState._clickedXzqhList.add(bean);
        updateState();
        if (childStyle) {
          bean.zipCode?.copy();
        } else if (!isNil(bean.children)) {
          XzqhListScreen(
            title: bean.name,
            beanList: bean.children!,
          ).showScreenWidget(context);
        }
      },
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

  Color? get strokeColor => type == "省"
      ? _XzqhAbcState._provinceStrokeColor
      : type == "自治区"
      ? _XzqhAbcState._autonomousRegionStrokeColor
      : type == "直辖市"
      ? _XzqhAbcState._municipalityStrokeColor
      : type == "特别行政区"
      ? _XzqhAbcState._specialAdministrativeRegionStrokeColor
      : null;

  Color? get fillColor => type == "省"
      ? _XzqhAbcState._provinceFillColor
      : type == "自治区"
      ? _XzqhAbcState._autonomousRegionFillColor
      : type == "直辖市"
      ? _XzqhAbcState._municipalityFillColor
      : type == "特别行政区"
      ? _XzqhAbcState._specialAdministrativeRegionFillColor
      : null;

  int get childCount =>
      isNil(children) ? 1 : children!.fold(0, (a, b) => a + b.childCount);

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

/// 行政区划列表屏幕
class XzqhListScreen extends StatefulWidget with ScreenMixin {
  /// 屏幕标题
  final String? title;

  final List<XzqhBean> beanList;

  @override
  ScreenType get screenType => .bottomDialog;

  @override
  String? getTitle(BuildContext? context) => title;

  const XzqhListScreen({super.key, required this.beanList, this.title});

  @override
  State<XzqhListScreen> createState() => _XzqhListScreenState();
}

class _XzqhListScreenState extends State<XzqhListScreen> with ScreenStateMixin {
  @override
  Widget build(BuildContext context) {
    return (widget as ScreenMixin).buildScaffold(this, [
      ...widget.beanList.map(
        (e) => XzqhTile(bean: e, isInChildStyle: true).card(
          margin: isDesktopOrWeb ? insets(h: kH, v: kL) : null,
        ),
      ),
    ], expandedScroll: true);
  }
}
