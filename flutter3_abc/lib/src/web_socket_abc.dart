part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/07/17
///
class WebSocketAbc extends StatefulWidget {
  const WebSocketAbc({super.key});

  @override
  State<WebSocketAbc> createState() => _WebSocketAbcState();
}

class _WebSocketAbcState extends State<WebSocketAbc>
    with BaseAbcStateMixin, StreamSubscriptionMixin {
  late final shelf.Flutter3ShelfWebSocketServer _webSocketServer =
      shelf.Flutter3ShelfWebSocketServer();

  /// 消息
  final messageList = <String>[];

  late final _messageFieldConfig = TextFieldConfig(
    text: "lastWebSocketMessage".hiveGet<String>(),
    hintText: "发送的内容",
    onChanged: (text) {
      "lastWebSocketMessage".hivePut(text);
    },
  );

  late final _wsUrlFieldConfig = TextFieldConfig(
    text: "lastWebSocketWsUrl".hiveGet<String>("ws://echo.websocket.events"),
    hintText: "WebSocket服务地址",
    onChanged: (text) {
      "lastWebSocketWsUrl".hivePut(text);
    },
  );

  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  void initState() {
    shelf.$debugLogWebSocketServer; //init
    hookStreamSubscription(_webSocketServer.clientStreamOnce.listen((client) {
      if (client != null) {
        _appendMessage("${client.clientId}状态->${client.state}");
      }
    }));
    hookStreamSubscription(
        _webSocketServer.clientMessageStreamOnce.listen((message) {
      if (message != null) {
        _appendMessage("${message.client.clientId}消息->${message.message}");
      }
    }));
    super.initState();
  }

  @updateMark
  void _appendMessage(String message) {
    messageList.add(message);
    updateState();
  }

  @override
  void dispose() {
    _webSocketServer.stop();
    super.dispose();
  }

  @override
  WidgetList buildBodyList(BuildContext context) {
    return [
      //--
      [
        GradientButton.normal(() async {
          await _webSocketServer.start();
          updateState();
        }, child: "启动ws服务".text()),
        GradientButton.normal(() {
          _webSocketServer.stop();
        }, child: "停止ws服务".text()),
      ].flowLayout(childGap: kX, padding: const EdgeInsets.all(kX))!,
      //--
      if (!isNil(_webSocketServer.address))
        [
          "服务地址:".text(),
          _webSocketServer.address?.text(textColor: Colors.blue).ink(() {
            _webSocketServer.address?.openUrl();
          }).paddingSymmetric(vertical: kX),
          _webSocketServer.address
              ?.toQrCodeImage()
              .toWidget((context, image) => image!.toImageWidget()),
        ].column(crossAxisAlignment: CrossAxisAlignment.start)!.paddingAll(kX),
      //--
      if (!isNil(shelf.$debugLogWebSocketServer.address))
        [
          "Debug服务地址:".text(),
          shelf.$debugLogWebSocketServer.address!
              .text(textColor: Colors.blue)
              .ink(() {
            shelf.$debugLogWebSocketServer.address!.openUrl();
          }).paddingSymmetric(vertical: kX),
          shelf.$debugLogWebSocketServer.address!
              .toQrCodeImage()
              .toWidget((context, image) => image!.toImageWidget()),
          SingleInputWidget(config: _messageFieldConfig).paddingOnly(top: kX),
          [
            GradientButton.normal(() {
              _webSocketServer.send(_messageFieldConfig.text);
              shelf.$debugLogWebSocketServer.send(_messageFieldConfig.text);
            }, child: "发送消息".text()),
          ].flowLayout(
              childGap: kX, padding: const EdgeInsets.symmetric(vertical: kX))!,
        ].column(crossAxisAlignment: CrossAxisAlignment.start)!.paddingAll(kX),
      //--
      [
        SingleInputWidget(config: _wsUrlFieldConfig).paddingOnly(top: kX),
        [
          GradientButton.normal(() {
            _connectWebSocket();
          }, child: "连接".text()),
          GradientButton.normal(() {
            _disconnectWebSocket();
          }, child: "断开".text()),
          GradientButton.normal(() {
            _sendWebSocketMessage();
          }, child: "发送".text()),
        ].flowLayout(
            childGap: kX, padding: const EdgeInsets.symmetric(vertical: kX))!,
      ].column(crossAxisAlignment: CrossAxisAlignment.start)!.paddingAll(kX),
      for (final msg in messageList)
        msg.text().paddingOnly(left: kX, right: kX, top: kM),
    ];
  }

  //--

  WebSocketChannel? _webSocket;

  Future _connectWebSocket() async {
    final wsUrl = _wsUrlFieldConfig.text.toUri()!;
    _disconnectWebSocket();
    _webSocket = IOWebSocketChannel.connect(
      wsUrl,
      connectTimeout: kDefTimeout.microseconds,
    );
    try {
      await _webSocket!.ready;
      _webSocket!.stream.listen(
        (value) {
          //
          print('received: $value');
          _webSocket?.sink.add('received!');
          _webSocket?.sink.close(3000);
        },
        onDone: () {
          _appendMessage("done");
        },
        onError: (e) {
          print(e);
          _appendMessage("$e");
        },
        cancelOnError: true,
      );
    } catch (e) {
      print(e);
      _appendMessage("$e");
    }
  }

  void _disconnectWebSocket() {
    _webSocket?.sink.close();
    _webSocket = null;
  }

  void _sendWebSocketMessage() {
    _webSocket?.sink.add(_messageFieldConfig.text);
  }
}
