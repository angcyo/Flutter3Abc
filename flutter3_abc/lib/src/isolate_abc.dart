import 'dart:isolate';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter3_app/flutter3_app.dart';

import '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/03/04
///
/// Isolate Abc
class IsolateAbc extends StatefulWidget {
  const IsolateAbc({super.key});

  @override
  State<IsolateAbc> createState() => _IsolateAbcState();
}

class _IsolateAbcState extends State<IsolateAbc> with BaseAbcStateMixin {
  /// 分离株
  Isolate? _isolate;

  /// 发送数据给后台分离株的端口
  SendPort? _backgroundSendPort;

  Uint8List? _4gbByteData;

  String? _result;

  @override
  WidgetList buildBodyList(BuildContext context) {
    return [
      _result?.connect(null, "${nowTimeString()}\n").text().insets(all: kH),
      [
        GradientButton.normal(() async {
          //_testCostTime();
          _isolate = await _startIsolate(
            onReceiveSendPort: (sendPort) {
              _backgroundSendPort = sendPort;
            },
          );
        }, child: "启动Isolate".text()),
        GradientButton.normal(() {
          _backgroundSendPort?.send("close");
          _backgroundSendPort = null;
          if (_isolate != null) {
            _isolate?.kill(priority: Isolate.immediate);
            l.d("...kill");
            _isolate = null;
          }
        }, child: "停止Isolate".text()),
        GradientButton.normal(() {
          _backgroundSendPort?.send("close");
        }, child: "发送close".text()),
        GradientButton.normal(() {
          _backgroundSendPort?.send("test");
        }, child: "发送数据至Isolate".text()),
        GradientButton.normal(() {
          final byteData = Uint8List(2 * 1024 * 1024);
          lTime.tick();
          _backgroundSendPort?.send(byteData);
          _result = "发送数据至Isolate(2MB) ${lTime.time()}";
          updateState();
        }, child: "发送数据至Isolate(2MB)".text()),
        GradientButton.normal(() {
          lTime.tick();
          _4gbByteData = Uint8List(4 * 1024 * 1024 * 1024);
          _result = "创建4GB数据 ${lTime.time()}";
          updateState();
        }, child: "创建4GB数据".text()),
        GradientButton.normal(() {
          if (_4gbByteData != null) {
            lTime.tick();
            _backgroundSendPort?.send(_4gbByteData!);
            _result = "发送数据至Isolate(4GB) ${lTime.time()}";
            updateState();
          }
        }, child: "发送数据至Isolate(4GB)".text()),
        GradientButton.normal(() {
          if (_4gbByteData != null) {
            lTime.tick();
            final byteData = TransferableTypedData.fromList([
              _4gbByteData!.byteData,
            ]);
            _backgroundSendPort?.send(byteData);
            _result = "发送数据至Isolate2(4GB) ${lTime.time()}";
            updateState();
          }
        }, child: "发送数据至Isolate2(4GB)".text()),
      ].flowLayout(
        childGap: kH,
        padding: insets(all: kH),
      )!,
    ].filterNull();
  }
}

//MARK: - test

/// 循环100w次, 并计算耗时
void _testCostTime() {
  final startTime = DateTime.now().millisecondsSinceEpoch;
  var sum = 0; //
  for (int i = 0; i < 2_999_999_999; i++) {
    //no op
    sum += i;
  }
  final endTime = DateTime.now().millisecondsSinceEpoch;
  //3B 1301 ms : 4499999995500000001
  l.i("cost time: ${endTime - startTime} ms : $sum");
}

//MARK: - isolate

/// 后台 Isolate 的入口函数
@pragma("vm:entry-point")
void _backgroundWorker(SendPort mainSendPort) {
  // 1. 创建自己的接收端，用于接收主线程的消息
  ReceivePort workerReceivePort = ReceivePort();

  // 2. 把自己的发送端传给主线程
  mainSendPort.send(workerReceivePort.sendPort);

  // 3. 监听主线程发来的消息
  workerReceivePort.listen(
    (message) {
      l.i("收到消息->$message");
      if (message is int) {
        // 执行任务并回传结果
        mainSendPort.send("处理进度: ${message * 10}%");
      } else if (message == "close") {
        workerReceivePort.close();
      } else if (message == "test") {
        _testCostTime();
      }
    },
    onDone: () {
      l.i("后台任务完成");
    },
    onError: (error) {
      l.e("后台任务出错: $error");
    },
  );
}

/// - [Isolate.kill]
/// - [ReceivePort.close]
Future<Isolate> _startIsolate({
  void Function(SendPort sendPort)? onReceiveSendPort,
}) async {
  //用来接收后台的消息
  final ReceivePort mainReceivePort = ReceivePort();

  // 产生后台 Isolate
  final isolate = await Isolate.spawn(
    _backgroundWorker,
    mainReceivePort.sendPort,
  );
  //mainReceivePort.close();

  // 监听后台回传
  mainReceivePort.listen(
    (message) {
      l.i("收到消息->$message");
      if (message is SendPort) {
        final SendPort sendPort = message; // 拿到后台的发送端口
        sendPort.send(5); // 向后台发送数据
        onReceiveSendPort?.call(sendPort);
      } else {
        l.d("收到后台消息: $message");
      }
    },
    onDone: () {
      l.i("isolate任务完成");
    },
    onError: (error) {
      l.e("isolate任务出错: $error");
    },
  );

  //isolate.kill(priority: Isolate.immediate);
  return isolate;
}
