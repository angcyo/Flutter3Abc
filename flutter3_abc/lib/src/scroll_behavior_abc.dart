part of '../flutter3_abc.dart';

///
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2024/04/05
///
/// [ScrollPhysics]
/// [BouncingScrollPhysics]
class ScrollBehaviorAbc extends StatefulWidget {
  const ScrollBehaviorAbc({super.key});

  @override
  State<ScrollBehaviorAbc> createState() => _ScrollBehaviorAbcState();
}

class _ScrollBehaviorAbcState extends State<ScrollBehaviorAbc>
    with BaseAbcStateMixin, AbcWidgetMixin {
  @override
  bool get useScroll => false;

  @override
  List<Widget> buildBodyList(BuildContext context) {
    const height = 160.0;
    return [
      "ScrollBehavior↓".text().paddingAll(kX).click(() {
        updateState();
      }),
      ScrollConfiguration(
        behavior: _CustomScrollBehavior(),
        child: buildListView(),
      ).size(height: height),
      "PullBackWidget-Box↓".text().paddingAll(kX),
      PullBackWidget(
        child: buildBox(),
        canPullBackAction: () async {
          return false;
        },
        onPullBack: (_) {
          toastInfo("onPullBack");
        },
      ).size(height: height),
      "PullBackWidget-Scroll↓".text().paddingAll(kX),
      PullBackWidget(
        onPullBack: (_) {
          toastInfo("onPullBack");
        },
        child: buildCustomScrollView(),
      ).size(height: height),
    ];
  }
}

class _CustomScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return _CustomScrollPhysics();
  }
}

class _CustomScrollPhysics extends BouncingScrollPhysics {
  const _CustomScrollPhysics([ScrollPhysics? parent]) : super(parent: parent);

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    l.w("边界:$value ");
    return super.applyBoundaryConditions(position, value);
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    l.i("滚动:$offset ");
    //return 0.0;
    return super.applyPhysicsToUserOffset(position, offset);
  }

  @override
  BouncingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    l.d("$ancestor");
    return super.applyTo(ancestor);
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    l.d('createBallisticSimulation:$velocity');
    //debugger();
    return super.createBallisticSimulation(position, velocity);
  }

  @override
  ScrollPhysics? buildParent(ScrollPhysics? ancestor) {
    l.d("$ancestor");
    return _CustomScrollPhysics(buildParent(ancestor));
  }
}
