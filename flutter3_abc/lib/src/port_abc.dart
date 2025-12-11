part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2025/12/11
///
/// 端口扫描测试
class PortAbc extends StatefulWidget {
  const PortAbc({super.key});

  @override
  State<PortAbc> createState() => _PortAbcState();
}

class _PortAbcState extends State<PortAbc> {
  @override
  Widget build(BuildContext context) {
    return $discoverDeviceIp().toWidget((ctx, data) {
      return "$data".text();
    });
  }
}
