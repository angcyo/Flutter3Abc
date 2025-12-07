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
  final WifiDevice nsdDevice = WifiDevice()..useMdnsScan = false;

  @override
  DeviceMixin get device => nsdDevice;

  /// 错误
  @output
  Object? _error;

  /// 不带ip注册
  @output
  bool noIp = true;

  @override
  void reassemble() {
    logNetworkInterfaceList();
    super.reassemble();
  }

  ///
  @override
  void initState() {
    super.initState();
    logNetworkInterfaceList();
  }

  @override
  void dispose() {
    unregisterNsdService();
    super.dispose();
  }

  @override
  List<Widget> buildBodyList(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    const size = kH;
    return [
      [
        GradientButton.normal(() {
          nsdServiceTypeField.updateText("_http._tcp");
        }, child: "_http._tcp".text()),
        GradientButton.normal(() {
          nsdServiceTypeField.updateText("_services._dns-sd._udp");
        }, child: "_services._dns-sd._udp".text()),
        GradientButton.normal(() {
          nsdServiceTypeField.updateText("_acy-log._tcp");
        }, child: "_acy-log._tcp".text()),
        CheckboxTile(
          text: "自动解析",
          value: nsdDevice.nsdAutoResolve,
          mainAxisSize: .min,
          textPadding: .zero,
          onChanged: (value) {
            nsdDevice.nsdAutoResolve = value ?? nsdDevice.nsdAutoResolve;
          },
        ),
        CheckboxTile(
          text: "切换mDns扫描",
          value: nsdDevice.useMdnsScan,
          mainAxisSize: .min,
          textPadding: .zero,
          onChanged: (value) {
            nsdDevice.useMdnsScan = value ?? nsdDevice.useMdnsScan;
          },
        ),
        CheckboxTile(
          text: "不带ip注册",
          value: noIp,
          mainAxisSize: .min,
          textPadding: .zero,
          onChanged: (value) {
            noIp = value ?? noIp;
          },
        ),
        Empty.width(kX),
        //MARK: - control
        GradientButton.normal(
          () {
            if (device.scanStateStream.value == .scanning) {
              device.stopScanDevices("手动停止扫描");
            } else {
              nsdDevice.serviceType = nsdServiceTypeField.text;
              //debugger();
              try {
                _error = null;
                updateState();
                device.clearScanResult();
                device.startScanDevices(
                  onError: (e) {
                    printError(e);
                    _error = e;
                    updateState();
                  },
                );
              } catch (e) {
                printError(e);
                _error = e;
                updateState();
              }
            }
          },
          child: (device.scanStateStream.value == .scanning ? "停止扫描" : "扫描")
              .text(),
        ),
        GradientButton.normal(() {
          if (_registration == null) {
            registerNsdService();
          } else {
            unregisterNsdService();
          }
        }, child: (_registration == null ? "注册服务" : "取消注册").text()),
      ].wrap()!.paddingAll(size),
      if (_registration != null)
        "$_registration".text(style: globalTheme.textDesStyle).insets(all: kL),
      //MARK: - input
      SingleInputWidget(
        labelText: "服务类型",
        config: nsdServiceTypeField,
      ).insets(horizontal: kX, vertical: kL),
      SingleInputWidget(
        labelText: "注册服务名称",
        config: nsdRegisterNameField,
      ).insets(horizontal: kX, vertical: kL),
      //MARK: - list
      if (_error != null) "$_error".text().insets(all: kX).center(),
      if (_error == null)
        for (final item
            in device.scanDeviceListStream.value
              ..sort((a, b) => b.rssi.compareTo(a.rssi)))
          FindDeviceInfoTile(device, item),
    ];
  }

  //MARK: - core

  /// 需要注册的nsd服务名称
  late TextFieldConfig nsdRegisterNameField = TextFieldConfig(
    text: "nsdRegisterNameField".hiveGet("angcyo_nsd_${$platformName}"),
    hintText: "需要注册的服务名称",
    notifyDefaultTextChange: true,
    onChanged: (value) {
      //debugger();
      "nsdRegisterNameField".hivePut(value.isEmpty ? null : value);
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
      "nsdServiceTypeField".hivePut(value.isEmpty ? null : value);
      //blueDevice.scanFilterKeywords = value.splitAndTrim(" ");
    },
  );

  Registration? _registration;

  /// 注册nsd服务
  /// ```
  /// flutter: NsdError (message: "Service type must be in format _<Service>._<Proto>: acy_log._tcp", cause: illegalArgument)
  /// ```
  ///
  /// # `_<Service>` (服务标识符)
  /// - _http：用于万维网服务 (Web Service)
  /// - _ftp：用于文件传输协议 (File Transfer Protocol)
  /// - _ssh：用于安全外壳协议 (Secure Shell)
  /// - _ipp：用于互联网打印协议 (Internet Printing Protocol)
  /// - 自定义服务：_my_chat、_custom_api
  ///
  /// # `_<Proto>` (传输协议)
  /// - _tcp (Transmission Control Protocol)：用于基于连接的可靠传输。
  /// - _udp (User Datagram Protocol)：用于无连接的传输。
  Future registerNsdService() async {
    if (_registration != null) {
      return;
    }
    //Call: register {handle: 23b3062d-af75-4221-8c5c-9f60d68e8f5f, service.name: angcyo_nsd_service, service.type: _http._tcp, service.host: null, service.port: 9200, service.txt: null}
    //Callback: onRegistrationSuccessful {handle: 23b3062d-af75-4221-8c5c-9f60d68e8f5f, service.type: _http._tcp, service.host: null, service.port: 9200, service.name: angcyo_nsd_service (2)}
    try {
      final registration = await register(
        Service(
          name: nsdRegisterNameField.text,
          type: nsdServiceTypeField.text,
          port: 9200,
          //MARK: -
          host: $uuid,
          addresses: noIp ? null : [?await $getLocalInternetAddress()],
        ),
      );
      _registration = registration;
      updateState();
    } catch (e) {
      printError(e);
      toast("$e".text());
    }
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
}
