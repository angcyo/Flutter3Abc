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

class _UdpServiceAbcState extends State<UdpServiceAbc> with BaseAbcStateMixin {
  @override
  WidgetList buildBodyList(BuildContext context) {
    return [
      [
        GradientButton.normal(() async {
          shelf.DefaultUdpService.instance.startServer();
          updateState();
        }, child: "启动服务端".text()),
        GradientButton.normal(() {
          shelf.DefaultUdpService.instance.stopServer();
        }, child: "停止服务端".text()),
        GradientButton.normal(() async {
          shelf.DefaultUdpService.instance.startClient();
          updateState();
        }, child: "启动客户端".text()),
        GradientButton.normal(() {
          shelf.DefaultUdpService.instance.stopClient();
        }, child: "停止客户端".text()),
        GradientButton.normal(() {
          shelf.DefaultUdpService.instance.sendBroadcast(nowTimeString());
        }, child: "发送广播".text()),
      ].flowLayout(childGap: kX, padding: const EdgeInsets.all(kX))!,
    ];
  }
}
