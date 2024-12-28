part of '../flutter3_abc.dart';

///
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2023/12/22
///
class StickAppBarAbc extends StatefulWidget {
  const StickAppBarAbc({super.key});

  @override
  State<StickAppBarAbc> createState() => _StickAppBarAbcState();
}

class _StickAppBarAbcState extends State<StickAppBarAbc>
    with BaseAbcStateMixin {
  Widget buildSliverItem() {
    return SliverToBoxAdapter(
      child: Container(
        color: randomColor(),
        height: nextInt(300, 100).toDouble(),
        child: Center(
          child: Text(
            randomText(),
            style: const TextStyle(fontSize: 14),
            overflow: TextOverflow.fade,
          ).paddingAll(kX),
        ),
      ),
    );
  }

  Widget buildItemTile() {
    return Container(
      color: randomColor(),
      height: nextInt(300, 100).toDouble(),
      child: Center(
        child: Text(
          randomText(),
          style: const TextStyle(fontSize: 14),
          overflow: TextOverflow.fade,
        ).paddingAll(kX),
      ),
    ).rItemTile();
  }

  WidgetList buildSliverItemList() => [
        buildSliverItem(),
        buildSliverItem(),
        buildSliverItem(),
        buildSliverItem(),
        buildSliverItem(),
        buildSliverItem(),
        buildSliverItem(),
      ];

  bool groupExpanded = true;

  /// [NavigationToolbar]
  /// [NavigationToolbar.middleSpacing]
  /// static const double kMiddleSpacing = 16.0;
  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      [
        "分组1".text(textAlign: TextAlign.start).expanded(),
        groupExpanded
            ? const Icon(Icons.expand_less)
            : const Icon(Icons.expand_more)
      ]
          .row()!
          .container(
            color: randomColor(),
            alignment: Alignment.centerLeft,
          )
          .ink(() {
        groupExpanded = !groupExpanded;
        updateState();
      }).rGroup(
        groupExpanded: groupExpanded,
        sliverPadding: const EdgeInsets.all(kX),
      ),
      buildItemTile(),
      buildItemTile(),
      buildItemTile(),
      //---
      SliverPadding(
        padding: const EdgeInsets.all(kX),
        sliver: DecoratedSliver(
          decoration: strokeDecoration(),
          sliver: SliverMainAxisGroup(
            slivers: [
              SliverAppBar(
                title: "Header1".text(),
                toolbarHeight: 40,
                centerTitle: false,
                automaticallyImplyLeading: false,
                floating: true,
                titleSpacing: kX,
                pinned: true,
                excludeHeaderSemantics: true,
                snap: true,
              ),
              ...buildSliverItemList(),
            ],
          ),
        ),
      ),
      SliverMainAxisGroup(
        slivers: [
          SliverAppBar(
            title: "Header2".text(style: const TextStyle(fontSize: 14)),
            toolbarHeight: 40,
            //elevation: ,
            //scrolledUnderElevation: ,
            centerTitle: false,
            automaticallyImplyLeading: false,
            floating: true,
            pinned: true,
            snap: true,
            actions: [
              IconButton(
                onPressed: () {
                  toastInfo("点击了");
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          ...buildSliverItemList(),
        ],
      ),
      //---
      SliverMainAxisGroup(
        slivers: [
          SliverPersistentHeader(
            delegate: SingleSliverPersistentHeaderDelegate(
              child: "Header3"
                  .text(textAlign: TextAlign.start)
                  .container(
                    color: randomColor(),
                    alignment: Alignment.centerLeft,
                  )
                  .matchParent(),
              childBuilder: null,
              headerFixedHeight: kMinInteractiveDimension,
              headerMaxHeight: kMinInteractiveDimension,
              headerMinHeight: kMinInteractiveDimension,
            ),
            pinned: true,
            floating: true,
          ),
          ...buildSliverItemList(),
        ],
      ),
      //---
      SliverMainAxisGroup(
        slivers: [
          SliverPersistentHeader(
            delegate: SingleSliverPersistentHeaderDelegate(
              child: "Header4"
                  .text(textAlign: TextAlign.start)
                  .container(
                    color: randomColor(),
                    alignment: Alignment.centerLeft,
                  )
                  .matchParent(),
              childBuilder: null,
              headerFixedHeight: kMinInteractiveDimension,
              headerMaxHeight: kMinInteractiveDimension,
              headerMinHeight: kMinInteractiveDimension,
            ),
            pinned: true,
            floating: true,
          ),
          ...buildSliverItemList(),
        ],
      ),
      //---
    ];
  }
}
