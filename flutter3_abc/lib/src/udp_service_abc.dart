part of '../flutter3_abc.dart';

///
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2025/01/07
///
class UdpServiceAbc extends StatefulWidget {
  const UdpServiceAbc({super.key});

  @override
  State<UdpServiceAbc> createState() => _UdpServiceAbcState();
}

class _UdpServiceAbcState extends State<UdpServiceAbc>
    with BaseAbcStateMixin, HookMixin, HookStateMixin {
  final shelf.DefaultUdpService defaultUdpService =
      shelf.DefaultUdpService.instance;
  final shelf.UdpService udpService = shelf.$defaultUdp;

  /// 网口信息
  final networkInterfaceSignal = $signal<String>();

  /// 消息列表更新信号
  final listSignal = $signal();

  /// 选中的设备id
  String? _selectedDeviceId;

  @override
  void initState() {
    _loadNetworkInterface();
    hookAny(defaultUdpService.newClientMessageStreamOnce.listen((data) {
      if (_selectedDeviceId != null && data?.deviceId == _selectedDeviceId) {
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
    if (udpService != shelf.$defaultUdp) {
      udpService.dispose();
    }
    super.dispose();
  }

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

  @override
  Widget buildAbc(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return [
      [
        GradientButton.normal(() async {
          udpService.startServer();
          updateState();
        }, child: "启动服务端".text()),
        GradientButton.normal(() {
          udpService.stopServer();
        }, child: "停止服务端".text()),
        GradientButton.normal(() async {
          udpService.startClient();
          updateState();
        }, child: "启动客户端".text()),
        GradientButton.normal(() {
          udpService.stopClient();
        }, child: "停止客户端".text()),
        GradientButton.normal(() {
          udpService.sendBroadcast(nowTimeString().bytes);
        }, child: "发送广播".text()),
        GradientButton.normal(() {
          defaultUdpService
              .sendBroadcastMessage(shelf.UdpMessageBean.text(nowTimeString()));
        }, child: "发送消息广播".text()),
        GradientButton.normal(() {
          final clientInfo =
              defaultUdpService.getServerClientInfo(_selectedDeviceId);
          defaultUdpService.testTcpSendToClient(
            clientInfo?.clientAddress,
            clientInfo?.clientPort,
            nowTimeString().bytes,
          );
        }, child: "test-tcp-to-client".text()),
        GradientButton.normal(() {
          final clientInfo =
              defaultUdpService.getServerClientInfo(_selectedDeviceId);
          defaultUdpService.testUdpSendToClient(
            clientInfo?.clientAddress,
            clientInfo?.clientPort,
            nowTimeString().bytes,
          );
        }, child: "test-udp-to-client".text()),
        IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () {
            toastInfo(networkInterfaceSignal.value);
          },
        ).hoverTooltip(networkInterfaceSignal.value
            ?.text()
            .paddingOnly(all: kX)
            .constrained(maxWidth: screenWidth / 2)),
      ]
          .flowLayout(childGap: kH, padding: const EdgeInsets.all(kX))!
          .matchParentWidth(),
      [defaultUdpService.serverInfoSignal, defaultUdpService.clientInfoSignal]
          .buildFn(() {
        final serverInfo = defaultUdpService.serverInfoSignal.value;
        final clientInfo = defaultUdpService.clientInfoSignal.value;
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
      defaultUdpService.clientListStream.buildFn(() {
        final clientList = defaultUdpService.getServerClientList();
        if (isNil(clientList)) {
          return empty;
        }
        return [
          for (final clientInfo in clientList)
            textSpanBuilder((builder) {
              builder.addText(
                "${clientInfo.deviceId == defaultUdpService.serverInfoSignal.value?.deviceId ? "自己" : "客户端"}(${clientInfo.time?.toTimeString()}):\n",
                style: globalTheme.textDesStyle,
              );
              builder.addText(
                clientInfo.clientShowName,
                style: globalTheme.textBodyStyle,
              );
              builder.addText(
                "\n${clientInfo.clientIpAddress}",
                style: globalTheme.textDesStyle,
              );
            })
                .align(Alignment.centerLeft)
                .paddingAll(kH)
                .backgroundColor(_selectedDeviceId == clientInfo.deviceId
                    ? globalTheme.pressColor
                    : null)
                .ink(
              () {
                _selectedDeviceId = clientInfo.deviceId;
                updateState();
              },
              enable: _selectedDeviceId != clientInfo.deviceId,
            ).matchParentHeight(),
        ].scroll()?.size(height: 100, width: double.infinity);
      }),
      listSignal.buildFn(() => super.buildAbc(context).expanded()),
    ].column()!;
  }

  @override
  WidgetList buildBodyList(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return [
      if (_selectedDeviceId == null) "!请先选择客户端!".text().center().sliverExpand(),
      if (_selectedDeviceId != null)
        ...() {
          final messageList =
              defaultUdpService.getServerClientMessageList(_selectedDeviceId);
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
}
