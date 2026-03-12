import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter3_app/flutter3_app.dart';
import 'package:flutter3_protobuf/flutter3_protobuf.dart';

import '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/03/12
///
///
class ProtobufAbc extends StatefulWidget {
  const ProtobufAbc({super.key});

  @override
  State<ProtobufAbc> createState() => _ProtobufAbcState();
}

class _ProtobufAbcState extends State<ProtobufAbc> with BaseAbcStateMixin {
  //--

  Server? _server;
  (TestProtobuf2?, Object?)? _result;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _server?.shutdown();
    super.dispose();
  }

  @override
  WidgetList buildBodyList(BuildContext context) {
    return [
      "${Platform.operatingSystem} / "
              "${Platform.operatingSystemVersion} / "
              "${Platform.localHostname} / "
              "${Platform.localeName} / "
              "${Platform.environment.containsKey('FLUTTER_TEST')}"
          .text(),
      [
        GradientButton.min(
          onTap: () async {
            if (_server == null) {
              _server = await startTestRpcServer();
            } else {
              await _server?.shutdown();
              _server = null;
            }
            updateState();
          },
          child: (_server == null ? "启动服务端" : "停止服务端").text(),
        ),
        GradientButton.min(
          onTap: () async {
            _result = await testRpcClient();
            updateState();
          },
          child: "发送客户端请求".text(),
        ),
      ].flowLayout(gap: kM)!.insets(all: kL),
      if (_result != null)
        "${nowTimeString()}\n${_result?.$1 ?? ""}\n${_result?.$2 ?? ""}"
            .text()
            .insets(all: kH),
    ];
  }
}
