part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/11/03
///
/// [RScrollView] 功能测试
class RScrollViewAbc extends StatefulWidget {
  const RScrollViewAbc({super.key});

  @override
  State<RScrollViewAbc> createState() => _RScrollViewAbcState();
}

class _RScrollViewAbcState extends State<RScrollViewAbc>
    with BaseAbcStateMixin {
  @override
  bool get useScroll => false;

  @override
  Widget buildBody(BuildContext context) {
    final littleNormalCount = nextInt(5, 2);

    int crossAxisCount = 0;
    WidgetList children = [];

    // SliverMainAxisGroup 吸顶头部测试
    final groupH1Height = randomHeight(max: 200);
    children.add(
      RItemTile(
        tag: "SliverMainAxisGroup 1",
        headerPinned: true,
        headerFloating: false,
        headerFixedHeight: groupH1Height,
        sliverType: SliverMainAxisGroup,
        childTiles: _buildGridTiles(),
        child: randomWidget(
          text:
              "SliverMainAxisGroup 1 - SliverGrid \n headerPinned ${true.toDC()} headerFloating ${false.toDC()}",
          height: groupH1Height,
        ),
      ),
    );

    final groupH2Height = randomHeight(max: 200);
    children.add(
      RItemTile(
        tag: "SliverMainAxisGroup 2",
        headerPinned: true,
        headerFloating: false,
        headerFixedHeight: groupH2Height,
        sliverType: SliverMainAxisGroup,
        childTiles: _buildListTiles(),
        child: randomWidget(
          text:
              "SliverMainAxisGroup 2 - SliverList \n headerPinned ${true.toDC()} headerFloating ${false.toDC()}",
          height: groupH2Height,
        ),
      ),
    );

    final groupH3Height = randomHeight(max: 200);
    crossAxisCount = nextInt(4, 1);
    children.add(
      RItemTile(
        tag: "SliverMainAxisGroup 3",
        headerPinned: true,
        headerFloating: false,
        headerFixedHeight: groupH3Height,
        sliverType: SliverMainAxisGroup,
        childTiles: [
          RItemTile(
            tag: "MasonryGridView inner",
            sliverType: "MasonryGridView",
            crossAxisCount: crossAxisCount,
            tileWrapShrinkWrap: false,
            childTiles: _buildGridTiles(crossAxisCount, "normal"),
          ),
        ],
        child: randomWidget(
          text:
              "SliverMainAxisGroup 3 - MasonryGridView \n headerPinned ${true.toDC()} headerFloating ${false.toDC()}",
          height: groupH3Height,
        ),
      ),
    );

    children.add(
      RItemTile(
        isSliverItem: true,
        child: SliverToBoxAdapter(child: randomLogWidget('SliverToBoxAdapter')),
      ),
    );

    final groupH4Height = randomHeight(max: 200);
    crossAxisCount = nextInt(4, 1);
    children.add(
      RItemTile(
        tag: "SliverMainAxisGroup 4",
        headerPinned: true,
        headerFloating: false,
        headerFixedHeight: groupH4Height,
        sliverType: SliverMainAxisGroup,
        childTiles: [
          RItemTile(
            tag: "WaterfallFlow inner",
            sliverType: "WaterfallFlow",
            crossAxisCount: crossAxisCount,
            tileWrapShrinkWrap: false,
            childTiles: _buildGridTiles(crossAxisCount, "normal"),
          ),
        ],
        child: randomWidget(
          text:
              "SliverMainAxisGroup 4 - WaterfallFlow \n headerPinned ${true.toDC()} headerFloating ${false.toDC()}",
          height: groupH4Height,
        ),
      ),
    );

    children.add(
      RItemTile(
        isSliverItem: true,
        child: SliverToBoxAdapter(child: randomLogWidget('SliverToBoxAdapter')),
      ),
    );

    //SliverPersistentHeader 头部测试
    final h1Height = randomHeight(max: 200);
    children.add(
      RItemTile(
        tag: "SliverPersistentHeader 1",
        headerPinned: false,
        headerFloating: true,
        headerFixedHeight: h1Height,
        child: randomWidget(
          text:
              "SliverPersistentHeader 1:headerPinned ${false.toDC()} headerFloating ${true.toDC()}",
          height: h1Height,
        ),
      ),
    );

    //小量 SliverGrid 测试
    children.addAll(_buildGridTiles());

    //SliverPersistentHeader 头部测试
    final h2Height = randomHeight(max: 200);
    children.add(
      RItemTile(
        headerPinned: false,
        headerFloating: true,
        headerFixedHeight: h2Height,
        child: randomWidget(
          text:
              "SliverPersistentHeader 2:headerPinned ${false.toDC()} headerFloating ${true.toDC()}",
          height: h2Height,
        ),
      ),
    );

    //normal 基础测试
    for (var i = 0; i < littleNormalCount; i++) {
      children.add(
        RItemTile(
          isSliverItem: true,
          child: SliverToBoxAdapter(
            child: randomLogWidget('SliverToBoxAdapter: $i'),
          ),
        ),
      );
    }

    // SliverPersistentHeader 居中测试
    final h3Height = randomHeight(max: 200);
    children.add(
      RItemTile(
        headerPinned: true,
        headerFloating: true,
        headerFixedHeight: h3Height,
        child: randomWidget(
          text:
              "SliverPersistentHeader 3:headerPinned ${true.toDC()} headerFloating ${true.toDC()}",
          height: h3Height,
        ),
      ),
    );

    //小量 SliverGrid 测试
    children.addAll(_buildGridTiles());

    // SliverPersistentHeader 居中测试
    final h4Height = randomHeight(max: 200);
    children.add(
      RItemTile(
        headerPinned: true,
        headerFloating: true,
        headerFixedHeight: h4Height,
        child: randomWidget(
          text:
              "SliverPersistentHeader 4:headerPinned ${true.toDC()} headerFloating ${true.toDC()}",
          height: h4Height,
        ),
      ),
    );

    //normal 基础测试
    children.add(
      RItemTile(
        isSliverItem: true,
        child: SliverToBoxAdapter(child: randomLogWidget('SliverToBoxAdapter')),
      ),
    );

    //大量 SliverGrid 测试
    children.addAll(_buildGridTiles());

    // SliverPersistentHeader 居中测试
    final h5Height = randomHeight(max: 200);
    children.add(
      RItemTile(
        headerPinned: true,
        headerFloating: false,
        headerFixedHeight: h5Height,
        child: randomWidget(
          text:
              "SliverPersistentHeader 5:headerPinned ${true.toDC()} headerFloating ${false.toDC()}",
          height: h5Height,
        ),
      ),
    );

    //大量 SliverList 测试
    children.addAll(_buildListTiles());

    // SliverPersistentHeader 居中测试
    final h6Height = randomHeight(max: 200);
    children.add(
      RItemTile(
        headerPinned: true,
        headerFloating: false,
        headerFixedHeight: h6Height,
        child: randomWidget(
          text:
              "SliverPersistentHeader 6:headerPinned ${true.toDC()} headerFloating ${false.toDC()}",
          height: h6Height,
        ),
      ),
    );

    //normal 基础测试
    for (var i = 0; i < littleNormalCount; i++) {
      children.add(
        RItemTile(
          isSliverItem: true,
          child: SliverToBoxAdapter(
            child: randomLogWidget('SliverToBoxAdapter: $i'),
          ),
        ),
      );
    }

    //大量 MasonryGridView 测试
    crossAxisCount = nextInt(4, 1);
    children.add(
      RItemTile(
        tag: "MasonryGridView 1",
        sliverType: "MasonryGridView",
        crossAxisCount: crossAxisCount,
        childTiles: _buildGridTiles(crossAxisCount, "normal"),
      ),
    );

    //SliverFillRemaining 测试
    children.add(
      RItemTile(
        fillRemaining: true,
        fillOverscroll: true,
        fillExpand: true,
        child: randomLogWidget('SliverFillRemaining'),
      ),
    );

    return RScrollView(
      debugLabel: "RScrollViewAbc",
      enableFrameLoad: true,
      frameSplitCount: 1,
      frameSplitDuration: const Duration(milliseconds: 16),
      children: children,
    );
  }

  /// 构建网格测试tile
  WidgetList _buildGridTiles([int? crossAxisCount, Object? type, int? count]) {
    type ??= SliverGrid;
    crossAxisCount ??= nextInt(4, 1);
    count ??= nextInt(10, 5);
    return [
      for (var i = 0; i < count; i++)
        RItemTile(
          tag: "Grid Item $i",
          sliverType: type,
          crossAxisCount: crossAxisCount,
          child: randomLogWidget(
            "$type: $i / $count crossAxisCount:$crossAxisCount",
          ),
        ),
    ];
  }

  /// 构建列表测试tile
  WidgetList _buildListTiles([Object? type]) {
    type ??= SliverList;
    final count = nextInt(10, 5);
    return [
      for (var i = 0; i < count; i++)
        RItemTile(
          tag: "List Item $i / $count",
          sliverType: type,
          child: randomLogWidget("$type: $i"),
        ),
    ];
  }
}
