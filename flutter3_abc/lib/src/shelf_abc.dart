part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/07/15
///
class ShelfAbc extends StatefulWidget {
  const ShelfAbc({super.key});

  @override
  State<ShelfAbc> createState() => _ShelfAbcState();
}

class _ShelfAbcState extends State<ShelfAbc> with BaseAbcStateMixin {
  late final shelf.Flutter3ShelfHttp _shelf = shelf.Flutter3ShelfHttp()
    ..get("/", (shelf.Request request) async {
      //debugger();
      //return responseOk("Hello World!");
      return shelf
          .responseOkHtml(await loadAssetString(Assets.web.receiveFile));
    })
    ..get("/favicon.ico", (shelf.Request request) async {
      final logo = await loadAssetBytes(Assets.png.flutter.keyName);
      return shelf.responseOkFile(fileStream: logo.stream);
    })
    ..upload(onSaveFile: (filePath) {
      _uploadFilePath = filePath;
      updateState();
    });

  String? _uploadFilePath;

  //--

  late final shelf.DebugLogWebSocketServer _debugShelf =
      shelf.DebugLogWebSocketServer();

  //--

  /// udp 广播接收
  shelf.UDP? _receiveUdp;

  /// udp 广播端口
  final int _udpBroadcastPort = 9299;

  /// udp 广播接收数据集合
  final List<String> _receiveUdpList = [];

  //--

  @override
  void dispose() {
    _shelf.stop();
    _debugShelf.stop();
    _receiveUdp?.close();
    super.dispose();
  }

  @override
  WidgetList buildBodyList(BuildContext context) {
    return [
      [
        GradientButton.normal(() async {
          await _shelf.start();
          updateState();
        }, child: "启动服务".text()),
        GradientButton.normal(() {
          _shelf.stop();
        }, child: "停止服务".text()),
        //
        GradientButton.normal(() async {
          await _debugShelf.start();
          updateState();
        }, child: "启动Debug服务".text()),
        GradientButton.normal(() {
          _debugShelf.stop();
        }, child: "停止Debug服务".text()),
        //
        GradientButton.normal(() async {
          shelf.sendUdpBroadcast(
            _udpBroadcastPort,
            text: "广播:Hello udp:${nowTimeString()}",
          );
        }, child: "发送UDP广播".text()),
        GradientButton.normal(() async {
          _receiveUdp ??= await shelf.receiveUdpBroadcast(
            _udpBroadcastPort,
            onDatagramAction: (datagram, error) {
              datagram?.data.utf8Str.let((it) {
                shelf.DebugLogWebSocketServer.handleUdpBroadcastClient(it);
                if (!_receiveUdpList.contains(it)) {
                  _receiveUdpList.add(it);
                  updateState();
                }
              });
            },
          );
        }, child: "接收UDP广播".text()),
        GradientButton.normal(() async {
          _receiveUdp?.close();
          _receiveUdp = null;
        }, child: "停止接收UDP广播".text()),
      ].flowLayout(childGap: kX, padding: const EdgeInsets.all(kX))!,
      if (!isNil(_shelf.address))
        [
          "服务地址:".text(),
          _shelf.address?.text(textColor: Colors.blue).ink(() {
            _shelf.address?.openUrl();
          }).paddingSymmetric(vertical: kX),
          _shelf.address
              ?.toQrCodeImage()
              .toWidget((context, image) => image!.toImageWidget()),
        ].column(crossAxisAlignment: CrossAxisAlignment.start)!.paddingSym(),
      if (!isNil(_debugShelf.address))
        [
          "Debug服务地址:".text(),
          _debugShelf.address!.text(textColor: Colors.blue).ink(() {
            _debugShelf.address!.openUrl();
          }).paddingSymmetric(vertical: kX),
          _debugShelf.address!
              .toQrCodeImage()
              .toWidget((context, image) => image!.toImageWidget()),
        ].column(crossAxisAlignment: CrossAxisAlignment.start)!.paddingSym(),
      if (!isNil(
          shelf.DebugLogWebSocketServer.debugLogServerAddressStream.value))
        [
          "默认Debug服务地址:".text(),
          shelf.DebugLogWebSocketServer.debugLogServerAddressStream.value!
              .text(textColor: Colors.blue)
              .ink(() {
            shelf.DebugLogWebSocketServer.debugLogServerAddressStream.value!
                .openUrl();
          }).paddingSymmetric(vertical: kX),
          shelf.DebugLogWebSocketServer.debugLogServerAddressStream.value!
              .toQrCodeImage()
              .toWidget((context, image) => image!.toImageWidget()),
        ].column(crossAxisAlignment: CrossAxisAlignment.start)!.paddingSym(),
      if (!isNil(_uploadFilePath))
        [
          "收到上传文件:${nowTimeString()}->${_uploadFilePath!.fileSize.toSizeStr()}"
              .text(),
          _uploadFilePath?.text(textColor: Colors.blue).ink(() {
            //_uploadFilePath?.openFile();
          }),
          CanvasFilePreviewWidget(_uploadFilePath!.file()),
        ].column(crossAxisAlignment: CrossAxisAlignment.start)!.paddingSym(),
      if (_receiveUdpList.isNotEmpty)
        [
          "收到UDP广播[$_udpBroadcastPort]:".text(),
          ..._receiveUdpList.map((e) => e.text(textColor: Colors.blue)),
        ].column(crossAxisAlignment: CrossAxisAlignment.start)!.paddingSym(),
    ];
  }
}
