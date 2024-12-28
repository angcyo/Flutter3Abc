part of '../flutter3_abc.dart';

///
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2024/12/27
///
class EventAbc extends StatefulWidget {
  const EventAbc({super.key});

  @override
  State<EventAbc> createState() => _EventAbcState();
}

class _EventAbcState extends State<EventAbc> with KeyEventMixin {
  PointerEvent? mouseEvent;
  PointerEvent? pointerEvent;
  KeyEvent? keyEvent;

  @override
  bool onKeyEventHandleMixin(KeyEvent event) {
    keyEvent = event;
    updateState();
    return super.onKeyEventHandleMixin(event);
  }

  @override
  Widget build(BuildContext context) {
    return "${_buildPointerEventText(mouseEvent)}\n\n${_buildPointerEventText(pointerEvent)}\n\n$keyEvent\n\n${_buildHardwareKeyboardText(context)}"
        .text(textAlign: TextAlign.center)
        .center()
        .mouse(
          onEnter: (event) {
            //debugger();
            l.d(event);
            mouseEvent = event;
            updateState();
          },
          onExit: (event) {
            l.d(event);
            mouseEvent = event;
            updateState();
          },
          onHover: (event) {
            l.d(event);
            mouseEvent = event;
            updateState();
          },
          cursor: SystemMouseCursors.wait,
        )
        .pointerListener((event) {
      pointerEvent = event;
      updateState();
    });
  }

  String _buildPointerEventText(PointerEvent? event) {
    return "${event.runtimeType} ${event?.kind} ${event?.buttons} ${event?.pressure} ${event?.size}\n position:${event?.position} localPosition:${event?.localPosition}";
  }

  /// 按键当前的状态
  /// [HardwareKeyboard]
  String _buildHardwareKeyboardText(BuildContext context) {
    final instance = HardwareKeyboard.instance;
    return "${instance.physicalKeysPressed.length} ${instance.physicalKeysPressed}\n "
        "${instance.logicalKeysPressed.length} ${instance.logicalKeysPressed}";
  }
}
