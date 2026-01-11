import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter3_app/flutter3_app.dart';

import '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/01/10
///
/// 进程abc
class ProcessAbc extends StatefulWidget {
  const ProcessAbc({super.key});

  @override
  State<ProcessAbc> createState() => _ProcessAbcState();
}

class _ProcessAbcState extends State<ProcessAbc>
    with BaseAbcStateMixin, LogMessageStateMixin, HookMixin, HookStateMixin {
  final TextFieldConfig cmdConfig = TextFieldConfig(
    text: "_process_cmd".hiveGet(),
    onChanged: (text) {
      "_process_cmd".hivePut(text);
    },
  );

  final ProcessShell shell = ProcessShell();

  @override
  void initState() {
    hookAny(
      shell.stdout.stream.listen((value) {
        addLastMessage(value.utf8Str, isReceived: true);
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return [
      buildLogMessageListWidget(context, globalTheme).expanded(),
      buildAbc(context).card().animatedContainer(width: $ecwBp()),
    ].row()!;
  }

  @override
  WidgetList buildBodyList(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return [
      SingleInputWidget(
        config: cmdConfig,
        labelText: "命令",
        hintText: "需要执行的命令",
        maxLines: 20,
      ).paddingItem(),
      //MARK: - button
      [
        GradientButton.normal(clearLogData, child: "清屏".text()),
        GradientButton.normal(() async {
          try {
            final cmd = cmdConfig.text;
            addLastMessage("#$cmd", isReceived: false);
            final resultList = await shell.run(cmd);
            final count = resultList.length;
            addLastMessage(
              stringBuilder((builder) {
                for (final (index, result) in resultList.indexed) {
                  final out = result.stdout;
                  builder.write("[${index + 1}/$count] ");
                  builder.write("${result.pid}|${result.exitCode}|");
                  builder.write("${out.runtimeType}->$out");
                  final err = result.stderr;
                  if (err.isNotEmpty) {
                    builder.writeln();
                    builder.write("Err->$err");
                  }
                }
              }),
              isReceived: true,
            );
          } catch (e, s) {
            assert(() {
              l.w(e);
              return true;
            }());
            debugger();
            addLastMessage("$e", isReceived: true);
          }
        }, child: "Run".text()),
        GradientButton.normal(() {
          /*final plugin = ProcessPlugin();
          buildContext?.showWidgetDialog(PluginInstallDialog(plugin));*/
          TestPlugin().start(context);
        }, child: "运行插件".text()),
      ].flowLayout(childGap: kL)!.insets(all: kL),
    ];
  }
}

class TestPlugin extends ExecutablePlugin {
  @override
  String? get downloadUrl =>
      "https://laser-engraving-test.oss-cn-heyuan.aliyuncs.com/public/plugins/test.zip";

  @override
  Future<String?> get executablePath async {
    final folder = await cacheFolder(kPluginsPathName);
    //return folder.path.join("xxx.exe");
    return "pwd";
  }

  @override
  Future<bool> install(String filePath) async {
    final folder = await cacheFolder(kPluginsPathName);
    final path = await filePath.unzip(folder.path);
    return path != null;
  }
}
