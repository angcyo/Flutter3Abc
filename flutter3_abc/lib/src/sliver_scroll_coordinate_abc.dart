part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/08/22
///
class SliverScrollCoordinateAbc extends StatefulWidget {
  const SliverScrollCoordinateAbc({super.key});

  @override
  State<SliverScrollCoordinateAbc> createState() =>
      _SliverScrollCoordinateAbcState();
}

class _SliverScrollCoordinateAbcState extends State<SliverScrollCoordinateAbc>
    with TickerProviderStateMixin, TabLayoutMixin {
  final ScrollController controller = ScrollController();

  final ScrollBehavior scrollBehavior =
      ERScrollBehavior(AlwaysScrollableScrollPhysics());

  /// 之前已经滚动的距离
  double precedingScrollExtent = 0;

  @override
  Widget build(BuildContext context) {
    //return _buildRefreshDemo(context);
    //return _buildScrollDemo(context);
    //return _buildPinnedDemo(context);
    return _buildRefreshDemo(context, child: _buildScrollDemo(context));
  }

  Widget _buildPinnedDemo(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverAppBar(
          title: "title1".text(),
        ),
        SliverAppBar(
          title: "title2".text(),
          floating: true,
          pinned: true,
        ),
        _buildCoordinateLayout(context),
        SliverPersistentHeader(
          pinned: true,
          delegate: SingleSliverPersistentHeaderDelegate(childBuilder: (
            BuildContext context,
            double shrinkOffset,
            bool overlapsContent,
          ) {
            return GradientButton.normal(() {},
                    child: "title3($shrinkOffset)($overlapsContent)".text())
                .container(color: Colors.redAccent, height: 50);
          }),
        ),
        MySliverPersistentHeaderWidget(
          child: GradientButton.normal(() {}, child: "title4".text())
              .container(color: Colors.redAccent, height: 50),
        ),
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
    ).scaffold(backgroundColor: globalTheme.surfaceBgColor);
  }

  Widget _buildScrollDemo(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return CustomScrollView(
      controller: controller,
      /*physics: kScrollPhysics,*/
      slivers: [
        // SliverAppBar(
        //   title: "title1".text(),
        // ),
        // SliverAppBar(
        //   title: "title2".text(),
        //   floating: true,
        //   pinned: true,
        // ),
        _buildCoordinateLayout(context),
        // SliverAppBar(
        //   title: "title".text(),
        //   floating: true,
        //   pinned: true,
        // ),
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
    ).scaffold(backgroundColor: globalTheme.surfaceBgColor);
  }

  Widget _buildRefreshDemo(
    BuildContext context, {
    Widget? child,
  }) {
    final globalTheme = GlobalTheme.of(context);

    return EasyRefresh(
            /*notificationPredicate: (notification) {
          return notification.depth == 0;
        },*/
            /*onRefresh: () async {
          return Future.delayed(2.seconds);
        },*/
            onRefresh: () {
              return Future.delayed(2.seconds);
            },
            // scrollBehaviorBuilder: (parent) {
            //   //debugger();
            //   return scrollBehavior;
            // },
            child: child ??
                NestedScrollView(
                  controller: controller,
                  scrollBehavior: scrollBehavior,
                  /*physics: const BouncingScrollPhysics(),*/
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    final handle =
                        NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context);
                    l.d("handle->$handle");
                    return <Widget>[
                      SliverAppBar(
                        title: "title".text(),
                      ),
                      _buildCoordinateLayout(context),
                    ];
                  },
                  body: CustomScrollView(
                    slivers: [
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
                ))
        .scaffold(backgroundColor: globalTheme.surfaceBgColor);
  }

  Widget _buildCoordinateLayout(BuildContext context) {
    const avatarSize = 50.0;
    const avatarMinSize = 30.0;
    final avatarRect =
        Rect.fromLTWH(10, screenStatusBar, avatarSize, avatarSize);
    return SliverScrollCoordinateLayoutWidget(
      minExtent: 140,
      maxExtent: 400,
      children: [
        DecoratedBox(
            decoration: BoxDecoration(
          gradient: linearGradient(["#fce14a".toColor(), "#fccc39".toColor()]),
        )).matchParent().sliverCoordinateLayoutParentData(
          onCoordinateChildAction: (constraints, parentData, scrollProgress) {
            parentData.top = constraints.overlap.minOf(0);
            parentData.bottom = 0;
            return true;
          },
        ),
        const DecoratedBox(
                decoration: BoxDecoration(
          color: Colors.white,
        ))
            .matchParentWidth()
            .clipRadius(topRadius: kDefaultBorderRadiusXX)
            .sliverCoordinateLayoutParentData(
              bottom: 0,
              height: 50,
              onCoordinateChildAction:
                  (SliverConstraints constraints, parentData, scrollProgress) {
                precedingScrollExtent = constraints.precedingScrollExtent;
                scrollProgress = scrollProgress.minOf(1);
                parentData.height = 50 + (100 - 50) * scrollProgress;
                return true;
              },
            ),
        buildTabLayout(context, children: [
          "本地".text().padding(kH, kH),
          "我的空间".text().padding(kH, kH),
          "SD卡".text().padding(kH, kH),
        ]).paddingAll(kH).sliverCoordinateLayoutParentData(bottom: 0),
        SliverScrollCoordinateLayoutParentDataWidget(
            left: avatarRect.left,
            top: avatarRect.top,
            minWidth: avatarRect.width,
            minHeight: avatarRect.height,
            onCoordinateChildAction: (constraints, parentData, scrollProgress) {
              //l.d('$scrollProgress');
              scrollProgress = scrollProgress.minOf(1);
              final avatarTargetRect = Rect.fromLTWH(
                  constraints.crossAxisExtent / 2 - avatarMinSize / 2,
                  avatarRect.top,
                  avatarMinSize,
                  avatarMinSize);
              final rect = avatarRect.lerp(avatarTargetRect, scrollProgress);
              parentData
                ..left = rect.left
                ..top = rect.top
                ..minWidth = rect.width
                ..minHeight = rect.height;
              return true;
            },
            child: Container(
              decoration: const BoxDecoration(color: Colors.redAccent),
              child: IconButton(
                  onPressed: () {
                    toastBlur(text: "button...${nowTimeString()}");
                  },
                  icon: const Icon(Icons.supervised_user_circle)),
            ).size(size: 50).clipOval()),
        [
          GradientButton.normal(() {
            controller.scrollToTop(offset: 400 + precedingScrollExtent);
          }, child: "收起".text()),
          GradientButton.normal(() {
            controller.scrollToTop();
          }, child: "展开".text())
        ]
            .row(gap: kX, mainAxisSize: MainAxisSize.min)!
            .sliverCoordinateLayoutParentData(right: 0, top: screenStatusBar),
        [
          GradientButton.normal(() {
            controller.scrollToTop(offset: 400 + precedingScrollExtent);
          }, child: "收起".text()),
          GradientButton.normal(() {
            controller.scrollToTop();
          }, child: "展开".text())
        ]
            .row(gap: kX, mainAxisSize: MainAxisSize.min)!
            .center()
            .matchParentHeight()
        /*.sliverCoordinateLayoutParentData(
              left: 0,
              onCoordinateLayoutAction:
                  (constraints, parentData, scrollProgress) {
                parentData.bottom = 0;
                return true;
              },
            )*/
        ,
      ],
    );
  }
}

class MySliverPersistentHeaderWidget extends SingleChildRenderObjectWidget {
  const MySliverPersistentHeaderWidget({
    super.key,
    super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderMySliverPersistentHeader();
}

/// [RenderSliverPersistentHeader]
/// [RenderSliverPinnedPersistentHeader]
class RenderMySliverPersistentHeader
    extends RenderSliver /*RenderSliverPersistentHeader*/ /*RenderSliverPinnedPersistentHeader*/
    with
        RenderObjectWithChildMixin<RenderBox>,
        RenderSliverHelpers {
  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  double childMainAxisPosition(RenderBox child) => 0.0;

  @override
  void performLayout() {
    //debugger();
    //super.performLayout();
    /*geometry = SliverGeometry(
      scrollExtent: maxExtent,
      paintExtent: maxExtent,
      layoutExtent: maxExtent,
      maxPaintExtent: maxExtent,
    );*/
    final SliverConstraints constraints = this.constraints;
    final double maxExtent = this.maxExtent;
    final bool overlapsContent = constraints.overlap > 0.0;
    layoutChild(constraints.scrollOffset, maxExtent,
        overlapsContent: overlapsContent);
    final double effectiveRemainingPaintExtent =
        max(0, constraints.remainingPaintExtent - constraints.overlap);
    final double layoutExtent = clampDouble(
        maxExtent - constraints.scrollOffset,
        0.0,
        effectiveRemainingPaintExtent);
    final double stretchOffset =
        stretchConfiguration != null ? constraints.overlap.abs() : 0.0;

    final double paintedChildSize =
        calculatePaintOffset(constraints, from: 0.0, to: maxExtent);

    geometry = SliverGeometry(
      scrollExtent: maxExtent,
      paintOrigin: constraints.overlap,
      paintExtent: maxExtent,
      /*paintExtent: math.min(childExtent, effectiveRemainingPaintExtent),*/
      /*paintExtent: paintedChildSize,*/
      /*layoutExtent: layoutExtent,*/
      maxPaintExtent: maxExtent + stretchOffset,
      /*maxScrollObstructionExtent: minExtent,*/
      /*cacheExtent: layoutExtent > 0.0
          ? -constraints.cacheOrigin + layoutExtent
          : layoutExtent,*/
      hasVisualOverflow: false /*true*/,
    );
  }

  //--RenderSliverPersistentHeader--

  @protected
  double get childExtent {
    if (child == null) {
      return 0.0;
    }
    assert(child!.hasSize);
    return switch (constraints.axis) {
      Axis.vertical => child!.size.height,
      Axis.horizontal => child!.size.width,
    };
  }

  late double _lastStretchOffset;

  @protected
  void updateChild(double shrinkOffset, bool overlapsContent) {}

  bool _needsUpdateChild = true;
  double _lastShrinkOffset = 0.0;
  bool _lastOverlapsContent = false;

  /// Defines the parameters used to execute an [AsyncCallback] when a
  /// stretching header over-scrolls.
  ///
  /// If [stretchConfiguration] is null then callback is not triggered.
  ///
  /// See also:
  ///
  ///  * [SliverAppBar], which creates a header that can stretched into an
  ///    overscroll area and trigger a callback function.
  OverScrollHeaderStretchConfiguration? stretchConfiguration;

  void layoutChild(double scrollOffset, double maxExtent,
      {bool overlapsContent = false}) {
    final double shrinkOffset = min(scrollOffset, maxExtent);
    if (_needsUpdateChild ||
        _lastShrinkOffset != shrinkOffset ||
        _lastOverlapsContent != overlapsContent) {
      invokeLayoutCallback<SliverConstraints>((SliverConstraints constraints) {
        assert(constraints == this.constraints);
        updateChild(shrinkOffset, overlapsContent);
      });
      _lastShrinkOffset = shrinkOffset;
      _lastOverlapsContent = overlapsContent;
      _needsUpdateChild = false;
    }
    assert(() {
      if (minExtent <= maxExtent) {
        return true;
      }
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary(
            'The maxExtent for this $runtimeType is less than its minExtent.'),
        DoubleProperty('The specified maxExtent was', maxExtent),
        DoubleProperty('The specified minExtent was', minExtent),
      ]);
    }());
    double stretchOffset = 0.0;
    if (stretchConfiguration != null && constraints.scrollOffset == 0.0) {
      stretchOffset += constraints.overlap.abs();
    }

    child?.layout(
      constraints.asBoxConstraints(
        maxExtent: max(minExtent, maxExtent - shrinkOffset) + stretchOffset,
      ),
      parentUsesSize: true,
    );

    if (stretchConfiguration != null &&
        stretchConfiguration!.onStretchTrigger != null &&
        stretchOffset >= stretchConfiguration!.stretchTriggerOffset &&
        _lastStretchOffset <= stretchConfiguration!.stretchTriggerOffset) {
      stretchConfiguration!.onStretchTrigger!();
    }
    _lastStretchOffset = stretchOffset;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null && geometry!.visible) {
      offset += switch (applyGrowthDirectionToAxisDirection(
          constraints.axisDirection, constraints.growthDirection)) {
        AxisDirection.up => Offset(
            0.0,
            geometry!.paintExtent -
                childMainAxisPosition(child!) -
                childExtent),
        AxisDirection.left => Offset(
            geometry!.paintExtent - childMainAxisPosition(child!) - childExtent,
            0.0),
        AxisDirection.right => Offset(childMainAxisPosition(child!), 0.0),
        AxisDirection.down => Offset(0.0, childMainAxisPosition(child!)),
      };
      context.paintChild(child!, offset);
    }
  }

  @override
  bool hitTest(
    SliverHitTestResult result, {
    required double mainAxisPosition,
    required double crossAxisPosition,
  }) {
    //debugger();
    return super.hitTest(result,
        mainAxisPosition: mainAxisPosition,
        crossAxisPosition: crossAxisPosition);
  }

  @override
  bool hitTestChildren(SliverHitTestResult result,
      {required double mainAxisPosition, required double crossAxisPosition}) {
    assert(geometry!.hitTestExtent > 0.0);
    //debugger();
    if (child != null) {
      return hitTestBoxChild(
        BoxHitTestResult.wrap(result),
        child!,
        mainAxisPosition: mainAxisPosition,
        crossAxisPosition: crossAxisPosition,
      );
    }
    return false;
  }

  @override
  void applyPaintTransform(RenderObject child, Matrix4 transform) {
    assert(child == this.child);
    //debugger();
    applyPaintTransformForBoxChild(child as RenderBox, transform);
  }
}
