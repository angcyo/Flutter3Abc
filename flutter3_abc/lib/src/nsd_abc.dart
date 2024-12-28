part of '../flutter3_abc.dart';

///
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2024/04/11
///
class NsdAbc extends StatefulWidget {
  const NsdAbc({super.key});

  @override
  State<NsdAbc> createState() => _NsdAbcState();
}

class _NsdAbcState extends State<NsdAbc>
    with BaseAbcStateMixin, StreamSubscriptionMixin, AbcDeviceScanMixin {
  /// nsd设备操作
  final WifiDevice nsdDevice = WifiDevice();

  @override
  DeviceMixin get device => nsdDevice;

  /// 需要注册的nsd服务名称
  late TextFieldConfig nsdRegisterNameField = TextFieldConfig(
    text: "nsdRegisterNameField".hiveGet("angcyo_nsd_service"),
    hintText: "需要注册的服务名称",
    notifyDefaultTextChange: true,
    onChanged: (value) {
      //debugger();
      "nsdRegisterNameField".hivePut(value);
      //blueDevice.scanFilterKeywords = value.splitAndTrim(" ");
    },
  );

  /// nds服务类型
  late TextFieldConfig nsdServiceTypeField = TextFieldConfig(
    text: "nsdServiceTypeField".hiveGet("_http._tcp"),
    hintText: "需要注册/扫描的服务类型",
    notifyDefaultTextChange: true,
    onChanged: (value) {
      //debugger();
      "nsdServiceTypeField".hivePut(value);
      //blueDevice.scanFilterKeywords = value.splitAndTrim(" ");
    },
  );

  Registration? _registration;

  /// 注册nsd服务
  Future registerNsdService() async {
    if (_registration != null) {
      return;
    }
    final registration = await register(
      Service(
        name: nsdRegisterNameField.text,
        type: nsdServiceTypeField.text,
        port: 9200,
      ),
    );
    _registration = registration;
    updateState();
  }

  /// 注销nsd服务
  Future unregisterNsdService() async {
    if (_registration == null) {
      return;
    }
    await unregister(_registration!);
    _registration = null;
    updateState();
  }

  @override
  void dispose() {
    unregisterNsdService();
    super.dispose();
  }

  @override
  List<Widget> buildBodyList(BuildContext context) {
    const size = kH;
    return [
      [
        GradientButton.normal(() {
          if (device.scanStateStream.value == ScanState.scanning) {
            device.stopScanDevices("手动停止扫描");
          } else {
            device.startScanDevices();
          }
        },
            child: (device.scanStateStream.value == ScanState.scanning
                    ? "停止扫描"
                    : "扫描")
                .text()),
        GradientButton.normal(() {
          if (_registration == null) {
            registerNsdService();
          } else {
            unregisterNsdService();
          }
        }, child: (_registration == null ? "注册服务" : "取消注册").text()),
      ].wrap()!.paddingAll(size),
      SingleInputWidget(config: nsdServiceTypeField)
          .paddingSymmetric(horizontal: kX, vertical: kL),
      SingleInputWidget(config: nsdRegisterNameField)
          .paddingSymmetric(horizontal: kX, vertical: kL),
      for (final item
          in device.scanDeviceListStream.value
            ..sort((a, b) => b.rssi.compareTo(a.rssi)))
        FindDeviceInfoTile(device, item),
    ];
  }
}
