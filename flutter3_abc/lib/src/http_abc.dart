part of '../flutter3_abc.dart';

///
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2023/11/25
///

class HttpAbc extends StatefulWidget {
  const HttpAbc({super.key});

  @override
  State<HttpAbc> createState() => _HttpAbcState();
}

class _HttpAbcModel extends ViewModel {
  final MutableLiveData<double?> httpSendProgress = vmData();
  final MutableLiveData<double?> httpReceiveProgress = vmData();
}

class _HttpAbcState extends State<HttpAbc> with BaseAbcStateMixin {
  final TextFieldConfig baseConfig = TextFieldConfig(text: $host);

  final TextFieldConfig url1Config = TextFieldConfig(
      text: "url1Config".hiveGet("https://www.baidu.com/"),
      onFocusAction: (focus, text) {
        if (focus) {
          "url1Config".hivePut(text);
        }
      });

  final TextFieldConfig url2Config = TextFieldConfig(
      text: "url2Config".hiveGet("/login"),
      onFocusAction: (focus, text) {
        if (focus) {
          "url2Config".hivePut(text);
        }
      });

  //"https://r4---sn-i3b7knzl.gvt1.com/edgedl/android/studio/install/2022.3.1.21/android-studio-2022.3.1.21-mac_arm.dmg"
  final TextFieldConfig url3Config = TextFieldConfig(
      text: "url3Config".hiveGet(
          "https://dldir1.qq.com/qqfile/qq/QQNT/036fe406/QQ_v6.9.22.18394.dmg"),
      onFocusAction: (focus, text) {
        if (focus) {
          "url3Config".hivePut(text);
        }
      });

  final TextFieldConfig url4Config = TextFieldConfig(
      text: "url4Config".hiveGet("http://lp-cam-0a784c.local/camera_update"),
      onFocusAction: (focus, text) {
        if (focus) {
          "url4Config".hivePut(text);
        }
      });

  /// 返回值监听
  final ValueNotifier result = ValueNotifier(null);

  late final _HttpAbcModel _httpAbcModel = _HttpAbcModel();

  /// [isDebug]
  final bool debug = false;

  //--

  /// 摄像头地址
  final TextFieldConfig cameraConfig = TextFieldConfig(
      text: "cameraConfig".hiveGet("http://lp-cam-0a784c.local/"),
      onFocusAction: (focus, text) {
        if (focus) {
          "cameraConfig".hivePut(text);
        }
      });

  /// 摄像头版本
  final UpdateSignalNotifier<String?> _updateSignalCameraVersion =
      createUpdateSignal();

  @override
  void initState() {
    Http.getBaseUrl = () =>
        debug ? "https://alternate.hingin.com" : "https://server.hingin.com";
    super.initState();
    _fetchCameraVersion();
  }

  @override
  void dispose() {
    _httpAbcModel.onDispose();
    super.dispose();
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
        _updateSignalCameraVersion
            .updateValue("${data["data"]["cameraVersion"]}");
      }
    });
  }

  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      SingleInputWidget(
        config: baseConfig,
        labelText: "base",
      ).paddingItem(),
      SingleInputWidget(
        config: url1Config,
        labelText: "Url1",
      ).paddingItem(),
      SingleInputWidget(
        config: url2Config,
        labelText: "Url2",
      ).paddingItem(),
      SingleInputWidget(
        config: url3Config,
        labelText: "Url3",
      ).paddingItem(),
      SingleInputWidget(
        config: url4Config,
        labelText: "Url4",
      ).paddingItem(),
      SingleInputWidget(
        config: cameraConfig,
        labelText: "摄像头地址",
        onFocusAction: (focus) {
          if (!focus) {
            _fetchCameraVersion();
          }
        },
        /*onSubmitted: (value) {
          final text = cameraConfig.text;
          debugger();
        },
        onEditingComplete: () {
          final value = cameraConfig.text;
          debugger();
        },*/
      ).paddingItem(),
      [
        FillGradientButton(
          text: "clear",
          onTap: () => result.value = null,
        ),
        FillGradientButton(
            text: "http-get",
            onTap: () => url1Config.text
                .httpGetContent()
                .get((data, error) => result.value = data ?? error)),
        FillGradientButton(
            text: "dio-get",
            onTap: () => url1Config.text
                .get<String>(
                  onReceiveProgress: (count, total) =>
                      _httpAbcModel.httpReceiveProgress.value = count / total,
                )
                .get((data, error) => result.value = data?.data ?? error)),
        FillGradientButton(
            text: "dio-post",
            onTap: () => url2Config.text.post(
                  body: {
                    "email": "angcyo@126.com",
                    "credential": "angcyo",
                  },
                  onSendProgress: (count, total) =>
                      _httpAbcModel.httpSendProgress.value = count / total,
                  onReceiveProgress: (count, total) =>
                      _httpAbcModel.httpReceiveProgress.value = count / total,
                ).get((data, error) => result.value = data?.data == null
                    ? error
                    : HttpTestBean.fromJson(data?.data))),
        FillGradientButton(
            text: "dio-download",
            onTap: () => url3Config.text
                .download(
                    getSavePath:
                        url3Config.text.basename().filePathOf("downloads"),
                    onReceiveProgress: (count, total) =>
                        _httpAbcModel.httpReceiveProgress.value = count / total)
                .get((data, error) => result.value = data?.data ?? error)),
        FillGradientButton(
            text: "dio-upload",
            onTap: () async {
              //选择文件
              (await pickFile())?.path?.let((it) {
                url4Config.text
                    .upload(
                        filePath: it,
                        onSendProgress: (count, total) => _httpAbcModel
                            .httpSendProgress.value = count / total,
                        onReceiveProgress: (count, total) => _httpAbcModel
                            .httpReceiveProgress.value = count / total)
                    .get((data, error) => result.value = data?.data ?? error);
              });
            }),
        rebuild(_updateSignalCameraVersion, (context, value) {
          return FillGradientButton(
              text: value == null ? "摄像头固件升级" : "摄像头版本($value)",
              onTap: () async {
                final url = await buildContext
                    ?.showWidgetDialog(SingleBottomInputDialog(
                  title: "固件地址",
                  inputHint: "在线升级的固件地址",
                  inputMaxLength: null,
                  enableInputDefault: true,
                  inputText: $lpDeviceKeys.lastCameraFirmwareUpgradeUrl ??
                      "https://laserpecker-prod.oss-cn-hongkong.aliyuncs.com/apply/firmware/camera_V80318.bin",
                ));
                if (url is String && !isNil(url)) {
                  $lpDeviceKeys.lastCameraFirmwareUpgradeUrl = url;
                  showStrokeLoading(context: buildContext);
                  //下载摄像头固件文件
                  final downloadCachePath =
                      await url.basename().filePathOf("downloads", true);
                  url
                      .download(
                          savePath: downloadCachePath,
                          onReceiveProgress: (count, total) => _httpAbcModel
                              .httpReceiveProgress.value = count / total)
                      .get((data, error) {
                    result.value = data?.data ?? error;
                    if (error == null) {
                      //开始升级摄像头固件
                      cameraConfig.text
                          .connectUrl("camera_update")
                          .upload(
                              filePath: downloadCachePath,
                              onSendProgress: (count, total) => _httpAbcModel
                                  .httpSendProgress.value = count / total,
                              onReceiveProgress: (count, total) => _httpAbcModel
                                  .httpReceiveProgress.value = count / total)
                          .get((data, error) {
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
              });
        }),
      ].wrap()!.paddingItem(),
      _httpAbcModel.httpSendProgress.listener((context, progress, error) {
        return LinearProgressIndicator(
          value: progress ?? 0,
        );
      }).paddingItem(),
      _httpAbcModel.httpReceiveProgress.listener((context, progress, error) {
        return LinearProgressIndicator(
          value: progress ?? 0,
        );
      }).paddingItem(),
      result.listener((context) => (result.value?.toString() ?? "--")
          .toHtmlWidget(context)
          .paddingItem()),
      result.listener((context) => (result.value == null
              ? "--"
              : "[${result.value.runtimeType}]${result.value}")
          .text()
          .paddingItem()),
    ];
  }
}
