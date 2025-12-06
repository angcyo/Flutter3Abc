part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/09/27
///
class MdnsAbc extends StatefulWidget {
  const MdnsAbc({super.key});

  @override
  State<MdnsAbc> createState() => _MdnsAbcState();
}

class _MdnsAbcState extends State<MdnsAbc> with BaseAbcStateMixin {
  @configProperty
  final name = '_http._tcp';

  /// # ios
  /// 在 `Info.plist` 中添加描述:
  /// ```
  /// <key>NSLocalNetworkUsageDescription</key>
  /// <string>Required to discover local network devices</string>
  /// <key>NSBonjourServices</key>
  /// <array>
  ///   <string>_http._tcp</string>
  ///   <string>_myService._tcp</string>
  /// </array>
  /// ```
  ///
  @output
  final client = MDnsClient();

  @output
  final serviceList = <Map<String, dynamic>>[];

  /// 错误
  @output
  Object? _error;

  @override
  void initState() {
    super.initState();
    () async {
      try {
        await client.start(onError: (e) {
          printError(e);
          _error = e;
          updateState();
        });
        // Get the PTR record for the service.
        await for (final PtrResourceRecord ptr
            in client.lookup<PtrResourceRecord>(
                ResourceRecordQuery.serverPointer(name))) {
          //观察指定服务
          // Use the domainName from the PTR record to get the SRV record,
          // which will have the port and local hostname.
          // Note that duplicate messages may come through, especially if any
          // other mDNS queries are running elsewhere on the machine.
          await for (final SrvResourceRecord srv
              in client.lookup<SrvResourceRecord>(
                  ResourceRecordQuery.service(ptr.domainName))) {
            //查询域名
            // Domain name will be something like "io.flutter.example@some-iphone.local._dartobservatory._tcp.local"
            await for (final IPAddressResourceRecord ip
                in client.lookup<IPAddressResourceRecord>(
                    ResourceRecordQuery.addressIPv4(srv.target))) {
              //查询ip
              serviceList.add({
                "domainName": ptr.domainName,
                "name": srv.target,
                "host": ip.address.address,
                "port": srv.port
              });
              //debugger();
              updateState();
            }
          }
        }
      } catch (e) {
        printError(e);
        _error = e;
        updateState();
      }
    }();
  }

  @override
  void dispose() {
    client.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: _error != null
          ? "$_error".text().insets(all: kX).center()
          : ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(serviceList[index]["name"]),
                  subtitle: Text(serviceList[index].toString()),
                  onTap: () {
                    //
                  },
                );
              },
              itemCount: serviceList.length),
    );
  }
}
