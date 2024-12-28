part of '../../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/03/06
///

/// 颜色通道
/// [ui.ImageByteFormat.rawRgba]
/// [PixelFormat.rgba8888]
enum ImageColorChannel {
  R,
  G,
  B,
  A,
}

class ImageAbc extends StatefulWidget {
  const ImageAbc({super.key});

  @override
  State<ImageAbc> createState() => _ImageAbcState();
}

class _ImageAbcState extends State<ImageAbc> with BaseAbcStateMixin {
  /// 当前选择的图片
  final selectedImageSignal = createUpdateSignal<ImageMeta>();

  /// 操作处理后的图片
  final resultImageSignal = createUpdateSignal<ImageMeta>();

  /// 返回文本更新的信号
  final resultTextSignal = createUpdateSignal<dynamic>();

  /// 耗时
  String? costTime;

  bool invert = false;
  double contrast = 0;
  double brightness = 0;
  int alphaThreshold = 8;
  UiColor alphaReplaceColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
  }

  @override
  List<Widget> buildBodyList(BuildContext context) {
    final size = UiSize(double.infinity, min(screenWidth, screenHeight));
    return [
      [
        /*ColoredBox(
          color: Colors.black12,
        ),*/
        Container(
          width: size.width,
          height: size.height,
          color: Colors.black12,
        ),
        /*paintWidget((canvas, size) {
          canvas.drawRect(
              Offset.zero & size,
              Paint()
                ..color = Colors.black12
                ..style = PaintingStyle.fill);
        }, size: size),*/
        rebuild(selectedImageSignal,
            (context, data) => (data as ImageMeta?)?.toImageWidget() ?? empty),
        if (selectedImageSignal.value == null)
          "点击选择图片"
              .text(textAlign: TextAlign.center)
              .paddingAll(kX)
              .shadowRadius()
              .wrapContent(wrapBoth: true)
              .align(Alignment.center)
      ]
          .stack(alignment: Alignment.center)!
          .constrainedMin(minWidth: size.width, minHeight: size.height)
          .click(() {
        //toastInfo("选择图片");
        pickSingleImage().then((value) {
          if (value != null) {
            value.path?.toImageMetaFromFile(toPixels: true).then((value) {
              setState(() {
                selectedImageSignal.value = value;
              });
            });
          }
        });
      }),
      //---
      [
        GradientButton.normal(() async {
          lTime.tick();
          resultImageSignal.value = await extractChannel(
              selectedImageSignal.value, ImageColorChannel.A);
          costTime = lTime.time();
          resultTextSignal.updateValue(costTime);
        }, child: "提取A通道".text()),
        GradientButton.normal(() async {
          lTime.tick();
          resultImageSignal.value = await extractChannel(
              selectedImageSignal.value, ImageColorChannel.R);
          costTime = lTime.time();
          resultTextSignal.updateValue(costTime);
        }, child: "提取R通道".text()),
        GradientButton.normal(() async {
          lTime.tick();
          resultImageSignal.value = await extractChannel(
              selectedImageSignal.value, ImageColorChannel.G);
          costTime = lTime.time();
          resultTextSignal.updateValue(costTime);
        }, child: "提取G通道".text()),
        GradientButton.normal(() async {
          lTime.tick();
          resultImageSignal.value = await extractChannel(
              selectedImageSignal.value, ImageColorChannel.B);
          costTime = lTime.time();
          resultTextSignal.updateValue(costTime);
        }, child: "提取B通道".text()),
        GradientButton.normal(() async {
          selectedImageSignal.value?.let((imageMeta) async {
            lTime.tick();
            final bytes = await imageMeta.image.toBytes();
            costTime = "${lTime.time()} :${bytes?.size().toSizeStr()}";
            resultTextSignal.updateValue(costTime);
          });
        }, child: "image->bytes".text()),
        GradientButton.normal(() async {
          selectedImageSignal.value?.let((imageMeta) async {
            lTime.tick();
            final pixels = await imageMeta.image.toPixels();
            costTime = "${lTime.time()} :${pixels?.size().toSizeStr()}";
            resultTextSignal.updateValue(costTime);
          });
        }, child: "image->pixels".text()),
        GradientButton.normal(() async {
          selectedImageSignal.value?.let((imageMeta) async {
            lTime.tick();
            final file = await imageMeta.pixels!
                .writeToFile(file: (await cacheFilePath("test_pixels")).file());
            costTime =
                "${lTime.time()} :${file.path} :${file.fileSizeSync().toSizeStr()}";
            resultTextSignal.updateValue(costTime);
          });
        }, child: "pixels->file".text()),
        GradientButton.normal(() async {
          lTime.tick();
          final value = toDigits(value: 1.555, digits: 2, round: true);
          costTime = "${lTime.time()} :$value";
          resultTextSignal.updateValue(costTime);
        }, child: "->rust-test".text()),
        GradientButton.normal(() async {
          selectedImageSignal.value?.let((imageMeta) async {
            lTime.tick();
            final len = testData(data: imageMeta.pixels!);
            costTime = "${lTime.time()} :${len.toSizeStr()}";
            resultTextSignal.updateValue(costTime);
          });
        }, child: "->rust-data".text()),
        GradientButton.normal(() async {
          lTime.tick();
          final cachePath = await cacheFilePath("test.txt");
          testWriteData(
              data: "${nowTimeString()}\nangcyo".bytes,
              filePath: cachePath,
              append: true);
          final size = await cachePath.file().fileSize();
          costTime = "${lTime.time()} :${size.toSizeStr()}";
          resultTextSignal.updateValue(costTime);
        }, child: "->rust-file-w".text()),
        GradientButton.normal(() async {
          lTime.tick();
          final cachePath = await cacheFilePath("test.txt");
          // final cachePath = await cacheFilePath("cache_pixels.bin");
          final bytes = testReadData(filePath: cachePath);
          final size = await cachePath.file().fileSize();
          costTime =
              "${lTime.time()} :${size.toSizeStr()} :${bytes.length.toSizeStr()}\n${bytes.toStr()}";
          resultTextSignal.updateValue(costTime);
        }, child: "->rust-file-r".text()),
        GradientButton.normal(() {
          selectedImageSignal.value?.let((imageMeta) async {
            lTime.tick();
            resultImageSignal.value = await ImageHandleHelper.grayImageDart(
              imageMeta,
              invert: invert,
              contrast: contrast,
              brightness: brightness,
              alphaThreshold: alphaThreshold,
              alphaReplaceColor: alphaReplaceColor,
            );
            costTime = lTime.time();
            resultTextSignal.updateValue(costTime);
          });
        }, child: "dart-灰度".text()),
        GradientButton.normal(() {
          selectedImageSignal.value?.let((imageMeta) async {
            lTime.tick();
            resultImageSignal.value = await ImageHandleHelper.grayImageRust(
              imageMeta,
              invert: invert,
              contrast: contrast,
              brightness: brightness,
              alphaThreshold: alphaThreshold,
              alphaReplaceColor: alphaReplaceColor,
            );
            costTime = lTime.time();
            resultTextSignal.updateValue(costTime);
          });
        }, child: "rust-灰度".text()),
        GradientButton.normal(() {
          selectedImageSignal.value?.let((imageMeta) async {
            lTime.tick();
            resultImageSignal.value =
                await ImageHandleHelper.grayImageBytesRust(
              imageMeta,
              invert: invert,
              contrast: contrast,
              brightness: brightness,
              alphaThreshold: alphaThreshold,
              alphaReplaceColor: alphaReplaceColor,
            );
            costTime = lTime.time();
            resultTextSignal.updateValue(costTime);
          });
        }, child: "rust-灰度-bytes".text()),
        GradientButton.normal(() {
          selectedImageSignal.value?.let((imageMeta) async {
            lTime.tick();
            resultImageSignal.value = await ImageHandleHelper.grayImageShader(
              imageMeta,
              invert: invert,
              contrast: contrast,
              brightness: brightness,
              alphaThreshold: alphaThreshold,
              alphaReplaceColor: alphaReplaceColor,
            );
            costTime = lTime.time();
            resultTextSignal.updateValue(costTime);
          });
        }, child: "shader-灰度".text()),
        /*GradientButton.normal(() async {
          lTime.tick();
          */ /*resultImageMeta = await io(selectedImageMeta,
                  (message) async => await bwHandle(message));*/ /*
          resultImageMeta = await bwHandle(selectedImageMeta);
          costTime = lTime.time();
          resultTextSignal.updateValue(costTime);
        }, child: "黑白处理".text()),*/
      ].wrap()!,
      rebuild(resultTextSignal, (context, data) => buildInfo()),
      rebuild(resultImageSignal,
          (context, data) => (data as ImageMeta?)?.toImageWidget() ?? empty),
    ];
  }

  Widget buildInfo() {
    return textSpanBuilder((builder) {
      builder.addText("选择图片: ");
      selectedImageSignal.value?.let((it) {
        builder.addTextStyle(
          "${it.width}x${it.height} ${it.imageFormat} ",
          color: Colors.red,
        );
        builder.addText(it.bytes?.length.toSizeStr());
      });
      //---
      builder.addText("\n处理后: ");
      resultImageSignal.value?.let((it) {
        builder.addTextStyle(
          "${it.width}x${it.height}=${it.width * it.height} ",
          color: Colors.red,
        );
        it.pixels?.lengthInBytes.let((length) {
          builder.addText("pixels:${length.toSizeStr()}");
        });
      });
      //--
      costTime?.let((it) => builder.addText("\n耗时: $it"));
    });
  }

  /// 提取颜色通道
  Future<ImageMeta?> extractChannel(
      ImageMeta? imageMeta, ImageColorChannel channel) async {
    final pixels = imageMeta?.pixels;
    if (imageMeta == null || pixels == null) {
      return null;
    }
    int width = imageMeta.width;
    int height = imageMeta.height;
    final resultPixels = Uint8List(pixels.lengthInBytes);
    for (var i = 0; i < pixels.lengthInBytes; i += 4) {
      switch (channel) {
        case ImageColorChannel.R:
          resultPixels[i] = pixels[i];
          resultPixels[i + 1] = 0;
          resultPixels[i + 2] = 0;
          resultPixels[i + 3] = 255;
          break;
        case ImageColorChannel.G:
          resultPixels[i] = 0;
          resultPixels[i + 1] = pixels[i + 1];
          resultPixels[i + 2] = 0;
          resultPixels[i + 3] = 255;
          break;
        case ImageColorChannel.B:
          resultPixels[i] = 0;
          resultPixels[i + 1] = 0;
          resultPixels[i + 2] = pixels[i + 2];
          resultPixels[i + 3] = 255;
          break;
        case ImageColorChannel.A:
          resultPixels[i] = 0;
          resultPixels[i + 1] = 0;
          resultPixels[i + 2] = 0;
          resultPixels[i + 3] = pixels[i + 3];
          break;
      }
    }
    final image = await resultPixels.toImageFromPixels(width, height);
    //final base64 = await image.toBase64();
    return ImageMeta(image, null, resultPixels);
  }
}
