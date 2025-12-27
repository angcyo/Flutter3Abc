import 'package:flutter/material.dart';
import 'package:flutter3_abc/flutter3_abc.dart';
import 'package:flutter3_basics/flutter3_basics.dart';
import 'package:flutter3_shelf/flutter3_shelf.dart';

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
  @override
  void initState() {
    super.initState();
    startWebSocketServer(9999, null, debugLabel: "MCPServerAbc");
  }

  @override
  Widget buildAbc(BuildContext context) {
    return super.buildAbc(context);
  }

  @override
  WidgetList buildBodyList(BuildContext context) {
    return super.buildBodyList(context);
  }
}
