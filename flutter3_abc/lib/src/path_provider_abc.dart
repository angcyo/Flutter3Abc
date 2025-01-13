part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/11/17
///
/// ```
/// '${Platform.resolvedExecutable} | ${Platform.script} | ${Platform.executable} | ${Platform.resolvedExecutable}')
/// ```
///
class PathProviderAbc extends StatefulWidget {
  const PathProviderAbc({super.key});

  @override
  State<PathProviderAbc> createState() => _PathProviderAbcState();
}

class _PathProviderAbcState extends State<PathProviderAbc>
    with BaseAbcStateMixin {
  final PathViewModel pathViewModel = PathViewModel();
  Text? files;

  @override
  void initState() {
    super.initState();
    //pathViewModel.loadPath().whenComplete(() => updateState());
  }

  void setFiles(List<PlatformFile>? list) {
    if (list == null || list.isEmpty) {
      files = const Text('取消选择');
    } else {
      files = textSpanBuilder((builder) {
        builder.addText('选择了${list.length}个文件:\n');
        list.forEachIndexed((index, element) {
          builder.addText('$index:${element.name}',
              style: const TextStyle(color: Colors.red));
          builder.addText('->${element.path}\n');
        });
      });
    }
    updateState();
  }

  @override
  List<Widget> buildBodyList(BuildContext context) {
    var map = pathViewModel.pathMap.value;
    if (pathViewModel.pathMap.value == null) {
      pathViewModel
          .loadPath()
          .whenComplete(() => context.buildContext?.tryUpdateState());
      return [
        const Text(
          'loading...',
          textAlign: TextAlign.center,
        )
      ];
    } else {
      //遍历map
      final WidgetList list = [];
      final platform =
          "$defaultTargetPlatform ${Platform.operatingSystemVersion} ${Platform
          .localHostname} / ${Platform.version}";
      l.i(platform);
      list.add("$platform PathViewModel↓"
          .text(
          style: const TextStyle(color: Colors.purpleAccent),
          selectable: true)
          .click(() {
        platform.copy();
      }));
      map!.forEach((key, value) {
        l.i('$key->${value?.path}');
        list.add(
          ListTile(
            title: Text(key),
            subtitle: Text("$value"),
            onTap: () {
              //launchUrl('file://C:'.toUri()!);
              openFilePath(value?.path);
            },
          ),
        );
      });

      //hive abc
      list.add(
          "hiveAll↓".text(style: const TextStyle(color: Colors.purpleAccent)));
      hiveAll()?.forEach((key, value) {
        list.add(ListTile(
          title: Text(key),
          subtitle: Text("${value.runtimeType}:$value"),
        ));
      });

      //test

      list.add([
        GradientButton(
          onTap: () async {
            setFiles((await pickFiles(allowMultiple: false))?.files);
          },
          child: const Text("选择文件(单选)"),
        ),
        GradientButton(
          onTap: () async {
            setFiles((await pickFiles(
              dialogTitle: "选择文件(多选)",
              allowMultiple: true,
            ))
                ?.files);
          },
          child: const Text("选择文件(多选)"),
        ),
        GradientButton(
          onTap: () async {
            var path = await pickDirectoryPath();
            if (path != null) {
              files = Text('选择了文件夹:$path');
            } else {
              files = const Text('取消选择');
            }
            updateState();
          },
          child: const Text("选择文件夹"),
        ),
      ].wrap()!);

      list.add(Empty.height(10));

      //zip
      list.add([
        GradientButton(
          onTap: () async {
            final output = await cacheFilePath("${nowTimeFileName()}.zip");
            //var path = await fileFolderPath(kLogPathName);
            final path = (await fileFolder()).path;
            path.ofList<String>().zip(output).ignore();
            final log =
                "压缩完成:$output :${(await output.file().fileSize())
                .toSizeStr()}";
            l.d(log);
            toastInfo("压缩完成:$output");
            output.shareFile().ignore();
            files = Text(log);
            updateState();
          },
          child: const Text("压缩并分享"),
        ),
        GradientButton(
          onTap: () async {
            final output = await cacheFilePath("${nowTimeFileName()}.zip");
            //var path = await fileFolderPath(kLogPathName);
            final path = (await fileFolder()).path;
            path.ofList<String>().zip(output).ignore();
            final log =
                "压缩完成:$output :${(await output.file().fileSize())
                .toSizeStr()}";
            l.d(log);
            toastInfo("压缩完成:$output");
            openFilePath(output);
            //output.shareFile().ignore();
            files = Text(log);
            updateState();
          },
          child: const Text("压缩并打开"),
        ),
        GradientButton(
          onTap: () async {
            final output = await cacheFilePath("${nowTimeFileName()}.zip");
            final result = await output.unzip(
                (AbcConfig.getAndIncrementClickCount() % 2 == 0)
                    ? null
                    : (await cacheFolder()).path);
            files = Text("解压:$output\n$result");
            updateState();
          },
          child: const Text("解压"),
        ),
        GradientButton(
          onTap: () async {
            //"E:/FlutterProjects/Flutter3DesktopAbc/lib/main.dart";
            final output = await kLFileName.logFilePath();
            openFilePath(output);
            files = Text("文件路径->$output");
            updateState();
          },
          child: const Text("打开文件"),
        ),
      ].wrap()!);

      if (files != null) {
        list.add(files!);
      }

      return list;
    }
  }
}
