part of '../flutter3_abc.dart';

///
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2024/04/19
///

class PluginAbc extends StatefulWidget {
  const PluginAbc({super.key});

  @override
  State<PluginAbc> createState() => _PluginAbcState();
}

class _PluginAbcState extends State<PluginAbc> with BaseAbcStateMixin {
  /// 用来触发结果重构的信号
  final resultUpdateSignal = nullValueUpdateSignal;

  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      [
        GradientButton.normal(() async {
          final value = await context
              .showWidgetDialog(const NumberKeyboardDialog(number: 1));
          resultUpdateSignal.value = value;
        }, child: "NumberKeyboardDialog".text()),
        GradientButton.normal(() async {
          final result = await LpPlugin.getPlatformVersion();
          resultUpdateSignal.value = result;
        }, child: "getPlatformVersion".text()),
        GradientButton.normal(() async {
          final result = await LpPlugin.getPlatformSdkInt();
          resultUpdateSignal.value = result;
        }, child: "getPlatformSdkInt".text()),
        GradientButton.normal(() async {
          final result = await LpPlugin.getExternalFilesPath();
          resultUpdateSignal.value = result;
        }, child: "getExternalFilesPath".text()),
        GradientButton.normal(() async {
          final result = await LpPlugin.any(nextInt(2 ^ 32));
          resultUpdateSignal.value = result;
        }, child: "any-int".text()),
        GradientButton.normal(() async {
          final result = await LpPlugin.any(nextDouble());
          resultUpdateSignal.value = result;
        }, child: "any-double".text()),
        GradientButton.normal(() async {
          final result = await LpPlugin.any(nextBool());
          resultUpdateSignal.value = result;
        }, child: "any-bool".text()),
        GradientButton.normal(() async {
          final result = await LpPlugin.any("angcyo");
          resultUpdateSignal.value = result;
        }, child: "any-string".text()),
        GradientButton.normal(() async {
          final result = await LpPlugin.any({
            "1": 1,
            "2": 2.0,
            "3": "3",
            "4": true,
            "5": [1, 2, 3],
            "6": {"1": 1, "2": 2}
          });
          resultUpdateSignal.value = result;
        }, child: "any-map".text()),
        GradientButton.normal(() async {
          final result = await LpPlugin.any(["1", "2", "3"]);
          resultUpdateSignal.value = result;
        }, child: "any-list".text()),
        GradientButton.normal(() async {
          // 1MB
          final data = List.generate(1024 * 1024 * 1, (index) => index);
          lTime.tick();
          final result = await LpPlugin.any(data);
          resultUpdateSignal.value = "1MB 耗时:${lTime.time()}";
        }, child: "1MB".text()),
        GradientButton.normal(() async {
          // 2MB
          final data = List.generate(1024 * 1024 * 2, (index) => index);
          lTime.tick();
          final result = await LpPlugin.any(data);
          resultUpdateSignal.value = "2MB 耗时:${lTime.time()}";
        }, child: "2MB".text()),
        GradientButton.normal(() async {
          // 5MB
          final data = List.generate(1024 * 1024 * 5, (index) => index);
          lTime.tick();
          final result = await LpPlugin.any(data);
          resultUpdateSignal.value = "5MB 耗时:${lTime.time()}";
        }, child: "5MB".text()),
        GradientButton.normal(() async {
          // 10MB
          final data = List.generate(1024 * 1024 * 10, (index) => index);
          lTime.tick();
          final result = await LpPlugin.any(data);
          resultUpdateSignal.value = "10MB 耗时:${lTime.time()}";
        }, child: "10MB".text()),
        GradientButton.normal(() async {
          // 20MB
          final data = List.generate(1024 * 1024 * 20, (index) => index);
          lTime.tick();
          final result = await LpPlugin.any(data);
          resultUpdateSignal.value = "20MB 耗时:${lTime.time()}";
        }, child: "20MB".text()),
        GradientButton.normal(() async {
          // 50MB
          final data = List.generate(1024 * 1024 * 50, (index) => index);
          lTime.tick();
          final result = await LpPlugin.any(data);
          resultUpdateSignal.value = "50MB 耗时:${lTime.time()}";
        }, child: "50MB".text()),
        GradientButton.normal(() async {
          // 100MB
          final data = List.generate(1024 * 1024 * 100, (index) => index);
          lTime.tick();
          final result = await LpPlugin.any(data);
          resultUpdateSignal.value = "100MB 耗时:${lTime.time()}";
        }, child: "100MB".text()),
        GradientButton.normal(() async {
          lTime.tick();
          final image = await captureScreenImage();
          final file = await image
              ?.saveToFilePath(await cacheFilePath(nowTimeFileName()));
          resultUpdateSignal.value =
              "${file?.lengthSync().toSizeStr()} 耗时:${lTime.time()}";
        }, child: "imageToFile".text()),
        GradientButton.normal(() async {
          lTime.tick();
          final image = await captureScreenImage();
          final byteData =
              await image?.toByteData(format: UiImageByteFormat.png);
          resultUpdateSignal.value =
              "${byteData?.bytes.length.toSizeStr()} 耗时:${lTime.time()}";
        }, child: "imageToBytes".text()),
        GradientButton.normal(() async {
          lTime.tick();
          final image = await captureScreenImage();
          final bytes = await image?.toPixels();
          resultUpdateSignal.value =
              "${bytes?.length.toSizeStr()} 耗时:${lTime.time()}";
        }, child: "imageToPixels".text()),
      ].flowLayout(padding: const EdgeInsets.all(kH), childGap: kH)!,
      rebuild(
          resultUpdateSignal,
          (context, data) => textSpanBuilder((builder) {
                builder
                  ..addTextColor(
                      "${nowTimeString()} 结果[${data.runtimeType}]:\n",
                      Colors.redAccent)
                  ..addText("$data");
              }))
    ];
  }
}
