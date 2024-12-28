part of '../flutter3_abc.dart';

///
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2024/04/04
///
class NotificationListenerAbc extends StatefulWidget {
  const NotificationListenerAbc({super.key});

  @override
  State<NotificationListenerAbc> createState() =>
      _NotificationListenerAbcState();
}

class _NotificationListenerAbcState extends State<NotificationListenerAbc>
    with BaseAbcStateMixin, AbcWidgetMixin {
  ScrollNotification? _customScrollNotification;
  ScrollNotification? _listViewNotification;
  ScrollNotification? _singleScrollNotification;

  @override
  bool get useScroll => false;

  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      NotificationListener<ScrollNotification>(
        onNotification: _handleCustomScrollNotification,
        child: [
          "CustomScrollView.ScrollNotification↓".text(),
          CustomScrollView(
            physics: scrollPhysics,
            slivers: buildSliverScrollBodyList(),
          ).size(height: 100.0),
          _customScrollNotification?.toString().text(),
        ].column(mainAxisSize: MainAxisSize.min)!,
      ),
      NotificationListener<ScrollNotification>(
        onNotification: _handleListViewNotification,
        child: [
          "ListView.ScrollNotification↓".text(),
          ListView(
            physics: scrollPhysics,
            children: buildScrollBodyList(),
          ).size(height: 100.0),
          _listViewNotification?.toString().text(),
        ].column(mainAxisSize: MainAxisSize.min)!,
      ),
      NotificationListener<ScrollNotification>(
        onNotification: _handleSingleScrollNotification,
        child: [
          "SingleChildScroll.ScrollNotification↓".text(),
          SingleChildScrollView(
            physics: scrollPhysics,
            child: buildScrollBodyList().column(),
          ).size(height: 100.0),
          _singleScrollNotification?.toString().text(),
        ].column(mainAxisSize: MainAxisSize.min)!,
      ),
    ];
  }

  bool _handleCustomScrollNotification(ScrollNotification notification) {
    _customScrollNotification = notification;
    /*if (notification is ScrollStartNotification) {
      print('Scroll Start');
    } else if (notification is ScrollUpdateNotification) {
      print('Scroll Update');
    } else if (notification is ScrollEndNotification) {
      print('Scroll End');
    }*/
    l.d(notification);
    updateState();
    return false;
  }

  bool _handleListViewNotification(ScrollNotification notification) {
    _listViewNotification = notification;
    /*if (notification is ScrollStartNotification) {
      print('Scroll Start');
    } else if (notification is ScrollUpdateNotification) {
      print('Scroll Update');
    } else if (notification is ScrollEndNotification) {
      print('Scroll End');
    }*/
    l.d(notification);
    updateState();
    return false;
  }

  bool _handleSingleScrollNotification(ScrollNotification notification) {
    _singleScrollNotification = notification;
    /*if (notification is ScrollStartNotification) {
      print('Scroll Start');
    } else if (notification is ScrollUpdateNotification) {
      print('Scroll Update');
    } else if (notification is ScrollEndNotification) {
      print('Scroll End');
    }*/
    l.d(notification);
    updateState();
    return false;
  }
}
