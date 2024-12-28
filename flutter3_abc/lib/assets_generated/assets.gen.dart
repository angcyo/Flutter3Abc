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

class $AssetsWebGen {
  const $AssetsWebGen();

  /// File path: assets/web/files_browse.html
  String get filesBrowse => 'assets/web/files_browse.html';

  /// File path: assets/web/index.html
  String get index => 'assets/web/index.html';

  /// File path: assets/web/receive_file.html
  String get receiveFile => 'assets/web/receive_file.html';

  /// File path: assets/web/receive_succeed.html
  String get receiveSucceed => 'assets/web/receive_succeed.html';

  /// File path: assets/web/test_web.html
  String get testWeb => 'assets/web/test_web.html';

  /// File path: assets/web/udp_client_list.html
  String get udpClientList => 'assets/web/udp_client_list.html';

  /// File path: assets/web/web_socket.html
  String get webSocket => 'assets/web/web_socket.html';

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

  static const $AssetsPngGen png = $AssetsPngGen();
  static const $AssetsWebGen web = $AssetsWebGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

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
    String? package,
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
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
