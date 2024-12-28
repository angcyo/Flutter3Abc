part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/08/24
///
class ScrollListenerAbc extends StatefulWidget {
  const ScrollListenerAbc({super.key});

  @override
  State<ScrollListenerAbc> createState() => _ScrollListenerAbcState();
}

class _ScrollListenerAbcState extends State<ScrollListenerAbc> {
  final UpdateSignalNotifier<Notification?> _notificationSignalNotifier =
      UpdateSignalNotifier(null);

  final UpdateSignalNotifier<Notification?> _scrollSignalNotifier =
      UpdateSignalNotifier(null);

  final UpdateSignalNotifier<Notification?> _overscrollIndicatorSignalNotifier =
      UpdateSignalNotifier(null);

  @override
  Widget build(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return ScrollOverlayHintWidget(
        child: CustomScrollView(
      slivers: [
        SliverList.builder(
            itemBuilder: (context, index) {
              //l.d('build->$index');
              return Text('$index')
                  .container(
                    padding: const EdgeInsets.all(kX),
                    alignment: Alignment.centerLeft,
                    height: 50,
                  )
                  .ink(
                    () {},
                    splashColor: Colors.redAccent,
                    backgroundColor: Color.fromARGB(
                      0xff,
                      0xff - index * 10,
                      0xff - index * 10,
                      0xff - index * 10,
                    ),
                  );
            },
            itemCount: 20)
      ],
    )).scaffold(backgroundColor: globalTheme.themeWhiteColor);
    //return _buildNotification(context);
  }

  Widget _buildNotification(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return NotificationListener<Notification>(
      onNotification: (notification) {
        _notificationSignalNotifier.value = notification;
        return false;
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          _scrollSignalNotifier.value = notification;
          l.d("方向->${notification.metrics.axis} "
              "最大滚动距离->${notification.metrics.maxScrollExtent} "
              "当前滚动距离->${notification.metrics.pixels} "
              "剩余距离->${notification.metrics.maxScrollExtent - notification.metrics.pixels}");
          return false;
        },
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            _overscrollIndicatorSignalNotifier.value = notification;
            l.d("OverscrollIndicatorNotification->${notification.paintOffset}");
            return false;
          },
          child: CustomScrollView(
            slivers: [
              SliverList.builder(
                  itemBuilder: (context, index) {
                    //l.d('build->$index');
                    return Text('$index')
                        .container(
                          padding: const EdgeInsets.all(kX),
                          alignment: Alignment.centerLeft,
                          height: 50,
                        )
                        .ink(
                          () {},
                          splashColor: Colors.redAccent,
                          backgroundColor: Color.fromARGB(
                            0xff,
                            0xff - index * 10,
                            0xff - index * 10,
                            0xff - index * 10,
                          ),
                        );
                  },
                  itemCount: 20)
            ],
          ),
        ),
      ),
    )
        .stackOf(
            rebuildList([
              _notificationSignalNotifier,
              _scrollSignalNotifier,
              _overscrollIndicatorSignalNotifier
            ], (context, notification) {
              return ("1-> ${_notificationSignalNotifier.value?.runtimeType}\n${_notificationSignalNotifier.value}\n\n"
                      "2-> ${_scrollSignalNotifier.value?.runtimeType}\n${_scrollSignalNotifier.value}\n\n"
                      "3-> ${_overscrollIndicatorSignalNotifier.value?.runtimeType}\n${_overscrollIndicatorSignalNotifier.value}")
                  .text(textColor: Colors.redAccent)
                  .paddingAll(kX)
                  .safeArea();
            }),
            alignment: Alignment.topCenter)
        .scaffold(backgroundColor: globalTheme.themeWhiteColor);
  }
}
