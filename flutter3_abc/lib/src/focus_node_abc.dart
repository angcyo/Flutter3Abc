import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter3_app/flutter3_app.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2025/12/20
///
class FocusNodeAbc extends StatefulWidget {
  const FocusNodeAbc({super.key});

  @override
  State<FocusNodeAbc> createState() => _FocusNodeAbcState();
}

class _FocusNodeAbcState extends State<FocusNodeAbc> {
  final config1 = TextFieldConfig(hintText: "请输入1...");

  final config2 = TextFieldConfig(hintText: "请输入2...");

  @override
  Widget build(BuildContext context) {
    return [
      SingleInputWidget(config: config1),
      SingleInputWidget(config: config2).insets(v: kX),
      "Focus + FocusNode ↓".text().insets(all: kH),
      buildFocusNodeButton(),
      "FocusScope + Focus + FocusNode ↓".text().insets(all: kH),
      FocusScope(child: buildFocusNodeButton(useScope: true)),
      "CustomFocus + FocusNode ↓".text().insets(all: kH),
      buildCustomFocusButton(),
      "FocusScope + CustomFocus + FocusNode ↓".text().insets(all: kH),
      buildCustomFocusButton(useScope: true),
    ].column()!.insets(all: kX);
  }

  ///
  Widget buildFocusNodeButton({bool useScope = false}) {
    return [
      FocusNodeButton(useScope: useScope),
      FocusNodeButton(useScope: useScope),
      FocusNodeButton(useScope: useScope),
      FocusNodeButton(useScope: useScope, hideOnFocus: true),
    ].wrap()!;
  }

  ///
  Widget buildCustomFocusButton({bool useScope = false}) {
    return [
      CustomFocusButton(useScope: useScope),
      CustomFocusButton(useScope: useScope),
      CustomFocusButton(useScope: useScope),
      CustomFocusButton(useScope: useScope, hideOnFocus: true),
    ].wrap()!;
  }
}

/// 焦点按钮
class FocusNodeButton extends StatefulWidget {
  final bool useScope;

  final bool hideOnFocus;

  const FocusNodeButton({
    super.key,
    this.useScope = false,
    this.hideOnFocus = false,
  });

  @override
  State<FocusNodeButton> createState() => _FocusNodeButtonState();
}

class _FocusNodeButtonState extends State<FocusNodeButton> with FocusNodeMixin {
  @override
  Widget build(BuildContext context) {
    return GradientButton(
      onTap: onTap,
      child: "焦点($hasFocus)".text(),
    ).focus(focusNode: focusNode, autofocus: false).visible(visible: !hide);
  }
}

class CustomFocusButton extends StatefulWidget {
  final bool useScope;

  final bool hideOnFocus;

  const CustomFocusButton({
    super.key,
    this.useScope = false,
    this.hideOnFocus = false,
  });

  @override
  State<CustomFocusButton> createState() => _CustomFocusButtonState();
}

class _CustomFocusButtonState extends State<CustomFocusButton>
    with FocusNodeMixin {
  @override
  Widget build(BuildContext context) {
    return CustomFocus(
      focusNode: focusNode,
      child: GradientButton(onTap: onTap, child: "焦点($hasFocus)".text()),
    ).visible(visible: !hide);
  }
}

//MARK: - CustomFocus

class CustomFocus extends SingleChildRenderObjectWidget {
  final FocusNode focusNode;

  const CustomFocus({super.key, super.child, required this.focusNode});

  @override
  RenderObject createRenderObject(BuildContext context) =>
      CustomFocusRender(focusNode: focusNode, context: context);

  @override
  void updateRenderObject(
    BuildContext context,
    CustomFocusRender renderObject,
  ) {
    renderObject
      ..context = context
      ..focusNode = focusNode;
  }
}

class CustomFocusRender extends RenderProxyBox {
  BuildContext? context;

  FocusNode? focusNode;

  CustomFocusRender({this.context, this.focusNode});

  FocusAttachment? _focusAttachment;

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _focusAttachment = focusNode?.attach(context);
    focusNode?.addListener(_handleFocusChanged);
    _focusAttachment?.reparent(parent: null);
    l.i("[${classHash()}]attach");
  }

  @override
  void detach() {
    //focusNode?.detach();
    l.i("[${classHash()}]detach");
    /*focusNode?.dispose();*/
    /*focusNode
      ?..unfocus()
      ..removeListener(_handleFocusChanged)
      ..dispose();*/
    _focusAttachment?.detach();
    /*_focusAttachment?.reparent(parent: null);*/
    super.detach();
  }

  @override
  void dispose() {
    l.w("[${classHash()}]dispose");
    /*focusNode
      ?..removeListener(_handleFocusChanged)
      ..dispose();
    _focusAttachment?.detach();*/
    super.dispose();
  }

  void _handleFocusChanged() {
    //debugger();
    l.i("[${classHash()}]_handleFocusChanged->${focusNode?.hasFocus}");
  }
}

//MARK: - FocusNodeMixin

mixin FocusNodeMixin<T extends StatefulWidget> on State<T> {
  late FocusNode focusNode = FocusNode();

  bool get hasFocus => focusNode.hasFocus;

  bool get useScope => (widget as dynamic).useScope;

  bool get hideOnFocus => (widget as dynamic).hideOnFocus;

  bool hide = false;

  @override
  void initState() {
    focusNode.addListener(() {
      l.w("[${classHash()}]焦点变化->$hasFocus");
      updateState();
    });
    super.initState();
  }

  void onTap() {
    if (hasFocus) {
      if (hideOnFocus) {
        hide = true;
        updateState();
      } else {
        if (useScope) {
          FocusScope.of(context).unfocus();
        } else {
          focusNode.unfocus();
        }
      }
    } else {
      if (useScope) {
        FocusScope.of(context).requestFocus(focusNode);
      } else {
        focusNode.requestFocus();
      }
    }
  }
}
