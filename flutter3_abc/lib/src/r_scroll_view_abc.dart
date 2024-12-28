part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/11/03
///

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
    final gridCount = nextInt(20, 10);
    final littleGridCount = nextInt(5, 2);
    final listCount = nextInt(20, 10);
    final countStr = "gridCount:$gridCount listCount:$listCount";
    l.i(countStr);

    WidgetList children = [];
    //SliverPersistentHeader 头部测试
    children.add(RItemTile(
      headerPinned: false,
      headerFloating: true,
      child: randomWidget(
        text: "H1:gridCount:$gridCount listCount:$listCount",
      ),
    ));

    //小量 SliverGrid 测试
    for (var i = 0; i < littleGridCount; i++) {
      children.add(
        RItemTile(
          sliverType: SliverGrid,
          crossAxisCount: nextInt(4, 1),
          child: randomLogWidget("LG:$i"),
        ),
      );
    }

    //normal 基础测试
    children.add(RItemTile(
      isSliverItem: true,
      child: SliverToBoxAdapter(
        child: randomLogWidget('SliverToBoxAdapter'),
      ),
    ));

    // SliverPersistentHeader 居中测试
    children.add(RItemTile(
      headerPinned: true,
      headerFloating: true,
      child: randomWidget(
        text: "H2:gridCount:$gridCount listCount:$listCount",
      ),
    ));

    /*builder.add(
        SliverPersistentHeader(
          delegate: SingleSliverPersistentHeaderDelegate(
            child: Container(
              alignment: Alignment.center,
              color: randomColor(),
              child: Text("gridCount:$gridCount listCount:$listCount"),
            ),
          ),
          pinned: true,
          floating: false,
        ),
      );
      builder.add(
        SliverPersistentHeader(
          delegate: SingleSliverPersistentHeaderDelegate(
            child: Container(
              alignment: Alignment.center,
              color: randomColor(),
              child: Text("gridCount:$gridCount listCount:$listCount"),
            ),
          ),
          pinned: true,
          floating: true,
        ),
      );*/

    //大量 SliverGrid 测试
    for (var i = 0; i < gridCount; i++) {
      children.add(
        RItemTile(
          sliverType: SliverGrid,
          crossAxisCount: nextInt(4, 1),
          child: randomLogWidget("G:$i"),
        ),
      );
    }

    // SliverPersistentHeader 居中测试
    children.add(RItemTile(
      headerPinned: true,
      child: randomWidget(
        text: "H3:gridCount:$gridCount listCount:$listCount",
      ),
    ));

    //大量 SliverList 测试
    for (var i = 0; i < listCount; i++) {
      children.add(RItemTile(
        sliverType: SliverList,
        child: randomLogWidget("L:$i"),
      ));
    }

    // SliverFillRemaining 测试
    children.add(RItemTile(
      fillRemaining: true,
      fillOverscroll: true,
      fillExpand: true,
      child: randomLogWidget('SliverFillRemaining'),
    ));

    return RScrollView(
      enableFrameLoad: true,
      frameSplitCount: 1,
      frameSplitDuration: const Duration(milliseconds: 16),
      children: children,
    );
  }
}
