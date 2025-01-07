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
    return "${_buildPointerEventText("鼠标事件", mouseEvent)}\n\n${_buildPointerEventText("指针事件", pointerEvent)}\n\n$keyEvent\n\n${_buildHardwareKeyboardText(context)}\n\n"
            "isControlPressed->${HardwareKeyboard.instance.isControlPressed}\nisAltPressed->${HardwareKeyboard.instance.isAltPressed}\n"
            "isMetaPressed->${HardwareKeyboard.instance.isMetaPressed}\nisShiftPressed->${HardwareKeyboard.instance.isShiftPressed}"
        .text(textAlign: TextAlign.center)
        .center()
        .mouse(
          onEnter: (event) {
            //debugger();
            l.d("mouse->$event");
            mouseEvent = event;
            updateState();
          },
          onExit: (event) {
            l.d("mouse->$event");
            mouseEvent = event;
            updateState();
          },
          onHover: (event) {
            l.d("mouse->$event");
            mouseEvent = event;
            updateState();
          },
          cursor: isSpacePressed
              ? SystemMouseCursors.help
              : SystemMouseCursors.progress,
        )
        .pointerListener((event) {
      l.i("pointer->$event");
      pointerEvent = event;
      updateState();
    });
  }

  String _buildPointerEventText(String type, PointerEvent? event) {
    return stringBuilder((builder) {
      builder.appendLine(
          "$type->${event.runtimeType} ${event?.kind} ${event?.buttons} ${event?.pressure} ${event?.size}");
      builder.appendLine(
          "position:${event?.position} localPosition:${event?.localPosition}");
      if (event is PointerPanZoomUpdateEvent) {
        builder.appendLine(
            "pan:${event.pan} localPan:${event.localPan} panDelta:${event.panDelta} localPanDelta:${event.localPanDelta} scale:${event.scale} rotation:${event.rotation}");
      }
    });
  }

  /// 按键当前的状态
  /// [HardwareKeyboard]
  String _buildHardwareKeyboardText(BuildContext context) {
    final instance = HardwareKeyboard.instance;
    return "${instance.physicalKeysPressed.length} ${instance.physicalKeysPressed}\n "
        "${instance.logicalKeysPressed.length} ${instance.logicalKeysPressed}";
  }
}
