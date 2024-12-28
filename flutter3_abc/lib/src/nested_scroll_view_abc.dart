part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/08/22
///
/// [SliverOverlapAbsorber]
/// [SliverOverlapInjector]
/// [SliverOverlapAbsorberHandle]
class NestedScrollViewAbc extends StatefulWidget {
  const NestedScrollViewAbc({super.key});

  @override
  State<NestedScrollViewAbc> createState() => _NestedScrollViewAbcState();
}

const _height = 50.0;

class _NestedScrollViewAbcState extends State<NestedScrollViewAbc> {
  Widget _buildSliverBox() => SliverToBoxAdapter(
        child: const Text('SliverToBoxAdapter').container(
          color: Colors.redAccent,
          padding: const EdgeInsets.all(kX),
          alignment: Alignment.centerLeft,
          height: _height,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          MeHeaderSliverWidget(
            children: [
              Stack(children: [
                GradientButton(
                        onTap: () {
                          toastBlur(text: "左上");
                        },
                        child: "左上".text())
                    .position(left: 0, top: screenStatusBar),
                GradientButton(
                        onTap: () {
                          toastBlur(text: "左下");
                        },
                        child: "左下".text())
                    .position(left: 0, bottom: 0),
                GradientButton(
                        onTap: () {
                          toastBlur(text: "右上");
                        },
                        child: "右上".text())
                    .position(right: 0, top: screenStatusBar),
                GradientButton(
                        onTap: () {
                          toastBlur(text: "右下");
                        },
                        child: "右下".text())
                    .position(right: 0, bottom: 0),
              ]),
              const InkButton(Icon(Icons.headset_sharp)),
            ],
          ),
          // SliverAppBar(
          //   title: Text('NestedScrollViewAbc[$innerBoxIsScrolled]'),
          // ),
          // SliverAppBar(
          //   title: Text('...[$innerBoxIsScrolled]'),
          // ),
          // const SliverLogWidget(),
          // const SliverLogWidget(),
          //_buildSliverBox(),
        ];
      },
      body: CustomScrollView(
        slivers: [
          //const SliverLogWidget(),
          //const SliverLogWidget(),
          //_buildSliverBox(),
          SliverList.builder(
              itemBuilder: (context, index) {
                //l.d('build->$index');
                return Text('$index')
                    .container(
                      padding: const EdgeInsets.all(kX),
                      alignment: Alignment.centerLeft,
                      height: _height,
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
              itemCount: 100),
        ],
      ),
    ).scaffold(backgroundColor: globalTheme.surfaceBgColor);
  }
}

class SliverLogWidget extends LeafRenderObjectWidget {
  const SliverLogWidget({super.key});

  @override
  RenderObject createRenderObject(BuildContext context) => RenderSliverLog();
}

/// [RenderSliverOverlapAbsorber]
/// [RenderSliverOverlapInjector]
/// [SliverPaintRender]
/// [RenderSliverToBoxAdapter]
class RenderSliverLog extends RenderSliver {
  RenderSliverLog();

  /// [BoxParentData]
  /// [SliverLogicalParentData]
  /// [SliverPhysicalParentData]
  @override
  void setupParentData(RenderObject child) {
    debugger();
    if (child.parentData is! SliverPhysicalParentData) {
      child.parentData = SliverPhysicalParentData();
    }
  }

  @override
  double childMainAxisPosition(RenderBox child) {
    debugger();
    return -constraints.scrollOffset;
  }

  @override
  void applyPaintTransform(RenderObject child, Matrix4 transform) {
    debugger();
    final SliverPhysicalParentData childParentData =
        child.parentData! as SliverPhysicalParentData;
    childParentData.applyPaintTransform(transform);
  }

  @override
  void performLayout() {
    final constraints = this.constraints;
    //l.v(constraints);

    /*geometry = SliverGeometry(
      */ /*paintOrigin: -constraints.scrollOffset,*/ /*
      paintExtent: _height,
      cacheExtent: _height,
      maxPaintExtent: _height,
      scrollExtent: _height,
      layoutExtent: _height,
      hasVisualOverflow: false,
      */ /*maxScrollObstructionExtent: 130,*/ /*
    );*/

    //一般布局使用
    /*geometry = SliverGeometry(
      paintOrigin: -constraints.scrollOffset,
      paintExtent: _height,
      maxPaintExtent: _height,
      layoutExtent: _height,
    );*/

    final double childExtent = switch (constraints.axis) {
      Axis.horizontal => _height,
      Axis.vertical => _height,
    };
    final double paintedChildSize =
        calculatePaintOffset(constraints, from: 0.0, to: childExtent);
    final double cacheExtent =
        calculateCacheOffset(constraints, from: 0.0, to: childExtent);

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    //debugger();
    //l.d("paintedChildSize->$paintedChildSize");
    geometry = SliverGeometry(
      scrollExtent: childExtent,
      paintExtent: childExtent,
      cacheExtent: cacheExtent,
      maxPaintExtent: childExtent,
      hitTestExtent: paintedChildSize,
      hasVisualOverflow: childExtent > constraints.remainingPaintExtent ||
          constraints.scrollOffset > 0.0,
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    //debugger();
    //l.d("offset:$offset scrollOffset:${constraints.scrollOffset} paintBounds:$paintBounds");
    final bounds =
        paintBounds + offset /* + Offset(0.0, -constraints.scrollOffset)*/;
    context.canvas.drawRect(
      bounds,
      Paint()..color = Colors.blueAccent,
    );
    context.canvas.drawText(
        "offset:$offset scrollOffset:${constraints.scrollOffset}",
        bounds: bounds,
        alignment: Alignment.center);
  }
}

class MeHeaderSliverWidget extends MultiChildRenderObjectWidget {
  const MeHeaderSliverWidget({
    super.key,
    super.children,
  });

  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderMeHeaderSliver();
}

/// [RenderSliverMultiBoxAdaptor]
/// [RenderMultiSliver]
/// [RenderSliverStack]
class RenderMeHeaderSliver extends RenderSliver
    with
        ContainerRenderObjectMixin<RenderBox,
            ContainerParentDataMixin<RenderBox>>,
        RenderSliverHelpers {
  final childExtent = 300.0;
  final minChildExtent = 100.0;

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! MeHeaderParentData) {
      child.parentData = MeHeaderParentData();
    }
  }

  @override
  void performLayout() {
    childCount;
    //debugger();

    for (final child in childrenIterable) {
      child.layout(constraints.asBoxConstraints(maxExtent: childExtent),
          parentUsesSize: true);
      child.size;
      child.renderSize;
      //debugger();
    }

    final double paintedChildSize =
        calculatePaintOffset(constraints, from: 0.0, to: childExtent);
    final double cacheExtent =
        calculateCacheOffset(constraints, from: 0.0, to: childExtent);

    geometry = SliverGeometry(
      scrollExtent: childExtent - minChildExtent,
      paintExtent: paintedChildSize.maxOf(minChildExtent),
      cacheExtent: childExtent,
      maxPaintExtent: childExtent,
      hasVisualOverflow: true,
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final bounds =
        paintBounds + offset /* + Offset(0.0, -constraints.scrollOffset)*/;
    context.canvas.drawRect(
      bounds,
      Paint()..color = Colors.blueAccent,
    );
    context.canvas.drawText(
        "[$childCount] ${(constraints.scrollOffset / (childExtent - minChildExtent)).toDigits()}\noffset:$offset scrollOffset:${constraints.scrollOffset.toDigits()}",
        textAlign: TextAlign.center,
        bounds: bounds,
        alignment: Alignment.center);

    context.canvas.withClipRect(bounds, () {
      for (final child in childrenIterable) {
        context.paintChild(child, offset);
      }
    });
  }

  //--

  /// [BaseTapGestureRecognizer.handleTapDown]
  @override
  void applyPaintTransform(covariant RenderObject child, Matrix4 transform) {
    //debugger();
    final parentData = child.parentData as MeHeaderParentData;
    //transform.translate(parentData.paintOffset.dx, parentData.paintOffset.dy);
  }

  /// [hitTestChildren]驱动
  @override
  double childMainAxisPosition(covariant RenderObject child) {
    //debugger();
    final childParentData = child.parentData as MeHeaderParentData;
    return 0;
  }

  /// [hitTestChildren]驱动
  @override
  double childCrossAxisPosition(covariant RenderObject child) {
    //debugger();
    final childParentData = child.parentData as MeHeaderParentData;
    return 0;
  }

  /// [hitTestBoxChild]
  @override
  bool hitTestChildren(
    SliverHitTestResult result, {
    required double mainAxisPosition,
    required double crossAxisPosition,
  }) {
    final boxResult = BoxHitTestResult.wrap(result);
    for (final child in childrenIterable) {
      final hit = hitTestBoxChild(boxResult, child,
          mainAxisPosition: mainAxisPosition,
          crossAxisPosition: crossAxisPosition);
      if (hit) return true;
    }
    return false;
  }
}

class MeHeaderParentData extends ContainerBoxParentData<RenderBox> {}
