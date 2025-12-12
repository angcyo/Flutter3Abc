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

class _PortAbcState extends State<PortAbc> with BaseAbcStateMixin {
  @output
  String? _localIp;

  @output
  bool _isScanning = false;

  @override
  void initState() {
    $discoverDeviceIp().get((data, error) {
      _localIp = data;
      l.v("LocalIp->$data");
      updateState();
    });
    super.initState();
  }

  @override
  Widget buildAbc(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return [
      if (_isScanning)
        RadarScanWidget(
          radarColor: globalTheme.accentColor.withOpacity(0.5),
          radarScanColor: globalTheme.accentColor.withOpacity(0.5),
        ),
      super.buildAbc(context),
    ].stack()!;
  }

  @override
  WidgetList buildBodyList(BuildContext context) {
    return [
      [
        "当前本地ip: $_localIp".text().insets(all: kX),
        GradientButton.normal(() {
          _isScanning = !_isScanning;
          if (_isScanning) {
            startScanPort();
          }
          updateState();
        }, child: (_isScanning ? "停止扫描端口" : "开始扫描端口").text()),
        SingleInputWidget(
          labelText: "需要扫描的端口",
          config: scanPortField,
        ).size(width: 220).insets(horizontal: kX, vertical: kX),
      ].flowLayout()!.insets(horizontal: kX),
      for (final item in _addressList)
        "[${item.openPorts.first}]${item.ip}".text().insets(
          horizontal: kX,
          vertical: kL,
        ),
    ];
  }

  /// 需要扫描的端口
  late TextFieldConfig scanPortField = TextFieldConfig(
    text: "scanPortField".hiveGet("80"),
    hintText: "需要扫描的端口",
    notifyDefaultTextChange: true,
    onChanged: (value) {
      //debugger();
      "scanPortField".hivePut(value.isEmpty ? null : value);
      //blueDevice.scanFilterKeywords = value.splitAndTrim(" ");
    },
  );

  //MARK: - api

  /// 查找到的ip地址
  @output
  final List<NetworkAddress> _addressList = [];

  /// 开始扫描端口
  @api
  void startScanPort() {
    //debugger();
    final subnet = _localIp?.subnet ?? "";
    _addressList.clear();
    updateState();
    if (subnet.isEmpty) {
      _isScanning = false;
      return;
    }
    PortScanner.discover(
      _localIp!.subnet,
      scanPortField.text.toIntOrNull() ?? 80,
      onFindAddress: (address) {
        _addressList.add(address);
        updateState();
        //debugger();
      },
    ).listen(
      (data) {},
      onDone: () {
        _isScanning = false;
        updateState();
      },
    );
  }
}
