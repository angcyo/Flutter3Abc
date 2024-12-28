part of '../../flutter3_abc.dart';

///
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2024/04/11
///
mixin AbcDeviceScanMixin<T extends StatefulWidget>
    on BaseAbcStateMixin<T>, StreamSubscriptionMixin<T> {
  DeviceMixin get device;

  @override
  void initState() {
    // if your terminal doesn't support color you'll see annoying logs like `\x1B[1;35m`
    device.initDevice();
    hookStreamSubscription(device.scanStateStream.listen((value) {
      //debugger();
      updateState();
    }, allowBackward: false));
    hookStreamSubscription(device.scanDeviceListStream.listen((value) {
      //debugger();
      updateState();
    }, allowBackward: false));
    hookStreamSubscription(device.connectDeviceStateStreamOnce.listen((value) {
      if (value != null) {
        //debugger();
        assert(() {
          l.d('设备状态改变:$value');
          return true;
        }());
        updateState();
      }
    }));
    super.initState();
  }

  @override
  void dispose() {
    device.stopScanDevices("页面销毁");
    device.disconnectAllDevice(DisconnectType.passive, reason: "页面销毁");
    super.dispose();
  }

  @override
  Widget buildAbc(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return [
      if (device.scanStateStream.value == ScanState.scanning)
        RadarScanWidget(
          radarColor: globalTheme.accentColor.withOpacity(0.5),
          radarScanColor: globalTheme.accentColor.withOpacity(0.5),
        ),
      super.buildAbc(context)
    ].stack()!;
  }
}
