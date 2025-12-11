part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2025/12/11
///
/// dns解析测试
class DoHAbc extends StatefulWidget {
  const DoHAbc({super.key});

  @override
  State<DoHAbc> createState() => _DoHAbcState();
}

class _DoHAbcState extends State<DoHAbc> with BaseAbcStateMixin {
  @override
  void reassemble() {
    /*InternetAddress.lookup('example.com')
        .then((value) {
          //example.com: [InternetAddress('23.215.0.136', IPv4), InternetAddress('23.192.228.80', IPv4), InternetAddress('23.215.0.138', IPv4), InternetAddress('23.220.75.232', IPv4), InternetAddress('23.220.75.245', IPv4), InternetAddress('23.192.228.84', IPv4)]
          l.d('example.com: $value');
        })
        .catchError((error) {
          //Failed to lookup example.com: SocketException: Failed host lookup: 'example.com' (OS Error: nodename nor servname provided, or not known, errno = 8)
          l.d('Failed to lookup example.com: $error');
        });*/
    super.reassemble();
  }

  @override
  Widget buildAbc(BuildContext context) {
    return NetworkDiagnosisScreen();
  }

  @override
  WidgetList buildBodyList(BuildContext context) {
    return super.buildBodyList(context);
  }
}
