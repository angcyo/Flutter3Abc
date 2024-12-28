part of '../../flutter3_abc.dart';

///
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2024/04/04
///
class DismissibleAbc extends StatefulWidget {
  const DismissibleAbc({super.key});

  @override
  State<DismissibleAbc> createState() => _DismissibleAbcState();
}

class _DismissibleAbcState extends State<DismissibleAbc>
    with BaseAbcStateMixin, AbcWidgetMixin {
  @override
  bool get useScroll => false;

  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      "Dismissible↓".text().center().paddingAll(kX).click(() {
        updateState();
      }),
      Dismissible(
        key: ValueKey($uuid),
        crossAxisEndOffset: 0.8,
        onDismissed: (direction) {
          l.d('onDismissed $direction');
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerLeft,
          child: "删除".text(),
        ),
        secondaryBackground: Container(
          color: Colors.green,
          alignment: Alignment.centerRight,
          child: "收藏".text(),
        ),
        child: Container(
          color: randomColor(),
          height: 80,
          alignment: Alignment.center,
          child: "horizontal 滑动删除".text(),
        ),
      ),
      Dismissible(
        key: ValueKey($uuid),
        direction: DismissDirection.down,
        onDismissed: (direction) {
          l.d('onDismissed $direction');
        },
        child: Container(
          color: randomColor(),
          height: 80,
          alignment: Alignment.center,
          child: "下滑删除".text(),
        ),
      ),
      Dismissible(
        key: ValueKey($uuid),
        direction: DismissDirection.down,
        behavior: HitTestBehavior.translucent,
        onDismissed: (direction) {
          l.d('onDismissed $direction');
        },
        child: Container(
          color: randomColor(),
          alignment: Alignment.center,
          child: CustomScrollView(
            physics: scrollPhysics,
            slivers: buildSliverScrollBodyList(),
          ).size(height: 200.0),
        ),
      ),
      "Slidable↓".text().center().paddingAll(kX),
      Slidable(
        key: ValueKey($uuid),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.4,
          dragDismissible: true,
          // A pane can dismiss the Slidable.
          dismissible: DismissiblePane(
              dismissThreshold: 0.1,
              onDismissed: () {
                l.d('onDismissed');
              }),
          children: const [],
        ),
        child: Container(
          color: randomColor(),
          height: 80,
          alignment: Alignment.center,
          child: "Slidable".text(),
        ),
      ),
      Slidable(
        key: ValueKey($uuid),
        direction: Axis.vertical,
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.4,
          dragDismissible: true,
          // A pane can dismiss the Slidable.
          dismissible: DismissiblePane(
              dismissThreshold: 0.3,
              onDismissed: () {
                l.d('onDismissed');
              }),
          children: const [],
        ),
        child: Container(
          color: randomColor(),
          height: 80,
          alignment: Alignment.center,
          child: CustomScrollView(
            physics: scrollPhysics,
            slivers: buildSliverScrollBodyList(),
          ),
        ),
      ),
      "...end↓".text().center().paddingAll(kX),
    ];
  }
}
