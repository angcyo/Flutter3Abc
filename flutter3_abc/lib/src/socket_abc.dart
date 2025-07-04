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
        clientListStream.buildDataFn(
          (data) => isNil(data)
              ? null
              : GradientButton.normal(() {
                  _sendMessageToAllClient(_messageFieldConfig.text);
                }, child: "发送消息给所有客户端".text()),
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
    ];
  }

  //--

  /// 网口信息
  final networkInterfaceSignal = $signal<String>();

  /// - IPV4环回地址: 127.0.0.1
  /// - IPV6环回地址: ::1
  ///
  /// - lo0（Loopback Interface）: 本地环回地址, 通常被称为 "localhost" 或 "loopback"。
  /// - utun0（VPN Interface）: utun 是用于虚拟隧道（如 VPN）的网络接口。
  /// - en0（Ethernet Interface）: en0 代表系统中的第一个以太网接口，它通常是物理网络接口例如 Ethernet 端口或 Wi-Fi 适配器。
  /// - awdl0: awdl 代表 Apple Wireless Direct Link，用于与其他 Apple 设备（如 iPhone、iPad、Mac）进行点对点的无线通信。
  /// - llw0: llw0 代表 Apple Link-Local Wireless，低延迟无线通信. 用于 Apple 设备之间的无线通信。
  ///
  /// # MacOS
  /// ```
  /// NetworkInterface('lo0', [InternetAddress('127.0.0.1', IPv4), InternetAddress('::1', IPv6), InternetAddress('fe80::1%lo0', IPv6)])↓
  /// NetworkInterface('en0', [InternetAddress('192.168.31.232', IPv4)])↓
  /// NetworkInterface('en8', [InternetAddress('fe80::fcda:1cff:feb4:51b8%en8', IPv6)])↓
  /// NetworkInterface('en12', [InternetAddress('fe80::18c1:53c6:8e6e:8baf%en12', IPv6), InternetAddress('169.254.30.229', IPv4)])↓
  /// NetworkInterface('utun0', [InternetAddress('fe80::d04e:ca70:43a1:d9c0%utun0', IPv6)])↓
  /// NetworkInterface('utun1', [InternetAddress('fe80::5950:6fce:5c3:8129%utun1', IPv6)])↓
  /// NetworkInterface('utun2', [InternetAddress('fe80::4f79:5787:2f4f:d0bb%utun2', IPv6)])↓
  /// NetworkInterface('utun3', [InternetAddress('fe80::ce81:b1c:bd2c:69e%utun3', IPv6)])↓
  /// NetworkInterface('utun5', [InternetAddress('fe80::a08:b58a:4b96:d1ba%utun5', IPv6)])↓
  /// NetworkInterface('utun6', [InternetAddress('fe80::691b:9545:fd59:be96%utun6', IPv6)])
  /// NetworkInterface('awdl0', [InternetAddress('fe80::684a:a1ff:fe36:f613%awdl0', IPv6)])↓
  /// NetworkInterface('llw0', [InternetAddress('fe80::684a:a1ff:fe36:f613%llw0', IPv6)])↓
  /// ```
  void _loadNetworkInterface() async {
    final list = await NetworkInterface.list(
      includeLinkLocal: true,
      type: InternetAddressType.any,
      includeLoopback: true,
    );
    //debugger();
    final ipv4 = InternetAddress.anyIPv4.address; //0.0.0.0
    final ipv6 = InternetAddress.anyIPv6.address; //::
    networkInterfaceSignal.updateValue(
        "网络接口信息(网关)↓\n${list.join("↓\n")}\n\n默认ipv4->$ipv4, 默认ipv6->$ipv6");
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
            messageListStream
                .addSub("收到[$address][${value.length} KB]->${value.utf8Str}");
          },
          onDone: () {
            clientListStream.removeSub(client);
            messageListStream.addSub("[$address]客户端Done.");
          },
          onError: (e) {
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
