import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter3_app/flutter3_app.dart';

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

  /// 心跳数据内容.
  final heart = "[heart]";

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
  void dispose() {
    _stopSocketServer();
    _disconnectSocket();
    super.dispose();
  }

  @override
  WidgetList buildBodyList(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return [
      //--
      $getLocalInternetAddress().toWidget((ctx, address) {
        return address == null
            ? "无网络".text(style: globalTheme.textGeneralStyle)
            : "当前网络地址:${address.address}"
                .text(style: globalTheme.textGeneralStyle)
                .click(() {
                address.address.copy();
              });
      }).insets(horizontal: kX, top: kX),
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
        clientListStream.buildDataFn(
          (data) => isNil(data)
              ? null
              : GradientButton.normal(() {
                  _sendMessageToAllClient(_messageFieldConfig.text);
                }, child: "发送消息给所有客户端".text()),
        ),
        clientListStream.buildDataFn(
          (data) => isNil(data)
              ? null
              : GradientButton.normal(() {
                  _sendMessageToAllClient(heart);
                }, child: "心跳".text()),
        ),
        IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () {
            l.d(networkInterfaceSignal.value);
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
                  }, child: "发送给服务端".text()),
          ),
          GradientButton.normal(() {
            messageListStream.updateValue([]);
          }, child: "清空消息".text())
        ].flowLayout(
            childGap: kX, padding: const EdgeInsets.symmetric(vertical: kX))!,
      ].column(crossAxisAlignment: CrossAxisAlignment.start)!.paddingAll(kX),
      for (final msg in messageListStream.value!)
        msg
            .text(style: globalTheme.textGeneralStyle)
            .paddingOnly(left: kX, right: kX, top: kM),
      empty.safeBottomArea(),
    ];
  }

  //--

  /// 网口信息
  final networkInterfaceSignal = $signal<String>();

  void _loadNetworkInterface() async {
    final list = await NetworkInterface.list(
      includeLinkLocal: true,
      includeLoopback: true,
      type: InternetAddressType.any,
    );
    //debugger();
    final ipv4 = InternetAddress.anyIPv4.address; //0.0.0.0
    final ipv6 = InternetAddress.anyIPv6.address; //::
    networkInterfaceSignal.updateValue(
        "网络接口信息(网关)↓\n${list.join("↓\n")}\n\n默认ipv4->$ipv4, 默认ipv6->$ipv6");
    l.i(networkInterfaceSignal.value);
    //--
    /*final list2 = await NetworkInterface.list(
      includeLinkLocal: false,
      includeLoopback: false,
      type: InternetAddressType.IPv4,
    );
    l.d("-->\n${list2.join("↓\n")}");*/
  }

  //region 服务端

  late final _serverSocketStream = $live<ServerSocket>();

  /// 消息
  final messageListStream = $live<List<String>>([]);

  /// 服务端连上的所有客户端列表
  final clientListStream = $live<List<Socket>>([]);

  /// 启动一个socket服务端
  void _startSocketServer(int serverPort) async {
    final server = await ServerSocket.bind(InternetAddress.anyIPv4, serverPort);
    _serverSocketStream.updateValue(server);
    messageListStream.addSub("服务已启动[$serverPort]");

    server.listen(
      (client) {
        clientListStream.addSub(client);
        final address = "${client.remoteAddress.address}:${client.remotePort}";
        messageListStream.addSub("客户端连接->$address");
        client.listen(
          (value) {
            //
            messageListStream.addSub(
                "收到[$address][${value.length} B]↓\n->${value.toHex()}\n->${value.utf8Str}");
          },
          onDone: () {
            clientListStream.removeSub(client);
            messageListStream.addSub("[$address]客户端Done.");
          },
          onError: (e) {
            //手机App, 切换到后台后会被系统优化(耗电行为控制), 然后触发异常.
            //[SocketException]SocketException: Connection reset by peer (OS Error: Connection reset by peer, errno = 104), address = 0.0.0.0, port = 9090
            clientListStream.removeSub(client);
            messageListStream.addSub("[$address]客户端错误->$e");
          },
          cancelOnError: true,
        );
      },
      onDone: () {
        clientListStream.updateValue([]);
        messageListStream.addSub("服务已结束!");
      },
      onError: (e) {
        clientListStream.updateValue([]);
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
      _disconnectAllClient();
      await server.close();
      _serverSocketStream.updateValue(null);
    }
  }

  /// 向所有客户端发送消息
  void _sendMessageToAllClient(String message) async {
    final server = _serverSocketStream.value;
    if (server != null) {
      messageListStream.addSub("向所有客户端发送消息: $message");
      for (final socket in clientListStream.value!) {
        try {
          socket.write(message);
        } catch (e) {
          //print(e);
          messageListStream.addSub(
              "向客户端[${socket.remoteAddress.address}:${socket.remotePort}}]发送消息失败: $e");
        }
      }
    }
  }

  /// 断开所有客户端
  void _disconnectAllClient() async {
    final server = _serverSocketStream.value;
    if (server != null) {
      for (final socket in clientListStream.value!) {
        try {
          socket.destroy();
        } catch (e) {
          //print(e);
        }
      }
    }
  }

  //endregion 服务端

  //region 客户端

  /// 客户端socket
  final _socketStream = $live<Socket>();

  Future _connectSocket() async {
    try {
      //连接服务端
      final socket = await Socket.connect(
        _socketIpFieldConfig.text,
        _socketPortFieldConfig.text.toInt(),
        timeout: 5.seconds,
      );
      _socketStream.updateValue(socket);

      socket.listen(
        (value) {
          //
          messageListStream.addSub(
              "客户端收到[${socket.remoteAddress.address}:${socket.remotePort}]的数据[${value.length} B]->${value.utf8Str}");
          if (value.utf8Str == heart) {
            _sendSocketMessage(heart);
          }
        },
        onDone: () {
          messageListStream.addSub("客户端Done.");
        },
        onError: (e) {
          //手机App, 切换到后台后会被系统优化(耗电行为控制), 然后触发异常.
          //[SocketException]SocketException: Connection reset by peer (OS Error: Connection reset by peer, errno = 104), address = 0.0.0.0, port = 9090
          messageListStream.addSub("客户端错误->$e");
          _disconnectSocket();
        },
        cancelOnError: true,
      );
    } catch (e) {
      messageListStream.addSub("连接错误->$e");
    }
  }

  void _disconnectSocket() {
    _socketStream.value?.close();
    _socketStream.value?.destroy();
    _socketStream.updateValue(null);
  }

  /// 客户端发送消息到服务端
  void _sendSocketMessage([String? message]) {
    try {
      _socketStream.value?.write(message ?? _messageFieldConfig.text);
    } catch (e) {
      messageListStream.addSub("发送消息给服务端失败->$e");
    }
  }

//endregion 客户端
}
