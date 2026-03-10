import 'package:flutter/material.dart';
import 'package:flutter3_ai/flutter3_ai.dart';
import 'package:flutter3_app/flutter3_app.dart';

import '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/03/10
///
/// Ai Abc
/// # LiteRT
/// - https://ai.google.dev/edge/litert?hl=zh-cn
/// # LiteRT-LM
/// https://github.com/google-ai-edge/LiteRT-LM/blob/main/README.md
///
/// # LiteRT vs LiteRT-LM vs MediaPipe 生成式 AI 任务
/// https://github.com/google-ai-edge/LiteRT-LM/blob/main/README.md#faq
/// LiteRT、LiteRT-LM 和 MediaPipe GenAI 任务是 Google AI Edge 堆栈中的三个库，彼此相辅相成。通过在不同抽象层暴露功能，我们希望帮助开发者在灵活性与复杂性之间取得平衡。
///
/// - LiteRT 是 Google AI Edge 底层的设备端运行时。开发者可以将单个 PyTorch、TensorFlow 和 JAX 模型转换为 LiteRT，并在设备上运行。
/// - LiteRT-LM 为开发者提供了一个流水线框架，将多个带有预处理和后处理组件（如分词器、视觉编码器、文本解码器）的 LiteRT 模型拼接在一起。
/// - MediaPipe 生成式 AI 任务 是开箱即用的原生 API（Kotlin、Swift、JS）用于运行语言模型： 只需设置一些参数，比如温度和 topK。
///
class AiAbc extends StatefulWidget {
  const AiAbc({super.key});

  @override
  State<AiAbc> createState() => _AiAbcState();
}

class _AiAbcState extends State<AiAbc>
    with BaseAbcStateMixin, LogMessageStateMixin {
  @override
  void initState() {
    super.initState();
    FlutterGemma.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _liteRTChat?.stopGeneration();
    _liteRTModel?.close();
  }

  @override
  Widget buildAbc(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return [
      buildLogMessageListWidget(context, globalTheme).expanded(),
      super.buildAbc(context).card().animatedContainer(width: $ecwBp()),
    ].row()!;
  }

  ModelType _liteRTModelType = ModelType.general;

  late final _messageConfig = TextFieldConfig(
    labelText: "发送给模型的数据",
    hintText: "请输入...",
    text: "_last_ai_chat_message".hiveGet() ?? "输出当前模型的详细参数!",
    onChanged: (value) {
      "_last_ai_chat_message".hivePut(value);
    },
    onSubmitted: (value) {
      _handleMessage(value);
    },
  );

  @override
  WidgetList buildBodyList(BuildContext context) {
    return [
      [
        _modelFilePath?.text().flowLayoutData(weight: 1),
        GradientButton.min(onTap: clearLogData, child: "清屏".text()),
        GradientButton.normal(_handlePickFile, child: "选择模型文件".text()),
        GradientButton.normal(() {
          "https://huggingface.co/litert-community".openUrl();
        }, child: "下载LiteRT模型文件(Hugging Face)...".text()),
        GradientButton.normal(() {
          "https://www.kaggle.com/models?framework=tfLite".openUrl();
        }, child: "下载LiteRT模型文件(Kaggle)...".text()),
        DropdownButtonTile(
          label: "选择LiteRT模型类型",
          dropdownValue: _liteRTModelType,
          dropdownValueList: ModelType.values,
          onChanged: (value) {
            _liteRTModelType = value;
          },
        ).flowLayoutData(weight: 1),
        if (_modelFilePath != null)
          GradientButton.normal(
            _initializeLiteRTModel,
            child: "初始化LiteRT模型".text(),
          ),
        if (_isLiteRTModelInitialized) ...[
          "Model installed ✅ : "
                  "hasActiveModel:${FlutterGemma.hasActiveModel()} "
                  "hasActiveEmbedder:${FlutterGemma.hasActiveEmbedder()} "
              .text()
              .flowLayoutData(weight: 1),
        ],
        Divider(
          color: GlobalTheme.of(context).lineColor,
        ).flowLayoutData(weight: 1),
        SingleInputWidget(
          config: _messageConfig,
        ).paddingItem().flowLayoutData(weight: 1),
      ].flowLayout(gap: kM)!.insets(all: kL),
    ];
  }

  String? _modelFilePath;

  void _handlePickFile() async {
    final file = await pickFile();
    _modelFilePath = file?.path;
    updateState();
  }

  //MARK: - LiteRT

  bool _isLiteRTModelInitialized = false;
  List<String> _installedLiteRTModels = [];
  InferenceModel? _liteRTModel;
  InferenceChat? _liteRTChat;

  /// 初始化模型
  ///
  /// # 模型类型[ModelType]
  /// https://pub.dev/packages/flutter_gemma#modeltype-reference
  ///
  /// Model Family         | ModelType               | Examples
  /// ---------------------|-------------------------|-------------------------------------------|
  /// Gemma (all variants) | ModelType.gemmaIt       | Gemma 3 1B, Gemma 3 270M, Gemma3n E2B/E4B
  /// DeepSeek             | ModelType.deepSeek      | DeepSeek R1
  /// Qwen                 | ModelType.qwen          | Qwen3 0.6B, Qwen 2.5 1.5B, Qwen 2.5 0.5B
  /// FunctionGemma        | ModelType.functionGemma | FunctionGemma 270M IT
  /// General              | ModelType.general       | Phi-4 Mini, FastVLM 0.5B, SmolLM 135M
  ///
  ///
  /// - [ModelFileType.task] : .task and .litertlm files - MediaPipe handles chat templates internally
  /// - [ModelFileType.binary] : .bin and .tflite files - require manual chat template formatting
  void _initializeLiteRTModel() async {
    try {
      lTime.tick();
      l.d('Step 1: Installing model...');
      final installer = FlutterGemma.installModel(
        modelType: _liteRTModelType,
        fileType: .binary,
      );
      await installer.fromFile(_modelFilePath!).install();
      l.d('Step 1: Model installed ✅');

      // Step 2: Create model with runtime config
      l.d('Step 2: Creating InferenceModel...');
      _liteRTModel = await FlutterGemma.getActiveModel();
      l.d('Step 2: InferenceModel created ✅');

      // Step 3: Create chat
      l.d('Step 3: Creating chat...');
      _liteRTChat = await _liteRTModel?.createChat();
      l.d('Step 3: Chat created ✅');

      _isLiteRTModelInitialized = true;
      _installedLiteRTModels = await FlutterGemma.listInstalledModels();
      updateState();
      addLastMessage(
        "模型初始化成功, maxTokens:${_liteRTModel?.maxTokens}, 已安装模型: $_installedLiteRTModels. 耗时:${lTime.time()}",
        isReceived: true,
      );
    } catch (e) {
      assert(() {
        l.w(e);
        return true;
      }());
      toastMessage("$e".text());
    }
  }

  /// 处理会话
  void _handleMessage(String input) async {
    addLastMessage(input);
    if (_liteRTChat != null) {
      final message = Message.text(text: input);
      /*_liteRTChat?.addQuery(message);
      final response = await _liteRTChat?.generateChatResponse();
      if (response is TextResponse) {
        addLastMessage(response.token, isReceived: true);
      } else {
        addLastMessage("${response.runtimeType}:$response", isReceived: true);
      }*/
      final service = GemmaLocalService(_liteRTChat!);
      addLastMessage("...", isReceived: true);
      String text = "";
      service
          .processMessageAsync(message)
          .listen(
            (response) {
              if (mounted) {
                if (response is TextResponse) {
                  text += response.token;
                  addLastMessage(text, isReceived: true, replaceLast: true);
                } else {
                  //l.w("$response");
                  addLastMessage(
                    "${response.runtimeType}:$response",
                    isReceived: true,
                    replaceLast: true,
                  );
                }
              }
            },
            onDone: () {
              addLastMessage(
                '🏁 GemmaInputField: Stream completed',
                isReceived: true,
              );
            },
            onError: (e) {
              addLastMessage("$e", isReceived: true);
            },
          );
    }
  }
}
