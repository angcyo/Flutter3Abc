part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/10/24
///
class CoverCameraAbc extends StatefulWidget {
  const CoverCameraAbc({super.key});

  @override
  State<CoverCameraAbc> createState() => _CoverCameraAbcState();
}

class _CoverCameraAbcState extends State<CoverCameraAbc>
    with
        AbsScrollPage,
        TickerProviderStateMixin,
        StreamSubscriptionMixin,
        DeviceScanMixin {
  /// 选中设备扫描结果更新后, 刷新列表
  @override
  UpdateValueNotifier? get pageScrollChildrenUpdateSignal =>
      scanSelectedResultUpdateSignal;

  /// 保本映射收集
  final Map<String, Map<String, String>> _versionMap = {};

  String? _selectedDeviceName;

  String? get _selectedCoverVersion =>
      _versionMap[_selectedDeviceName]?["coverVersion"];

  String? get _selectedCameraVersion =>
      _versionMap[_selectedDeviceName]?["cameraVersion"];

  String? getCoverVersion(String? deviceName) =>
      _versionMap[deviceName]?["coverVersion"];

  String? getCameraVersion(String? deviceName) =>
      _versionMap[deviceName]?["cameraVersion"];

  /// 返回值监听
  final ValueNotifier result = ValueNotifier(null);

  /// 摄像头地址
  final TextFieldConfig cameraConfig = TextFieldConfig(
      text: "cameraConfig".hiveGet("http://lp-cam-0a784c.local/"),
      onFocusAction: (focus, text) {
        if (focus) {
          "cameraConfig".hivePut(text);
        }
      });

  /// 保护罩固件地址
  final TextFieldConfig coverUrlConfig = TextFieldConfig(
      text: $lpDeviceKeys.lastCoverFirmwareUpgradeUrl ??
          "https://laserpecker-prod.oss-cn-hongkong.aliyuncs.com/apply/firmware/cover_V80210.bin",
      onFocusAction: (focus, text) {
        if (focus) {
          $lpDeviceKeys.lastCoverFirmwareUpgradeUrl = text;
        }
      });

  /// 摄像头固件地址
  final TextFieldConfig cameraUrlConfig = TextFieldConfig(
      text: $lpDeviceKeys.lastCameraFirmwareUpgradeUrl ??
          "https://laserpecker-prod.oss-cn-hongkong.aliyuncs.com/apply/firmware/camera_V80318.bin",
      onFocusAction: (focus, text) {
        if (focus) {
          $lpDeviceKeys.lastCameraFirmwareUpgradeUrl = text;
        }
      });

  @override
  bool getResizeToAvoidBottomInset(BuildContext context) => true;

  @override
  String? getTitle(BuildContext context) {
    return "保护罩/摄像头固件升级";
  }

  @override
  void initState() {
    super.initState();
    final scanDeviceList = deviceScanManager.scanDeviceList.filter((e) {
      if (e is WifiDevice) {
        e.filterDeviceNameStartList = ["LP-CAM-"];
        return true;
      }
      return false;
    });
    initScanDeviceList(scanDeviceList);
  }

  @override
  Widget buildBody(BuildContext context, WidgetList? children) {
    return [
      super.buildBody(context, children).expanded(),
      SingleInputWidget(
        config: cameraConfig,
        labelText: "摄像头地址",
        onFocusAction: (focus) {
          if (!focus) {
            _selectedDeviceName = cameraConfig.text;
            _fetchFirmwareVersion(_selectedDeviceName);
          }
        },
      ).paddingItem(),
      SingleInputWidget(
        config: coverUrlConfig,
        labelText: "保护罩固件地址",
      ).paddingItem(),
      SingleInputWidget(
        config: cameraUrlConfig,
        labelText: "摄像头固件地址",
      ).paddingItem(),
      [
        FillGradientButton(
            text: "刷新",
            onTap: () async {
              _fetchFirmwareVersion(_selectedDeviceName);
            }),
        FillGradientButton(
            text: "保护罩固件升级",
            onTap: () async {
              _startUpdateCoverFirmware(coverUrlConfig.text);
              /*final url =
                  await buildContext?.showWidgetDialog(SingleBottomInputDialog(
                title: "固件地址",
                inputHint: "在线升级的固件地址",
                inputMaxLength: null,
                enableInputDefault: true,
                inputText: $lpDeviceKeys.lastCoverFirmwareUpgradeUrl ??
                    "https://laserpecker-prod.oss-cn-hongkong.aliyuncs.com/apply/firmware/cover_V80210.bin",
              ));
              if (url is String && !isNil(url)) {
                $lpDeviceKeys.lastCoverFirmwareUpgradeUrl = url;
                _startUpdateCoverFirmware(url);
              }*/
            }),
        FillGradientButton(
            text: "摄像头固件升级",
            onTap: () async {
              _startUpdateCameraFirmware(cameraUrlConfig.text);
              /*final url =
                  await buildContext?.showWidgetDialog(SingleBottomInputDialog(
                title: "固件地址",
                inputHint: "在线升级的固件地址",
                inputMaxLength: null,
                enableInputDefault: true,
                inputText: $lpDeviceKeys.lastCameraFirmwareUpgradeUrl ??
                    "https://laserpecker-prod.oss-cn-hongkong.aliyuncs.com/apply/firmware/camera_V80318.bin",
              ));
              if (url is String && !isNil(url)) {
                $lpDeviceKeys.lastCameraFirmwareUpgradeUrl = url;
                _startUpdateCameraFirmware(url);
              }*/
            }),
      ].wrap()!.paddingItem().matchParentWidth(),
    ].column()!;
  }

  /// host
  String _getDeviceHost(String? deviceName) =>
      "http://${deviceName?.toLowerCase()}.local/";

  /// 同时获取保护罩/摄像头版本
  void _fetchFirmwareVersion(String? deviceName) {
    if (deviceName == null || deviceName.isEmpty) {
      return;
    }
    cameraConfig.text.connectUrl("firmware_version").get().http((data, error) {
      if (data is String) {
        data = jsonDecode(data);
      }
      if (data is Map) {
        dynamic body;
        if (data["code"] == 200) {
          body = data["data"];
        } else if (data["code"] == null) {
          body = data;
        }

        if (body != null) {
          _versionMap[deviceName] = {
            "coverVersion": "${body?["coverVersion"] ?? "--"}",
            "cameraVersion": "${body?["cameraVersion"] ?? "--"}"
          };
          updatePageScrollChildren();
        }
      }
    });
  }

  /// 获取保护罩版本
  void _fetchCoverVersion() {
    cameraConfig.text
        .connectUrl("cover_firmware_version")
        .get()
        .http((data, error) {
      if (data is String) {
        data = jsonDecode(data);
      }
      if (data is Map) {
        /*_updateSignalCoverVersion
            .updateValue("${data["data"]?["hostVersion"] ?? "--"}");*/
      }
    });
  }

  /// 获取摄像头版本
  void _fetchCameraVersion() {
    cameraConfig.text
        .connectUrl("camera_firmware_version")
        .get()
        .http((data, error) {
      if (data is String) {
        data = jsonDecode(data);
      }
      if (data is Map) {
        /*_updateSignalCameraVersion
            .updateValue("${data["data"]?["cameraVersion"] ?? "--"}");*/
      }
    });
  }

  @override
  WidgetList? buildScrollBody(BuildContext context) {
    return [
      for (final device
          in selectedScanResultList..sort((a, b) => (b.rssi).compareTo(a.rssi)))
        StateDecorationWidget(
          selectedDecoration: _getDeviceHost(device.name) == cameraConfig.text
              ? fillDecoration(color: Colors.black12, radius: 0)
              : null,
          child: TextTile(
            text:
                "${device.name} -> 保护罩:${getCoverVersion(device.name) ?? "?"} 摄像头:${getCameraVersion(device.name) ?? "?"}",
          ),
        ).click(() {
          cameraConfig.text = _getDeviceHost(device.name);
          _selectedDeviceName = device.name;
          _fetchFirmwareVersion(_selectedDeviceName);
          updateState();
        }),
    ];
  }

  /// 开始升级保护罩固件
  /// 1: 下载升级文件
  /// 2: 发送升级命令
  Future _startUpdateCoverFirmware(String? firmwareUrl) async {
    if (firmwareUrl == null) {
      return;
    }
    showStrokeLoading(context: buildContext);
    //下载保护罩固件文件
    final downloadCachePath =
        await firmwareUrl.basename().filePathOf("downloads", true);
    firmwareUrl.download(savePath: downloadCachePath).get((data, error) {
      result.value = data?.data ?? error;
      if (error == null) {
        //开始升级保护罩固件
        cameraConfig.text
            .connectUrl("cover_update")
            .upload(filePath: downloadCachePath)
            .get(null)
            .http((data, error) {
          result.value = data?.data ?? error;
          hideLoading();
        });
      } else {
        hideLoading();
      }
    });
  }

  /// 开始升级摄像头固件
  /// 1: 下载升级文件
  /// 2: 发送升级命令
  /// 3: 重启机器
  Future _startUpdateCameraFirmware(String? firmwareUrl) async {
    if (firmwareUrl == null) {
      return;
    }
    showStrokeLoading(context: buildContext);
    //下载摄像头固件文件
    final downloadCachePath =
        await firmwareUrl.basename().filePathOf("downloads", true);
    firmwareUrl.download(savePath: downloadCachePath).get((data, error) {
      result.value = data?.data ?? error;
      if (error == null) {
        //开始升级摄像头固件
        cameraConfig.text
            .connectUrl("camera_update")
            .upload(filePath: downloadCachePath)
            .get(null)
            .http((data, error) {
          result.value = data?.data ?? error;
          if (error == null) {
            //摄像头升级之后要重启
            cameraConfig.text.connectUrl("camera_reboot").get();
          }
          hideLoading();
        });
      } else {
        hideLoading();
      }
    });
  }
}
