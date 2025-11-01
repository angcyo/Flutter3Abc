import 'package:flutter/material.dart';
import 'package:flutter3_app/flutter3_app.dart';
import 'package:flutter3_webview/flutter3_webview.dart';

import '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2025/08/29
///
class Three3DAbc extends StatefulWidget {
  const Three3DAbc({super.key});

  @override
  State<Three3DAbc> createState() => _Three3DAbcState();
}

class _Three3DAbcState extends State<Three3DAbc> with BaseAbcStateMixin {
  final modelUrlMap = {
    "business_man.glb":
        "https://raw.githubusercontent.com/FlutterStudioIst/3d_res/refs/heads/main/business_man.glb",
    "coin.glb":
        "https://raw.githubusercontent.com/FlutterStudioIst/3d_res/refs/heads/main/coin.glb",
    "dash.glb":
        "https://raw.githubusercontent.com/FlutterStudioIst/3d_res/refs/heads/main/dash.glb",
    "flutter_dash.obj":
        "https://raw.githubusercontent.com/FlutterStudioIst/3d_res/refs/heads/main/flutter_dash.obj",
    "flutter_logo.glb":
        "https://raw.githubusercontent.com/FlutterStudioIst/3d_res/refs/heads/main/flutter_logo.glb",
    "Football.obj":
        "https://raw.githubusercontent.com/FlutterStudioIst/3d_res/refs/heads/main/Football.obj",
    "ground.glb":
        "https://raw.githubusercontent.com/FlutterStudioIst/3d_res/refs/heads/main/ground.glb",
    "sheen_chair.glb":
        "https://raw.githubusercontent.com/FlutterStudioIst/3d_res/refs/heads/main/sheen_chair.glb",
    "sky_sphere.glb":
        "https://raw.githubusercontent.com/FlutterStudioIst/3d_res/refs/heads/main/sky_sphere.glb",
    "Toothy_Baby_Croc.stl":
        "https://raw.githubusercontent.com/FlutterStudioIst/3d_res/refs/heads/main/Toothy_Baby_Croc.stl",
    "pentagram.gcode":
        "https://raw.githubusercontent.com/FlutterStudioIst/3d_res/refs/heads/main/pentagram.gcode",
  };

  /// 3D模型地址
  late final _modelUrlFieldConfig = TextFieldConfig(
    text: "_key_3d_model_url".hiveGet<String>(
        "https://raw.githubusercontent.com/FlutterStudioIst/3d_res/refs/heads/main/flutter_logo.glb"),
    labelText: "模型地址",
    onChanged: (text) {
      "_key_3d_model_url".hivePut(text);
    },
  );

  @override
  WidgetList buildBodyList(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return [
      SingleInputWidget(
        config: _modelUrlFieldConfig,
        textStyle: globalTheme.textGeneralStyle,
      ).paddingOnly(top: kX, horizontal: kX),
      [
        for (final entry in modelUrlMap.entries)
          GradientButton(
            child: entry.key.text(),
            onTap: () {
              _modelUrlFieldConfig.text = entry.value;
            },
          )
      ].flowLayout(
        padding: const EdgeInsets.all(kH),
        childGap: kH,
      )!,
      [
        GradientButton(
          child: "使用[three_js]加载".text(),
          onTap: () {
            buildContext?.pushWidget(
                FlutterThreeJsPage(src: _modelUrlFieldConfig.text));
          },
        ),
        GradientButton(
          child: "使用[3d_controller]加载".text(),
          onTap: () {
            buildContext
                ?.pushWidget(Flutter3dPage(src: _modelUrlFieldConfig.text));
          },
        ),
      ].flowLayout(
        padding: const EdgeInsets.all(kH),
        childGap: kH,
      )!,
    ];
  }
}
