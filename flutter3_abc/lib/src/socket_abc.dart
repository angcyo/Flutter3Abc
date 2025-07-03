import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter3_app/flutter3_app.dart';
import 'package:flutter3_basics/flutter3_basics.dart';

import '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2025/07/03
///
class SocketAbc extends StatefulWidget {
  const SocketAbc({super.key});

  @override
  State<SocketAbc> createState() => _SocketAbcState();
}

class _SocketAbcState extends State<SocketAbc> with BaseAbcStateMixin {
  late final _socketPortFieldConfig = TextFieldConfig(
    text: "_key_socket_port".hiveGet<String>("9090"),
    labelText: "服务端口",
    onChanged: (text) {
      "_key_socket_port".hivePut(text);
    },
  );

  late final _socketIpFieldConfig = TextFieldConfig(
    text: "_key_socket_ip".hiveGet<String>(),
    labelText: "服务端IP",
    onChanged: (text) {
      "_key_socket_ip".hivePut(text);
    },
  );

  late final _messageFieldConfig = TextFieldConfig(
    text: "_key_socket_message".hiveGet<String>("Hello World!"),
    labelText: "发送的内容",
    onChanged: (text) {
      "_key_socket_message".hivePut(text);
    },
  );

  @override
  void initState() {
    super.initState();
    _loadNetworkInterface();
  }

  @override
  Widget buildAbc(BuildContext context) {
    return messageListStream.buildFn(() => super.buildAbc(context));
  }

  @override
  WidgetList buildBodyList(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return [
      //--
      [
        SingleInputWidget(
          config: _socketPortFieldConfig,
          textStyle: globalTheme.textGeneralStyle,
        ).size(width: 260).paddingOnly(top: kX),
        _serverSocketStream.buildDataFn(
          (data) => data == null
              ? GradientButton.normal(() async {
                  _startSocketServer(_socketPortFieldConfig.text.toInt());
                }, child: "启动socket服务".text())
              : GradientButton.normal(() {
                  _stopSocketServer();
                }, child: "停止socket服务".text()),
        ),
        IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () {
            toastInfo(networkInterfaceSignal.value);
          },
        ).hoverTooltip(networkInterfaceSignal.value
            ?.text()
            .paddingOnly(all: kX)
            .constrained(maxWidth: screenWidth / 2)),
      ].flowLayout(
        childGap: kX,
        padding: const EdgeInsets.all(kX),
      )!,
      //--
      [
        SingleInputWidget(
          config: _socketIpFieldConfig,
          textStyle: globalTheme.textGeneralStyle,
        ).paddingOnly(top: kX),
        SingleInputWidget(
          config: _messageFieldConfig,
          textStyle: globalTheme.textGeneralStyle,
        ).paddingOnly(top: kX),
        [
          _socketStream.buildDataFn((data) => data == null
              ? GradientButton.normal(() {
                  _connectSocket();
                }, child: "连接".text())
              : GradientButton.normal(() {
                  _disconnectSocket();
                }, child: "断开".text())),
          _socketStream.buildDataFn(
            (data) => data == null
                ? null
                : GradientButton.normal(() {
                    _sendSocketMessage();
                  }, child: "发送".text()),
          ),
        ].flowLayout(
            childGap: kX, padding: const EdgeInsets.symmetric(vertical: kX))!,
      ].column(crossAxisAlignment: CrossAxisAlignment.start)!.paddingAll(kX),
      for (final msg in messageListStream.value!)
        msg
            .text(style: globalTheme.textGeneralStyle)
            .paddingOnly(left: kX, right: kX, top: kM),
    ];
  }

  //--

  /// 网口信息
  final networkInterfaceSignal = $signal<String>();

  void _loadNetworkInterface() async {
    final list = await NetworkInterface.list(
      includeLinkLocal: true,
      type: InternetAddressType.any,
      includeLoopback: true,
    );
    final ipv4 = InternetAddress.anyIPv4.address; //0.0.0.0
    final ipv6 = InternetAddress.anyIPv6.address; //::
    networkInterfaceSignal.updateValue(
        "网络接口信息(网关)↓\n${list.join("↓\n")}\n\n默认ipv4->$ipv4, 默认ipv6->$ipv6");
  }

  //region 服务端

  late final _serverSocketStream = $live<ServerSocket>();

  /// 消息
  final messageListStream = $live<List<String>>([]);

  /// 启动一个socket服务端
  void _startSocketServer(int serverPort) async {
    final server = await ServerSocket.bind(InternetAddress.anyIPv4, serverPort);
    _serverSocketStream.updateValue(server);
    messageListStream.addSub("服务已启动[$serverPort]");

    server.listen(
      (client) {
        final address = "${client.remoteAddress.address}:${client.remotePort}";
        messageListStream.addSub("客户端连接->$address");
        client.listen(
          (value) {
            //
            messageListStream
                .addSub("收到[$address][${value.length} KB]->${value.utf8Str}");
          },
          onDone: () {
            messageListStream.addSub("[$address]客户端Done.");
          },
          onError: (e) {
            messageListStream.addSub("[$address]客户端错误->$e");
          },
          cancelOnError: true,
        );
      },
      onDone: () {
        messageListStream.addSub("服务已结束!");
      },
      onError: (e) {
        messageListStream.addSub("服务异常->$e");
      },
      cancelOnError: true,
    );
  }

  /// 停止一个socket服务端
  void _stopSocketServer() async {
    final server = _serverSocketStream.value;
    if (server != null) {
      messageListStream.addSub("关闭服务!");
      await server.close();
      _serverSocketStream.updateValue(null);
    }
  }

  //endregion 服务端

  //region 客户端

  final _socketStream = $live<Socket>();

  Future _connectSocket() async {
    final socket = await Socket.connect(
      _socketIpFieldConfig.text,
      _socketPortFieldConfig.text.toInt(),
      timeout: 5.seconds,
    );
    _socketStream.updateValue(socket);

    socket.listen(
      (value) {
        //
        messageListStream.addSub("客户端收到[${value.length} KB]->${value.utf8Str}");
      },
      onDone: () {
        messageListStream.addSub("客户端Done.");
      },
      onError: (e) {
        messageListStream.addSub("客户端错误->$e");
      },
      cancelOnError: true,
    );
  }

  void _disconnectSocket() {
    _socketStream.value?.close();
    _socketStream.value?.destroy();
    _socketStream.updateValue(null);
  }

  void _sendSocketMessage() {
    _socketStream.value?.write(_messageFieldConfig.text);
  }

//endregion 客户端
}
