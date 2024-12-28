part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/12/28
///

class NotificationAbc extends StatefulWidget {
  const NotificationAbc({super.key});

  @override
  State<NotificationAbc> createState() => _NotificationAbcState();
}

class _NotificationAbcState extends State<NotificationAbc>
    with BaseAbcStateMixin, HiveHookMixin {
  late final TextFieldConfig _channelIdFieldConfig =
      TextFieldConfig(text: "_channelId".hiveGet("通道ID"));
  late final TextFieldConfig _channelNameFieldConfig =
      TextFieldConfig(text: "_channelName".hiveGet("通道名称"));
  late final TextFieldConfig _channelDescriptionFieldConfig =
      TextFieldConfig(text: "_channelDescription".hiveGet("通道描述"));

  late final TextFieldConfig _titleFieldConfig =
      TextFieldConfig(text: "_notifyTitle".hiveGet("通知标题"));
  late final TextFieldConfig _contentFieldConfig =
      TextFieldConfig(text: "_notifyContent".hiveGet("通知内容"));

  /// 通知权限是否开启
  bool? _notificationsEnabled;

  @override
  void initState() {
    hookHiveKey("_channelId", _channelIdFieldConfig.controller);
    hookHiveKey("_channelName", _channelNameFieldConfig.controller);
    hookHiveKey(
        "_channelDescription", _channelDescriptionFieldConfig.controller);
    hookHiveKey("_notifyTitle", _titleFieldConfig.controller);
    hookHiveKey("_notifyContent", _contentFieldConfig.controller);

    initPlatformNotification(notifyIcon: 'flutter_dash_255');
    isAndroidNotificationsPermissionGranted().then((value) {
      value?.let((it) {
        _notificationsEnabled = value;
        updateState();
      });
    });

    super.initState();
  }

  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      "当前平台:$currentPlatform".text(textAlign: TextAlign.center),
      "通知权限是否开启: $_notificationsEnabled".text(textAlign: TextAlign.center),
      SingleInputWidget(
        config: _channelIdFieldConfig,
        hintText: "Android通道Id",
      ).paddingAll(kH),
      SingleInputWidget(
        config: _channelNameFieldConfig,
        hintText: "Android通道名称",
      ).paddingAll(kH),
      SingleInputWidget(
        config: _channelDescriptionFieldConfig,
        hintText: "Android通道描述",
      ).paddingAll(kH),
      SingleInputWidget(
        config: _titleFieldConfig,
        hintText: "请输入通知标题",
      ).paddingAll(kH),
      SingleInputWidget(
        config: _contentFieldConfig,
        hintText: "请输入通知内容",
      ).paddingAll(kH),
      [
        GradientButton(
            onTap: () {
              requestNotificationsPermissions().then((value) {
                value?.let((it) {
                  _notificationsEnabled = value;
                  updateState();
                });
              });
            },
            child: "请求权限".text()),
        GradientButton(
            onTap: () {
              showPlatformNotification(
                id: 100,
                title: _titleFieldConfig.text,
                content: _contentFieldConfig.text,
                channelName: _channelNameFieldConfig.text,
                androidChannelId: _channelIdFieldConfig.text,
                androidChannelDescription: _channelDescriptionFieldConfig.text,
              ).get((value, error) {
                error?.let((it) {
                  toastBlur(text: "$it");
                  return it;
                });
              });
            },
            child: "显示通知".text()),
      ].wrap()!.paddingAll(kH),
    ];
  }
}
