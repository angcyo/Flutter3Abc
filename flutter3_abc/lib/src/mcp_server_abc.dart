import 'package:flutter/material.dart';
import 'package:flutter3_abc/flutter3_abc.dart';
import 'package:flutter3_app/flutter3_app.dart';
import 'package:flutter3_mcp/flutter3_mcp.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2025/12/27
///
class MCPServerAbc extends StatefulWidget {
  const MCPServerAbc({super.key});

  @override
  State<MCPServerAbc> createState() => _MCPServerAbcState();
}

class _MCPServerAbcState extends State<MCPServerAbc>
    with BaseAbcStateMixin, HookMixin, HookStateMixin {
  /// mcp server
  StreamableMcpServer? debugMcpServer;

  @override
  void initState() {
    super.initState();
    //startWebSocketServer(9999, null, debugLabel: "MCPServerAbc");
  }

  @override
  Widget buildAbc(BuildContext context) {
    return super.buildAbc(context);
  }

  @override
  void dispose() {
    debugMcpServer?.stop();
    debugMcpServer = null;
    super.dispose();
  }

  @override
  WidgetList buildBodyList(BuildContext context) {
    return [
      [
        GradientButton.normal(() {
          if (debugMcpServer != null) {
            debugMcpServer?.stop().get((data, error) {
              debugMcpServer = null;
              updateState();
            });
          } else {
            DebugMcpServer.start().get((data, error) {
              debugMcpServer = data;
              updateState();
            });
          }
        }, child: (debugMcpServer != null ? "停止mcp服务" : "启动mcp服务").text()),
      ].flowLayout(childGap: kL)!.insets(all: kL),
    ];
  }
}
