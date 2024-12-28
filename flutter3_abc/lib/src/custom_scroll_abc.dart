part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/11/02
///

class CustomScrollAbc extends StatefulWidget {
  const CustomScrollAbc({super.key});

  @override
  State<CustomScrollAbc> createState() => _CustomScrollAbcState();
}

class _CustomScrollAbcState extends State<CustomScrollAbc>
    with BaseAbcStateMixin {
  @override
  bool get useScroll => false;

  @override
  Widget buildBody(BuildContext context) {
    final gridCount = nextInt(100, 10);
    final listCount = nextInt(100, 10);
    l.i("gridCount:$gridCount listCount:$listCount");
    return CustomScrollView(
      scrollBehavior: const MaterialScrollBehavior(),
      physics:
          const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      slivers: [
        SliverPersistentHeader(
          delegate: _CustomScrollAbcHeader(
            child: Text("gridCount:$gridCount listCount:$listCount"),
          ),
          pinned: true,
        ),
        SliverGrid.count(
          crossAxisCount: nextInt(4, 1),
          children: [
            for (var i = 0; i < gridCount; i++)
              randomLogWidget('SliverGrid:$i'),
          ],
        ),
        SliverList.list(
          children: [
            for (var i = 0; i < listCount; i++)
              randomLogWidget('SliverList:$i'),
          ],
        ),
      ],
    );
  }
}

class _CustomScrollAbcHeader extends SliverPersistentHeaderDelegate {
  _CustomScrollAbcHeader({required this.child});

  final Widget child;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      alignment: Alignment.center,
      color: randomColor(),
      child: child,
    );
  }

  @override
  double get maxExtent => minExtent * 2;

  @override
  double get minExtent => 20;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
