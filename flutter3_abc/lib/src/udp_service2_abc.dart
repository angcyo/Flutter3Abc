import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter3_app/flutter3_app.dart';
import 'package:flutter3_shelf/flutter3_shelf.dart';

import '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2025/07/02
///
class UdpService2Abc extends StatefulWidget {
  const UdpService2Abc({super.key});

  @override
  State<UdpService2Abc> createState() => _UdpService2AbcState();
}

class _UdpService2AbcState extends State<UdpService2Abc>
    with BaseAbcStateMixin, HookMixin, HookStateMixin {
  LocalUdpServer udpServer = LocalUdpServer();
  LocalUdpClient udpClient = LocalUdpClient();

  /// 消息列表更新信号
  final listSignal = $signal();

  /// 选中的设备id
  String? _selectedRemoteDeviceId;

  @override
  void initState() {
    _loadNetworkInterface();
    hookAny(udpServer.remoteNewMessageStreamOnce.listen((data) {
      if (_selectedRemoteDeviceId != null &&
          data?.deviceId == _selectedRemoteDeviceId) {
        listSignal.updateValue();
        postFrame(() {
          //滚动到底部
          scrollController.scrollToBottom();
        });
      }
    }));
    super.initState();
  }

  @override
  void dispose() {
    udpServer.stop();
    udpClient.stop();
    super.dispose();
  }

  @override
  Widget buildAbc(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return [
      [
        udpServer.localInfoStream.buildDataFn((data) {
          return data == null
              ? GradientButton.normal(() async {
                  udpServer.start();
                  updateState();
                }, child: "启动服务端".text())
              : GradientButton.normal(() {
                  udpServer.stop();
                }, child: "停止服务端".text());
        }),
        udpClient.localInfoStream.buildDataFn((data) {
          return data == null
              ? GradientButton.normal(() async {
                  udpClient.start();
                  updateState();
                }, child: "启动客户端".text())
              : GradientButton.normal(() {
                  udpClient.stop();
                }, child: "停止客户端".text());
        }),
        GradientButton.normal(() {
          udpClient.sendRemoteMessage(UdpMessageBean.text(nowTimeString()));
        }, child: "上报消息".text()),
        /*GradientButton.normal(() {
          udpService.sendBroadcast(nowTimeString().bytes);
        }, child: "发送广播".text()),*/

        /*GradientButton.normal(() {
          final clientInfo =
          defaultUdpService.getServerClientInfo(_selectedDeviceId);
          defaultUdpService.testTcpSendToClient(
            clientInfo?.remoteAddress,
            clientInfo?.remotePort,
            nowTimeString().bytes,
          );
        }, child: "test-tcp-to-client".text()),
        GradientButton.normal(() {
          final clientInfo =
          defaultUdpService.getServerClientInfo(_selectedDeviceId);
          defaultUdpService.testUdpSendToClient(
            clientInfo?.remoteAddress,
            clientInfo?.remotePort,
            nowTimeString().bytes,
          );
        }, child: "test-udp-to-client".text()),*/
        /*GradientButton.normal(() async {
          final bytes = await receiveUdpData(testPort, timeout: 10.seconds);
          final str = bytes?.utf8Str;
          toastInfo(str);
          //debugger();
        }, child: "test-udp-receive".text()),
        GradientButton.normal(() async {
          sendUdpBroadcast(testPort,
              text: "[${nowTimeString()}]send broadcast.");
        }, child: "test-udp-send-broadcast".text()),*/
        IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () {
            toastInfo(networkInterfaceSignal.value);
          },
        ).hoverTooltip(networkInterfaceSignal.value
            ?.text()
            .paddingOnly(all: kX)
            .constrained(maxWidth: screenWidth / 2)),
        if (_selectedRemoteDeviceId != null) ...[
          GradientButton.normal(() {
            udpServer.clearRemoteMessageList(_selectedRemoteDeviceId);
            updateState();
          }, child: "清空消息".text()),
          GradientButton.normal(() {
            udpServer.sendRemoteMessage(
                UdpMessageBean.api(UdpApis.requestAppLog()),
                remotePort: udpServer.serverBroadcastPort);
          }, child: "获取日志文件".text()),
        ]
      ]
          .flowLayout(childGap: kH, padding: const EdgeInsets.all(kX))!
          .matchParentWidth(),
      [udpServer.localInfoStream, udpClient.localInfoStream].buildFn(() {
        final serverInfo = udpServer.localInfoStream.value;
        final clientInfo = udpClient.localInfoStream.value;
        //debugger();
        if (serverInfo == null && clientInfo == null) {
          return empty;
        }
        return textSpanBuilder((builder) {
          if (serverInfo != null) {
            builder.addText("服务端已启动: ");
            builder.addText(serverInfo.toString());
          }
          if (clientInfo != null) {
            builder.newLineIfNotEmpty();
            builder.addText("客户端已启动: ");
            builder.addText(clientInfo.toString());
          }
        });
      }),
      udpServer.remoteListStream.buildFn(() {
        final clientList = udpServer.remoteList;
        if (isNil(clientList)) {
          return empty;
        }
        return [
          for (final clientInfo in clientList)
            [
              udpServer.remoteOnlineStreamOnce,
              udpServer.remoteOfflineStreamOnce,
            ]
                .buildFn(() {
                  final deviceId = clientInfo.deviceId;
                  final info = udpServer.getRemoteInfo(deviceId) ?? clientInfo;
                  return textSpanBuilder((builder) {
                    builder.addText(
                      deviceId == udpServer.localInfoStream.value?.deviceId
                          ? "自己"
                          : "客户端",
                      style: globalTheme.textDesStyle,
                    );
                    builder.addText(
                      "(${info.time?.toTimeString()})${info.isOffline ? "|离线" : ""}:\n",
                      style: globalTheme.textDesStyle,
                    );
                    builder.addText(
                      info.clientShowName,
                      style: globalTheme.textBodyStyle,
                    );
                    builder.addText(
                      "\n${info.remoteIpAddress}",
                      style: globalTheme.textDesStyle,
                    );
                  });
                })
                .align(Alignment.centerLeft)
                .paddingAll(kH)
                .backgroundColor(_selectedRemoteDeviceId == clientInfo.deviceId
                    ? globalTheme.pressColor
                    : null)
                .ink(
                  () {
                    _selectedRemoteDeviceId = clientInfo.deviceId;
                    updateState();
                  },
                  enable: _selectedRemoteDeviceId != clientInfo.deviceId,
                )
                .matchParentHeight(),
        ].scroll()?.size(height: 100, width: double.infinity);
      }),
      listSignal.buildFn(() => super.buildAbc(context).expanded()),
    ].column()!;
  }

  @override
  WidgetList buildBodyList(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return [
      if (_selectedRemoteDeviceId == null)
        "!请先选择客户端!".text().center().sliverExpand(),
      if (_selectedRemoteDeviceId != null)
        ...() {
          final messageList =
              udpServer.getRemoteMessageList(_selectedRemoteDeviceId);
          if (isNil(messageList)) {
            return ["等待客户端消息...".text().center().sliverExpand()];
          }
          return [
            for (final message in messageList)
              textSpanBuilder((builder) {
                builder.addText(
                  "${message.time?.toTimeString()}(${message.type}/${message.dataSizeStr}) ${message.receiveDurationStr ?? ""}↓\n",
                  style: globalTheme.textDesStyle,
                );
                builder.addText(
                  message.data?.utf8Str,
                  style: globalTheme.textBodyStyle,
                );
              }, selectable: true),
          ];
        }(),
    ];
  }

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
}
