import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter3_abc/src/slider_captcha_abc.dart';
import 'package:flutter3_abc/src/socket_abc.dart';
import 'package:flutter3_abc/src/udp_service2_abc.dart';
import 'package:flutter3_app/flutter3_app.dart';
import 'package:flutter3_canvas/flutter3_canvas.dart';
import 'package:flutter3_code/flutter3_code.dart';
import 'package:flutter3_excel/flutter3_excel.dart';
import 'package:flutter3_fonts/flutter3_fonts.dart';
import 'package:flutter3_pub_core/flutter3_pub_core.dart';
import 'package:flutter3_scanner/flutter3_scanner.dart';
import 'package:flutter3_shelf/flutter3_shelf.dart' as shelf;
import 'package:flutter3_shelf/flutter3_shelf.dart';
import 'package:flutter3_web/flutter3_web.dart';
import 'package:lp_canvas/lp_canvas.dart';
import 'package:lp_plugin/lp_plugin.dart';
import 'package:multicast_dns/multicast_dns.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:xpath_selector_html_parser/xpath_selector_html_parser.dart';

import 'assets_generated/assets.gen.dart';
import 'src/bean/http_test_bean.dart';

export 'package:flutter3_pub_core/flutter3_pub_core.dart';

export 'assets_generated/assets.gen.dart';

part 'src/animated_abc.dart';

part 'src/app_bar_abc.dart';

part 'src/app_update_abc.dart';

part 'src/base/abc_config.dart';

part 'src/base/abc_debug.dart';

part 'src/base/app_test.dart';

part 'src/base/base_abc.dart';

part 'src/basics_abc.dart';

part 'src/bluetooth_abc.dart';

part 'src/box_shadow_abc.dart';

part 'src/button_abc.dart';

part 'src/canvas_abc.dart';

part 'src/canvas_abc2.dart';

part 'src/code_abc.dart';

part 'src/cover_camera_abc.dart';

part 'src/custom_scroll_abc.dart';

part 'src/dialog_abc.dart';

part 'src/dismissible_abc.dart';

part 'src/draggable_abc.dart';

part 'src/event_abc.dart';

part 'src/excel_abc.dart';

part 'src/expandable_abc.dart';

part 'src/flow_layout_abc.dart';

part 'src/font_abc.dart';

part 'src/gesture_abc.dart';

part 'src/hover_anchor_abc.dart';

part 'src/html_css_abc.dart';

part 'src/http_abc.dart';

part 'src/http_parser_abc.dart';

part 'src/image_abc.dart';

part 'src/layout_abc.dart';

part 'src/loading_widget_abc.dart';

part 'src/markdown_abc.dart';

part 'src/material_widget_abc.dart';

part 'src/matrix_abc.dart';

part 'src/matrix_abc2.dart';

part 'src/matrix_gesture_abc.dart';

part 'src/mdns_abc.dart';

part 'src/menu_abc.dart';

part 'src/model/abc_device_scan_mixin.dart';

part 'src/model/path_model.dart';

part 'src/mouse_region_abc.dart';

part 'src/navigation_bar_abc.dart';

part 'src/nested_scroll_view_abc.dart';

part 'src/nine_grid_abc.dart';

part 'src/notification_abc.dart';

part 'src/notification_listener_abc.dart';

part 'src/nsd_abc.dart';

part 'src/overlay_abc.dart';

part 'src/page_abc.dart';

part 'src/page_lifecycle_abc.dart';

part 'src/page_view_abc.dart';

part 'src/painter_abc.dart';

part 'src/painter_abc2.dart';

part 'src/path_abc.dart';

part 'src/path_provider_abc.dart';

part 'src/plugin_abc.dart';

part 'src/popup_abc.dart';

part 'src/r_item_tile_abc.dart';

part 'src/r_load_more_abc.dart';

part 'src/r_scroll_view_abc.dart';

part 'src/reorderable_list_abc.dart';

part 'src/scroll_behavior_abc.dart';

part 'src/scroll_listener_abc.dart';

part 'src/segmented_abc.dart';

part 'src/server_abc.dart';

part 'src/shelf_abc.dart';

part 'src/silver_grid_abc.dart';

part 'src/silver_list_abc.dart';

part 'src/simulation_abc.dart';

part 'src/slide_abc.dart';

part 'src/sliver_abc.dart';

part 'src/sliver_scroll_coordinate_abc.dart';

part 'src/sliver_tools_abc.dart';

part 'src/stick_app_bar_abc.dart';

part 'src/stick_header_abc.dart';

part 'src/svg_abc.dart';

part 'src/tab_bar_abc.dart';

part 'src/tab_layout_abc.dart';

part 'src/text_field_abc.dart';

part 'src/udp_service_abc.dart';

part 'src/url_launcher_abc.dart';

part 'src/verify_code_abc.dart';

part 'src/web_socket_abc.dart';

part 'src/webview_abc.dart';

part 'src/wheel_abc.dart';

part 'src/widget_abc.dart';

part 'src/temp_test_abc.dart';

///
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2024-12-28
///

/// 标识需要执行的abc
const kGo = '√';

typedef AbcRouteConfig = (String, String?, WidgetBuilder);

/// abc页面路由
final flutter3AbcRoutes = <AbcRouteConfig>[
  ("/basics", 'BasicsAbc', (context) => const BasicsAbc()),
  ("/silverList", 'SilverListAbc', (context) => const SilverListAbc()),
  ("/silverGrid", 'SilverGridAbc', (context) => const SilverGridAbc()),
  ("/sliver", 'SliverAbc', (context) => const SliverAbc()),
  ("/customScroll", 'CustomScrollAbc', (context) => const CustomScrollAbc()),
  ("/RScrollView", 'RScrollViewAbc', (context) => const RScrollViewAbc()),
  ("/RItemTile", 'RItemTileAbc', (context) => const RItemTileAbc()),
  ("/RLoadMore", 'RLoadMoreAbc', (context) => const RLoadMoreAbc()),
  (
    "/notificationListener",
    'NotificationListenerAbc',
    (context) => const NotificationListenerAbc()
  ),
  ("/widget", 'WidgetAbc', (context) => const WidgetAbc()),
  ("/layout", 'LayoutAbc', (context) => const LayoutAbc()),
  ("/tempTest", 'TempTestAbc', (context) => const TempTestAbc()),
  ("/painter", 'PainterAbc', (context) => const PainterAbc()),
  ("/painter2", 'PainterAbc2', (context) => const PainterAbc2()),
  ("/loadingWidget", 'LoadingWidgetAbc', (context) => const LoadingWidgetAbc()),
  ("/animated", 'AnimatedAbc', (context) => const AnimatedAbc()),
  ("/segmented", 'SegmentedAbc', (context) => const SegmentedAbc()),
  ("/menu", 'MenuAbc', (context) => const MenuAbc()),
  ("/button", 'ButtonAbc', (context) => const ButtonAbc()),
  (
    "/materialWidget",
    'MaterialWidgetAbc',
    (context) => const MaterialWidgetAbc()
  ),
  ("/pageLifecycle", 'PageLifecycleAbc', (context) => const PageLifecycleAbc()),
  ("/boxShadow", 'BoxShadowAbc ', (context) => const BoxShadowAbc()),
  ("/page", 'PageAbc', (context) => const PageAbc()),
  ("/htmlCss", 'HtmlCssAbc ', (context) => const HtmlCssAbc()),
  ("/markdown", 'MarkdownAbc ', (context) => const MarkdownAbc()),
  ("/overlay", 'OverlayAbc ', (context) => const OverlayAbc()),
  ("/appBar", 'AppBarAbc ', (context) => const AppBarAbc()),
  (
    "/navigationBar",
    'NavigationBarAbc ',
    (context) => const NavigationBarAbc()
  ),
  ("/tabBar", 'TabBarAbc ', (context) => const TabBarAbc()),
  ("/dialog", 'DialogAbc', (context) => const DialogAbc()),
  ("/popup", 'PopupAbc', (context) => const PopupAbc()),
  ("/textField", 'TextFieldAbc', (context) => const TextFieldAbc()),
  ("/pathProvider", 'PathProviderAbc', (context) => const PathProviderAbc()),
  ("/http", 'HttpAbc ', (context) => const HttpAbc()),
  ("/httpParser", 'HttpParserAbc ', (context) => const HttpParserAbc()),
  ("/server", 'ServerAbc ', (context) => const ServerAbc()),
  ("/svg", 'SvgAbc', (context) => const SvgAbc()),
  ("/AppUpdate", 'AppUpdateAbc', (context) => const AppUpdateAbc()),
  ("/sliverTools", 'SliverToolsAbc', (context) => const SliverToolsAbc()),
  ("/stickHeader", 'StickHeaderAbc ', (context) => const StickHeaderAbc()),
  ("/stickAppBar", 'StickAppBarAbc ', (context) => const StickAppBarAbc()),
  ("/Expandable", 'ExpandableAbc ', (context) => const ExpandableAbc()),
  ("/slide", 'SlideAbc ', (context) => const SlideAbc()),
  ("/dismissible", 'DismissibleAbc ', (context) => const DismissibleAbc()),
  ("/VerifyCode", 'VerifyCodeAbc ', (context) => const VerifyCodeAbc()),
  ("/wheel", 'WheelAbc ', (context) => const WheelAbc()),
  ("/nineGrid", 'NineGridAbc ', (context) => const NineGridAbc()),
  ("/notification", 'NotificationAbc ', (context) => const NotificationAbc()),
  ("/Gesture", 'GestureAbc ', (context) => const GestureAbc()),
  ("/Image", 'ImageAbc ', (context) => const ImageAbc()),
  ("/canvas", 'CanvasAbc', (context) => const CanvasAbc()),
  ("/canvas2", 'CanvasAbc2 ', (context) => const CanvasAbc2()),
  ("/LpCreationPage", 'LpCreationPage', (context) => const LpCreationPage()),
  ("/LpCreationPage2", 'LpCreationPage2', (context) => const LpCreationPage2()),
  ("/matrix", 'MatrixAbc', (context) => const MatrixAbc()),
  ("/matrix2", 'MatrixAbc2', (context) => const MatrixAbc2()),
  ("/MatrixGesture", 'MatrixGestureAbc', (context) => const MatrixGestureAbc()),
  (
    "/scrollBehavior",
    'ScrollBehaviorAbc',
    (context) => const ScrollBehaviorAbc()
  ),
  (
    "/nestedScrollView",
    'NestedScrollViewAbc',
    (context) => const NestedScrollViewAbc()
  ),
  (
    "/sliverScrollCoordinate",
    'SliverScrollCoordinateAbc',
    (context) => const SliverScrollCoordinateAbc()
  ),
  (
    "/scrollListener",
    'ScrollListenerAbc',
    (context) => const ScrollListenerAbc()
  ),
  ("/bluetooth", 'BluetoothAbc', (context) => const BluetoothAbc()),
  ("/nsd", 'NsdAbc', (context) => const NsdAbc()),
  ("/mDns", 'mDnsAbc', (context) => const MdnsAbc()),
  ("/flowLayout", 'FlowLayoutAbc', (context) => const FlowLayoutAbc()),
  ("/plugin", 'PluginAbc', (context) => const PluginAbc()),
  ("/TabLayout", 'TabLayoutAbc', (context) => const TabLayoutAbc()),
  ("/pageView", 'PageViewAbc', (context) => const PageViewAbc()),
  (
    "/ReorderableList",
    'ReorderableListAbc',
    (context) => const ReorderableListAbc()
  ),
  ("/draggable", 'DraggableAbc', (context) => const DraggableAbc()),
  ("/Code", 'CodeAbc', (context) => const CodeAbc()),
  ("/font", 'FontAbc', (context) => const FontAbc()),
  ("/webview", 'WebviewAbc', (context) => const WebviewAbc()),
  ("/Excel", 'ExcelAbc', (context) => const ExcelAbc()),
  ("/UrlLauncher", 'UrlLauncherAbc', (context) => const UrlLauncherAbc()),
  (
    "/FirmwareUpgradePage",
    'FirmwareUpgradePage',
    (context) => const FirmwareUpgradePage()
  ),
  ("/shelf", 'ShelfAbc', (context) => const ShelfAbc()),
  ("/webSocket", 'WebSocketAbc', (context) => const WebSocketAbc()),
  ("/socket", 'SocketAbc', (context) => const SocketAbc()),
  ("/udpService", 'UdpServiceAbc', (context) => const UdpServiceAbc()),
  ("/udpService2", 'UdpServiceAbc2 $kGo', (context) => const UdpService2Abc()),
  (
    "/CoverCameraUpgrade",
    'CoverCameraUpgradeAbc',
    (context) => const CoverCameraAbc()
  ),
  ("/simulation", 'SimulationAbc', (context) => const SimulationAbc()),
  ("/path", 'PathAbc', (context) => const PathAbc()),
  ("/event", 'EventAbc', (context) => const EventAbc()),
  ("/mouseRegion", 'MouseRegionAbc', (context) => const MouseRegionAbc()),
  ("/hoveAnchor", 'HoveAnchorAbc', (context) => const HoveAnchorAbc()),
  (
    "/sliderCaptcha",
    'SliderCaptchaAbc $kGo',
    (context) => const SliderCaptchaAbc()
  ),
];

//--

/// 最后一次跳转的路由路径
String? get lastJumpPath => "_lastJumpPath".hiveGet<String>(null);

set lastJumpPath(String? value) {
  "_lastJumpPath".hivePut(value);
}

//--

/// [loadAssetSvgWidget]
Widget loadAbcSvgWidget(
  String key, {
  Color? tintColor,
  UiColorFilter? colorFilter,
  BoxFit fit = BoxFit.contain,
  double? size,
  double? width,
  double? height,
}) =>
    loadAssetSvgWidget(
      key,
      package: Assets.package,
      tintColor: tintColor,
      colorFilter: colorFilter,
      size: size,
      width: width,
      height: height,
      fit: fit,
    );

/// [loadAssetImageWidget]
Widget? loadAbcImageWidget(
  String? key, {
  BoxFit? fit,
  double? size,
  double? width,
  double? height,
}) =>
    loadAssetImageWidget(
      key,
      package: Assets.package,
      fit: fit,
      size: size,
      width: width,
      height: height,
    );
