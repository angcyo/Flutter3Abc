part of '../flutter3_abc.dart';

///
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2024/04/09
///
class BluetoothAbc extends StatefulWidget {
  const BluetoothAbc({super.key});

  @override
  State<BluetoothAbc> createState() => _BluetoothAbcState();
}

class _BluetoothAbcState extends State<BluetoothAbc>
    with BaseAbcStateMixin, StreamSubscriptionMixin, AbcDeviceScanMixin {
  /// 蓝牙设备操作
  final BleDevice blueDevice = BleDevice();

  @override
  DeviceMixin get device => blueDevice;

  late TextFieldConfig scanFilterServicesField = TextFieldConfig(
    text: "scanFilterServicesField".hiveGet(),
    hintText: "扫描过滤的服务id",
    notifyDefaultTextChange: true,
    onChanged: (value) {
      //debugger();
      "scanFilterServicesField".hivePut(value);
      blueDevice.scanFilterServices = value.splitAndTrim(" ");
    },
  );
  late TextFieldConfig scanFilterKeywordsField = TextFieldConfig(
    text: "scanFilterKeywordsField".hiveGet(),
    hintText: "扫描过滤的关键字",
    notifyDefaultTextChange: true,
    onChanged: (value) {
      //debugger();
      "scanFilterKeywordsField".hivePut(value);
      blueDevice.scanFilterKeywords = value.splitAndTrim(" ");
    },
  );

  @override
  List<Widget> buildBodyList(BuildContext context) {
    const size = kH;
    return [
      [
        Bluetooth.isSupported().toWidget((context, value) {
          if (value == true) {
            return "支持蓝牙[${true.toDC()}]".text();
          } else {
            return "[$value]不支持蓝牙".text();
          }
        }).ink(() {}),
        Permissions.hasBluetoothPermissions().toWidget((context, value) {
          if (value == true) {
            return "蓝牙权限[${true.toDC()}]".text();
          } else {
            return "蓝牙权限[$value]".text().ink(() {
              context.showWidgetDialog(
                MessageDialog(
                    title: "注意",
                    message: "即将请求蓝牙相关权限!",
                    onConfirmTap: ((_) async {
                      Permissions.requestBluetoothPermissions()
                          .get((value, error) {
                        updateState();
                      });
                      return false;
                    })),
              );
            });
          }
        }),
        Permissions.hasBluetoothPermissions().toWidget((context, value) {
          if (value == true) {
            return [
              GradientButton.normal(() {
                if (blueDevice.scanStateStream.value == ScanState.scanning) {
                  blueDevice.stopScanDevices("手动停止扫描");
                } else {
                  blueDevice.startScanDevices();
                }
              },
                  child: (blueDevice.scanStateStream.value == ScanState.scanning
                          ? "停止扫描"
                          : "扫描")
                      .text()),
            ].wrap()!;
          } else {
            return empty;
          }
        }),
      ]
          .wrap(
            spacing: size,
            runSpacing: size,
            crossAxisAlignment: WrapCrossAlignment.center,
          )!
          .paddingAll(kX),
      SingleInputWidget(config: scanFilterServicesField)
          .paddingSymmetric(horizontal: kX, vertical: kL),
      SingleInputWidget(config: scanFilterKeywordsField)
          .paddingSymmetric(horizontal: kX, vertical: kL),
      //已经连接上的设备和扫出来的设备
      for (final item
          in device.scanDeviceListStream.value
            ..sort((a, b) => (b.rssi).compareTo(a.rssi)))
        FindDeviceInfoTile(blueDevice, item),
    ];
  }
}
