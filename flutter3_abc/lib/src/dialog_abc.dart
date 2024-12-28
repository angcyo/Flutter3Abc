part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/11/14
///

/// https://api.flutter.dev/flutter/material/BottomSheet-class.html
class DialogAbc extends StatefulWidget {
  const DialogAbc({super.key});

  @override
  State<DialogAbc> createState() => _DialogAbcState();
}

class _DialogAbcState extends State<DialogAbc> with BaseAbcStateMixin {
  List<PopupMenuEntry<String>> buildMenu(BuildContext context) {
    return <PopupMenuEntry<String>>[
      PopupMenuItem(
        value: randomText(),
        child: randomTextWidget(length: 5),
      ),
      PopupMenuItem(
        value: randomText(),
        child: randomTextWidget(length: 5),
      ),
      PopupMenuItem(
        value: randomText(),
        child: randomTextWidget(length: 5),
      ),
    ];
  }

  List<Widget> buildMenu2(BuildContext context) {
    return <Widget>[
      MenuItemButton(
        onPressed: onPressed,
        child: randomTextWidget(length: 5),
      ),
      MenuItemButton(
        onPressed: onPressed,
        child: randomTextWidget(length: 5),
      ),
      MenuItemButton(
        onPressed: onPressed,
        child: randomTextWidget(length: 5),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    l.v('build...');
    ThemeData themeData = Theme.of(context);
    ThemeData newThemeData = themeData.copyWith(
      bottomSheetTheme: themeData.bottomSheetTheme.copyWith(
        showDragHandle: true,
        /*constraints: const BoxConstraints.expand(),*/
      ),
    );
    return Theme(
      data: newThemeData,
      child: super.build(context),
    );
  }

  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      const Text(
        "Dialog↓",
        textAlign: TextAlign.center,
      ),
      <Widget>[
        GradientButton.normal(
          () {
            showDialog(
              context: context,
              barrierColor: randomColor(),
              builder: (context) {
                return randomWidget(text: randomText());
              },
            );
          },
          child: const Text('showDialog1'),
        ),
        GradientButton.normal(
          () {
            showDialog(
              context: context,
              barrierLabel: "barrierLabel",
              barrierDismissible:
                  AbcConfig.getAndIncrementClickCount() % 2 == 0,
              builder: (context) {
                return Align(
                  alignment: Alignment.center,
                  child: randomTextWidget(),
                );
              },
            );
          },
          child: const Text('showDialog2'),
        ),
        GradientButton.normal(
          () {
            showCupertinoDialog(
              context: context,
              barrierLabel: "barrierLabel",
              barrierDismissible:
                  AbcConfig.getAndIncrementClickCount() % 2 == 0,
              builder: (context) {
                return Container(
                  alignment: Alignment.center,
                  constraints: const BoxConstraints.tightFor(),
                  child: randomTextWidget()
                      .wrapTextStyle()
                      .container(color: randomColor()),
                );
              },
            );
          },
          child: const Text('showCupertinoDialog'),
        ),
        GradientButton.normal(
          () {
            showGeneralDialog(
              context: context,
              barrierLabel: "barrierLabel",
              barrierDismissible:
                  AbcConfig.getAndIncrementClickCount() % 2 == 0,
              pageBuilder: (context, animation, secondaryAnimation) {
                return Container(
                  alignment: Alignment.center,
                  child: Container(
                    color: randomColor(),
                    child: randomTextWidget().wrapTextStyle(),
                  ),
                );
              },
            );
          },
          child: const Text('showGeneralDialog'),
        ),
        GradientButton.normal(
          () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog.adaptive(
                  title: const Text('Title'),
                  content: const Text('Content'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text('AlertDialog.adaptive'),
        ),
        GradientButton.normal(
          () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Title'),
                  content: const Text('Content'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ).willPop();
              },
            );
          },
          child: const Text('AlertDialog'),
        ),
        GradientButton.normal(
          () {
            showDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: const Text('Title'),
                  content: const Text('Content'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text('CupertinoAlertDialog'),
        ),
      ].wrap()!,
      const Text(
        "Sheet↓",
        textAlign: TextAlign.center,
      ),
      <Widget>[
        GradientButton.normal(
          () {
            showBottomSheet(
              context: context,
              builder: (context) {
                return randomWidget();
              },
            );
          },
          child: const Text("Sheet1"),
        ),
        GradientButton.normal(
          () {
            showBottomSheet(
              context: context,
              elevation: 12,
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(randomText(10)),
                );
              },
            );
          },
          child: const Text("Sheet2"),
        ),
        GradientButton.normal(
          () {
            showBottomSheet(
              context: context,
              elevation: 12,
              backgroundColor: randomColor(),
              builder: (context) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Text(randomText(10)),
                );
              },
            );
          },
          child: const Text("Sheet3"),
        ),
        GradientButton.normal(
          () {
            showBottomSheet(
              context: context,
              elevation: 12,
              constraints: const BoxConstraints.expand(),
              backgroundColor: randomColor(),
              builder: (context) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Text(randomText(10)),
                );
              },
            );
          },
          child: const Text("Sheet4"),
        ),
        GradientButton.normal(
          () {
            context.push(
              ModalBottomSheetRoute(
                builder: (context) {
                  return BottomSheet(
                      onClosing: onClosing,
                      builder: (context) {
                        return Container(
                          width: double.infinity,
                          height: double.infinity,
                          padding: const EdgeInsets.all(16),
                          child: Text(randomText(10)),
                        );
                      });
                },
                showDragHandle: true,
                isScrollControlled: true,
                useSafeArea: true,
              ),
            );
          },
          child: const Text("Sheet5"),
        ),
        GradientButton.normal(
          () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return randomWidget();
              },
            );
          },
          child: const Text("SheetModal1"),
        ),
        GradientButton.normal(
          () {
            showModalBottomSheet(
              context: context,
              elevation: 12,
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(randomText(10)),
                );
              },
            );
          },
          child: const Text("SheetModal2"),
        ),
        GradientButton.normal(
          () {
            showModalBottomSheet(
              context: context,
              elevation: 12,
              backgroundColor: randomColor(),
              builder: (context) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Text(randomText(10)),
                );
              },
            );
          },
          child: const Text("SheetModal3"),
        ),
        GradientButton.normal(
          () {
            showModalBottomSheet(
              context: context,
              anchorPoint: Offset.zero,
              constraints: const BoxConstraints.expand(),
              backgroundColor: randomColor(),
              builder: (context) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Text(randomText(10)),
                );
              },
            );
          },
          child: const Text("SheetModal4"),
        ),
        GradientButton.normal(
          () {
            showCupertinoModalPopup(
              context: context,
              anchorPoint: Offset.zero,
              builder: (context) {
                return CupertinoActionSheet(
                  title: const Text('Title'),
                  message: const Text('Message'),
                  actions: <CupertinoActionSheetAction>[
                    CupertinoActionSheetAction(
                      /// This parameter indicates the action would be a default
                      /// default behavior, turns the action's text to bold text.
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Default Action'),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Action'),
                    ),
                    CupertinoActionSheetAction(
                      /// This parameter indicates the action would perform
                      /// a destructive action such as delete or exit and turns
                      /// the action's text color to red.
                      isDestructiveAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Destructive Action'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text("CupertinoModalPopup1"),
        ),
      ].wrap()!,
      const Text(
        "Menu↓",
        textAlign: TextAlign.center,
      ),
      <Widget>[
        PopupMenuButton<String>(
          itemBuilder: buildMenu,
          onSelected: (value) {
            toast(Text(value));
          },
          child: FilledButton(
            onPressed: onPressed,
            child: const Text(
              'menu~',
              textAlign: TextAlign.center,
            ),
          ).ignorePointer(),
        ),
        PopupMenuButton<String>(
          itemBuilder: buildMenu,
          onSelected: (value) {
            toast(Text(value));
          },
          child: const Text(
            'menu~2',
            textAlign: TextAlign.center,
          ).paddingAll(8),
        ),
        MenuAnchor(
          menuChildren: buildMenu2(context),
          builder: (context, controller, child) {
            return GradientButton.normal(() {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
                child: const Text(
                  'MenuAnchor~',
                  textAlign: TextAlign.center,
                ).paddingAll(8));
          },
        ),
        PopupMenuButton<String>(
          itemBuilder: (context) {
            return <PopupMenuEntry<String>>[
              PopupMenuItem(
                value: randomText(),
                child: randomWidget(),
              ),
              PopupMenuItem(
                value: randomText(),
                child: randomWidget(),
              ),
              PopupMenuItem(
                value: randomText(),
                child: randomWidget(),
              ),
              PopupMenuItem(
                value: randomText(),
                child: randomWidget(),
              ),
              PopupMenuItem(
                value: randomText(),
                child: randomWidget(),
              ),
              PopupMenuItem(
                value: randomText(),
                child: randomWidget(),
              ),
            ];
          },
          onSelected: (value) {
            toast(Text(value));
          },
        )
      ].wrap()!,
      "Custom↓".text(textAlign: TextAlign.center),
      [
        GradientButton.normal(
          () {
            context.showWidgetDialog(
              IosNormalDialog(
                title: "提示",
                message: "恢复之前的工程?" * 3,
                cancel: "取消",
                confirm: "确定",
                onConfirmTap: (_) async {
                  return false;
                },
              ),
            );
          },
          child: "IosNormalDialog".text(),
        ),
        GradientButton.normal(
          () {
            context.showWidgetDialog(
              AndroidNormalDialog(
                title: "提示",
                message: "恢复之前的工程?" * 3,
                cancel: "取消",
                neutral: "中立",
                confirm: "确定",
                /*cancel: null,
                neutral: null,
                confirm: null,*/
                onConfirmTap: (_) async {
                  return false;
                },
              ),
            );
          },
          child: "AndroidNormalDialog".text(),
        ),
        GradientButton.normal(
          () {
            context.showWidgetDialog(
              MessageDialog(
                title: "提示",
                message: "恢复之前的工程?" * 3,
                confirm: "确定",
                /*cancel: null,
                neutral: null,
                confirm: null,*/
                onConfirmTap: (_) async {
                  return false;
                },
              ),
            );
          },
          child: "MessageDialog".text(),
        ),
        GradientButton.normal(
          () {
            context.showWidgetDialog(SingleInputDialog(title: "提示"));
          },
          child: "SingleInputDialog-center".text(),
        ),
        GradientButton.normal(
          () {
            context.showWidgetDialog(SingleInputDialog(
              title: "提示",
              hintText: "请输入...",
              alignment: Alignment.bottomCenter,
              inputConfig: TextFieldConfig(autofocus: true),
            ));
          },
          child: "SingleInputDialog-bottom".text(),
        ),
      ].wrap()!,
      "Loading↓".text(textAlign: TextAlign.center),
      [
        GradientButton.normal(
          () async {
            //循环5s
            final loadingInfoNotifier = LoadingValueNotifier(
                LoadingInfo(progress: 0.0, message: "加载中..."));
            showLoading(loadingInfoNotifier: loadingInfoNotifier);
            await for (var i
                in Stream.periodic(const Duration(seconds: 1), (i) => i)) {
              loadingInfoNotifier.value = LoadingInfo(
                progress: i / 10,
                message: "加载中...${i / 10 * 100}%",
              );
              if (i >= 10) {
                break;
              }
            }
            hideLoading();
          },
          child: "showLoading".text(),
        ),
        GradientButton.normal(
          () async {
            //循环5s
            final loadingInfoNotifier =
                LoadingValueNotifier(LoadingInfo(builder: (context) {
              return "加载中...0%".text();
            }));
            toast(null, loadingInfoNotifier: loadingInfoNotifier);
            await for (var i
                in Stream.periodic(const Duration(seconds: 1), (i) => i)) {
              loadingInfoNotifier.value = LoadingInfo(builder: (context) {
                return "加载中...${(i / 10 * 100).round()}%".text();
              });
              if (i >= 10) {
                break;
              }
            }
          },
          child: "toastLoading".text(),
        ),
        GradientButton.normal(
          () async {
            //循环5s
            final loadingInfoNotifier =
                LoadingValueNotifier(LoadingInfo(builder: (context) {
              return "请稍等...".text();
            }));
            toast(null,
                loadingInfoNotifier: loadingInfoNotifier,
                position: OverlayPosition.top);
            await for (var i
                in Stream.periodic(const Duration(seconds: 1), (i) => i)) {
              loadingInfoNotifier.value = LoadingInfo(builder: (context) {
                return [
                  RotateAnimation(Icon(Icons.lens_blur_outlined)),
                  "加载中...${(i / 10 * 100).round()}%".text(),
                ].row(mainAxisSize: MainAxisSize.min)!;
              });
              if (i >= 10) {
                break;
              }
            }
          },
          child: "toastLoading-top".text(),
        ),
      ].wrap()!,
    ];
  }
}
