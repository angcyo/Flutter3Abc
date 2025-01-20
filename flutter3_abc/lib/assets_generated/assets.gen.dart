/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsPngGen {
  const $AssetsPngGen();

  /// File path: assets/png/all_in2.webp
  AssetGenImage get allIn2 =>
      const AssetGenImage('assets/png/all_in2.webp', size: Size(600.0, 426.0));

  /// File path: assets/png/face.png
  AssetGenImage get face =>
      const AssetGenImage('assets/png/face.png', size: Size(905.0, 905.0));

  /// File path: assets/png/flutter.png
  AssetGenImage get flutter =>
      const AssetGenImage('assets/png/flutter.png', size: Size(144.0, 144.0));

  /// Directory path: assets/png
  String get path => 'assets/png';

  /// List of all assets
  List<AssetGenImage> get values => [allIn2, face, flutter];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/add_apps.svg
  String get addApps => 'packages/flutter3_abc/assets/svg/add_apps.svg';

  /// File path: assets/svg/add_image.svg
  String get addImage => 'packages/flutter3_abc/assets/svg/add_image.svg';

  /// File path: assets/svg/add_material.svg
  String get addMaterial => 'packages/flutter3_abc/assets/svg/add_material.svg';

  /// File path: assets/svg/add_pen.svg
  String get addPen => 'packages/flutter3_abc/assets/svg/add_pen.svg';

  /// File path: assets/svg/add_shape.svg
  String get addShape => 'packages/flutter3_abc/assets/svg/add_shape.svg';

  /// File path: assets/svg/add_text.svg
  String get addText => 'packages/flutter3_abc/assets/svg/add_text.svg';

  /// File path: assets/svg/icon_layer.svg
  String get iconLayer => 'packages/flutter3_abc/assets/svg/icon_layer.svg';

  /// File path: assets/svg/more_tip.svg
  String get moreTip => 'packages/flutter3_abc/assets/svg/more_tip.svg';

  /// File path: assets/svg/nav_arrow_tip.svg
  String get navArrowTip =>
      'packages/flutter3_abc/assets/svg/nav_arrow_tip.svg';

  /// File path: assets/svg/nav_canvas.svg
  String get navCanvas => 'packages/flutter3_abc/assets/svg/nav_canvas.svg';

  /// File path: assets/svg/nav_menu.svg
  String get navMenu => 'packages/flutter3_abc/assets/svg/nav_menu.svg';

  /// File path: assets/svg/nav_move.svg
  String get navMove => 'packages/flutter3_abc/assets/svg/nav_move.svg';

  /// File path: assets/svg/nav_redo.svg
  String get navRedo => 'packages/flutter3_abc/assets/svg/nav_redo.svg';

  /// File path: assets/svg/nav_selecter.svg
  String get navSelecter => 'packages/flutter3_abc/assets/svg/nav_selecter.svg';

  /// File path: assets/svg/nav_undo.svg
  String get navUndo => 'packages/flutter3_abc/assets/svg/nav_undo.svg';

  /// Directory path: assets/svg
  String get path => 'assets/svg';

  /// List of all assets
  List<String> get values => [
        addApps,
        addImage,
        addMaterial,
        addPen,
        addShape,
        addText,
        iconLayer,
        moreTip,
        navArrowTip,
        navCanvas,
        navMenu,
        navMove,
        navRedo,
        navSelecter,
        navUndo
      ];
}

class $AssetsWebGen {
  const $AssetsWebGen();

  /// File path: assets/web/files_browse.html
  String get filesBrowse =>
      'packages/flutter3_abc/assets/web/files_browse.html';

  /// File path: assets/web/index.html
  String get index => 'packages/flutter3_abc/assets/web/index.html';

  /// File path: assets/web/receive_file.html
  String get receiveFile =>
      'packages/flutter3_abc/assets/web/receive_file.html';

  /// File path: assets/web/receive_succeed.html
  String get receiveSucceed =>
      'packages/flutter3_abc/assets/web/receive_succeed.html';

  /// File path: assets/web/test_web.html
  String get testWeb => 'packages/flutter3_abc/assets/web/test_web.html';

  /// File path: assets/web/udp_client_list.html
  String get udpClientList =>
      'packages/flutter3_abc/assets/web/udp_client_list.html';

  /// File path: assets/web/web_socket.html
  String get webSocket => 'packages/flutter3_abc/assets/web/web_socket.html';

  /// Directory path: assets/web
  String get path => 'assets/web';

  /// List of all assets
  List<String> get values => [
        filesBrowse,
        index,
        receiveFile,
        receiveSucceed,
        testWeb,
        udpClientList,
        webSocket
      ];
}

class Assets {
  Assets._();

  static const String package = 'flutter3_abc';

  static const $AssetsPngGen png = $AssetsPngGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
  static const $AssetsWebGen web = $AssetsWebGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  static const String package = 'flutter3_abc';

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    @Deprecated('Do not specify package for a generated library asset')
    String? package = package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    @Deprecated('Do not specify package for a generated library asset')
    String? package = package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => 'packages/flutter3_abc/$_assetName';
}
