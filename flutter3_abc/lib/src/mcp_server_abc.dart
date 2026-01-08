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
    with
        BaseAbcStateMixin,
        HookMixin,
        HookStateMixin,
        LogMessageStateMixin,
        WidgetsBindingObserver,
        MediaQueryDataChangeMixin {
  /// mcp server
  HttpStreamableMcpServer? debugMcpServer;

  @override
  void initState() {
    super.initState();
    //startWebSocketServer(9999, null, debugLabel: "MCPServerAbc");
  }

  @override
  Widget buildAbc(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return [
      buildLogMessageListWidget(context, globalTheme).expanded(),
      super.buildAbc(context).card().animatedContainer(width: $ecwBp()),
    ].row()!;
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
        GradientButton.min(onTap: clearLogData, child: "清屏".text()),
        GradientButton.normal(() {
          if (debugMcpServer != null) {
            debugMcpServer?.stop().get((data, error) {
              debugMcpServer = null;
              updateState();
            });
          } else {
            DebugMcpServer.start().get((data, error) {
              debugMcpServer = data;
              debugMcpServer?.interceptorManager.interceptors.add(
                HttpLogInterceptor(
                  printRequestLogAction: (log) {
                    addLastMessage(log, isReceived: true);
                  },
                  printResponseLogAction: (log) {
                    addLastMessage(log, isReceived: false);
                  },
                ),
              );
              if (data != null) {
                addLastMessage(
                  "[${debugMcpServer?.classHash()}]Mcp服务启动->http://${data.host}:${data.port}${data.path}",
                  isReceived: true,
                );
              }
            });
          }
        }, child: (debugMcpServer != null ? "停止mcp服务" : "启动mcp服务").text()),
      ].flowLayout(childGap: kL)!.insets(all: kL),
    ];
  }
}
