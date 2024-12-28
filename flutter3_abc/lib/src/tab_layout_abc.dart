part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/05/11
///

class TabLayoutAbc extends StatefulWidget {
  const TabLayoutAbc({super.key});

  @override
  State<TabLayoutAbc> createState() => _TabLayoutAbcState();
}

class _TabLayoutAbcState extends State<TabLayoutAbc>
    with BaseAbcStateMixin, TickerProviderStateMixin {
  int pageCount = 6;

  late List<TabLayoutController> tabLayoutControllerList = [
    for (var i = 0; i < pageCount; i++)
      TabLayoutController(
        vsync: this,
        scrollController: ScrollContainerController(),
        length: pageCount,
      ),
  ];

  final PageController _pageController = PageController(
    initialPage: 0,
    viewportFraction: 1,
  );

  late TabLayoutController bottomLayoutController = TabLayoutController(
    vsync: this,
    scrollController: ScrollContainerController(),
  );

  late TabLayoutController segmentLayoutController = TabLayoutController(
    vsync: this,
    scrollController: ScrollContainerController(),
  );

  late TabLayoutController segmentLayoutController2 = TabLayoutController(
    vsync: this,
    scrollController: ScrollContainerController(),
  );

  /// 指示器对齐方式
  Alignment _alignment = Alignment.center;
  final List<Alignment> _alignmentList = [
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.centerLeft,
    Alignment.center,
    Alignment.centerRight,
    Alignment.bottomLeft,
    Alignment.bottomCenter,
    Alignment.bottomRight,
  ];

  /// 指示器绘制方式
  TabItemPaintType _itemPaintType = TabItemPaintType.background;
  final List<TabItemPaintType> _indicatorPaintTypeList = [
    TabItemPaintType.background,
    TabItemPaintType.foreground,
  ];

  /// 宽度约束类型
  ConstraintsType widthType = ConstraintsType.wrapContent;
  ConstraintsType heightType = ConstraintsType.fixedSize;
  final List<ConstraintsType> _constraintsTypeList = [
    ConstraintsType.wrapContent,
    ConstraintsType.fixedSize,
    ConstraintsType.matchParent,
  ];

  bool enableIndicatorFlow = false;
  bool alignmentParent = true;
  bool enableMargin = true;

  Color colorAccent = Colors.purpleAccent;

  @override
  void initState() {
    super.initState();
  }

  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      DropdownButtonTile(
        label: "指示器对齐方式",
        icon: const Icon(Icons.water_drop),
        dropdownValue: _alignment,
        dropdownValueList: _alignmentList,
        onChanged: (value) {
          Feedback.forLongPress(context);
          _alignment = value;
          updateState();
        },
      ),
      DropdownMenuTile(
        label: "指示器绘制方式",
        dropdownValue: _itemPaintType,
        dropdownValueList: _indicatorPaintTypeList,
        onChanged: (value) {
          Feedback.forLongPress(context);
          _itemPaintType = value;
          updateState();
        },
      ),
      DropdownButtonTile(
        label: "约束宽度类型",
        dropdownValue: widthType,
        dropdownValueList: _constraintsTypeList,
        onChanged: (value) {
          Feedback.forLongPress(context);
          widthType = value;
          updateState();
        },
      ),
      DropdownButtonTile(
        label: "约束高度类型",
        dropdownValue: heightType,
        dropdownValueList: _constraintsTypeList,
        onChanged: (value) {
          Feedback.forLongPress(context);
          heightType = value;
          updateState();
        },
      ),
      LabelSwitchTile(
        label: "参考父布局",
        value: alignmentParent,
        onValueChanged: (value) {
          Feedback.forLongPress(context);
          alignmentParent = value;
          updateState();
        },
      ),
      LabelSwitchTile(
        label: "激活流式过度",
        value: enableIndicatorFlow,
        onValueChanged: (value) {
          Feedback.forLongPress(context);
          enableIndicatorFlow = value;
          updateState();
        },
      ),
      LabelSwitchTile(
        label: "激活margin",
        value: enableMargin,
        onValueChanged: (value) {
          Feedback.forLongPress(context);
          enableMargin = value;
          updateState();
        },
      ),
      //---
      TabLayout(
        tabLayoutController: tabLayoutControllerList[0],
        gap: kX,
        padding: const EdgeInsets.all(kX),
        children: [
          ...buildItemList(context, tabLayoutControllerList[0]),
          DecoratedBox(decoration: fillDecoration(color: Colors.black12))
              .tabItemData(
            itemType: TabItemType.scrollDecoration,
            itemPaintType: TabItemPaintType.background,
            /*padding: const EdgeInsets.all(kH),*/
          ),
          DecoratedBox(
              decoration: fillDecoration(
            color: colorAccent,
            gradient: linearGradient([Colors.purple, colorAccent]),
          )).tabItemData(
            itemType: TabItemType.indicator,
            alignment: _alignment,
            itemPaintType: _itemPaintType,
            alignmentParent: alignmentParent,
            itemConstraints: LayoutBoxConstraints(
              widthType: widthType,
              maxWidth: 4,
              heightType: heightType,
              maxHeight: 4,
            ),
            enableIndicatorFlow: enableIndicatorFlow,
            /*padding: const EdgeInsets.all(kH),*/
          )
        ],
      ).container(
        padding: const EdgeInsets.all(16),
        color: Colors.black26,
      ),
      buildPageView(context),
      //segment
      TabLayout(
        tabLayoutController: segmentLayoutController,
        gap: kX,
        autoEqualWidth: true,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...buildSegmentItem(context, segmentLayoutController),
          DecoratedBox(
              decoration: fillDecoration(
            color: Colors.black12,
            radius: kMaxBorderRadius,
            border: Border.all(color: colorAccent, width: 1),
          )).tabItemData(
            itemType: TabItemType.bgDecoration,
            itemPaintType: TabItemPaintType.background,
          ),
          DecoratedBox(
              decoration: fillDecoration(
            color: colorAccent,
            radius: kMaxBorderRadius,
          )).tabItemData(
            itemType: TabItemType.indicator,
            margin: enableMargin ? const EdgeInsets.all(4) : null,
            itemPaintType: _itemPaintType,
            widthConstraintsType: widthType,
            heightConstraintsType: heightType,
          ),
          "new"
              .text(textColor: Colors.white, fontSize: 8)
              .container(
                  color: Colors.red,
                  radius: kMaxBorderRadius,
                  padding: const EdgeInsets.symmetric(horizontal: kS))
              .tabStackItemData(anchorIndex: 0),
        ],
      )
          .paddingSymmetric(horizontal: kXx, vertical: kL)
          .constrained(minHeight: 50),
      TabLayout(
        tabLayoutController: segmentLayoutController2,
        autoEqualWidth: true,
        crossAxisAlignment: null,
        children: [
          ...buildSegmentItem2(context, segmentLayoutController2),
          DecoratedBox(
              decoration: fillDecoration(
            color: Colors.black12,
            radius: kMaxBorderRadius,
            border: Border.all(color: colorAccent, width: 1),
          )).tabItemData(
            itemType: TabItemType.bgDecoration,
            itemPaintType: TabItemPaintType.background,
          ),
        ],
      )
          .paddingSymmetric(horizontal: kXx, vertical: kL)
          .constrained(minHeight: 50),
      //bottom
      TabLayout(
        tabLayoutController: bottomLayoutController,
        gap: kX,
        autoEqualWidth: true,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: buildBarItem(context, bottomLayoutController),
      )
          .container(color: Colors.black12)
          .size(width: double.infinity, height: 50)
          .align(Alignment.bottomCenter)
          .rFill(fillExpand: false),
    ];
  }

  Widget buildPageView(BuildContext content) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        //l.d(_pageController.page);

        for (var i = 0; i < tabLayoutControllerList.length; i++) {
          final tabLayoutController = tabLayoutControllerList[i];
          final double page = _pageController.page!;
          if (notification is ScrollUpdateNotification &&
              !tabLayoutController.indexIsChanging) {
            final bool pageChanged =
                (page - tabLayoutController.index).abs() > 1.0;
            if (pageChanged) {
              tabLayoutController.index = page.round();
            }
            tabLayoutController.offset = clampDouble(
                _pageController.page! - tabLayoutController.index, -1.0, 1.0);
          } else if (notification is ScrollEndNotification) {
            tabLayoutController.index = page.round();
            if (!tabLayoutController.indexIsChanging) {
              tabLayoutController.offset = clampDouble(
                  _pageController.page! - tabLayoutController.index, -1.0, 1.0);
            }
          }
        }
        return true;
      },
      child: PageView(
        dragStartBehavior: DragStartBehavior.start,
        clipBehavior: Clip.hardEdge,
        controller: _pageController,
        physics:
            const PageScrollPhysics().applyTo(const ClampingScrollPhysics()),
        children: [
          for (var i = 0; i < pageCount; i++)
            "Page $i".text().center().container(color: randomColor()),
        ],
      ),
    ).container(
      padding: const EdgeInsets.all(16),
      height: 100,
      color: Colors.black12,
    );
  }

  WidgetList buildItemList(
    BuildContext content,
    TabLayoutController controller,
  ) {
    return [
      "R".text().ink(() {
        //debugger();
        controller.selectedItem(0);
      }),
      "angcyo".text().ink(() {
        controller.selectedItem(1);
      }),
      const Icon(Icons.dark_mode).ink(() {
        controller.selectedItem(2);
      }),
      "中文示例".text().ink(() {
        controller.selectedItem(3);
      }),
      [
        "中文示例".text(),
        const Icon(Icons.abc_outlined),
      ].column()!.ink(() {
        controller.selectedItem(4);
      }),
      [
        const Icon(Icons.abc_outlined),
        "中文示例中文示例".text(),
      ].row()!.ink(() {
        //debugger();
        controller.selectedItem(5);
      }),
    ];
  }

  WidgetList buildBarItem(
    BuildContext content,
    TabLayoutController controller,
  ) {
    return [
      [
        const Icon(Icons.home),
        "首页".text(),
      ]
          .column()!
          .colorFiltered(color: controller.index == 0 ? colorAccent : null)
          .ink(() {
        controller.selectedItem(0);
        updateState();
      }),
      [
        const Icon(Icons.center_focus_strong),
        "社区中心".text(),
      ]
          .column()!
          .colorFiltered(color: controller.index == 1 ? colorAccent : null)
          .ink(() {
        controller.selectedItem(1);
        updateState();
      }),
      [
        const Icon(Icons.manage_accounts),
        "我".text(),
      ]
          .column()!
          .colorFiltered(color: controller.index == 2 ? colorAccent : null)
          .ink(() {
        controller.selectedItem(2);
        updateState();
      }),
    ];
  }

  WidgetList buildSegmentItem(
    BuildContext content,
    TabLayoutController controller,
  ) {
    return [
      [
        "首页".text(),
      ]
          .column()!
          .colorFiltered(
              color: controller.index == 0 ? Colors.white : colorAccent)
          .click(() {
        controller.selectedItem(0);
        updateState();
      }),
      [
        "社区中心".text(),
      ]
          .column()!
          .colorFiltered(
              color: controller.index == 1 ? Colors.white : colorAccent)
          .click(() {
        controller.selectedItem(1);
        updateState();
      }),
      [
        "我".text(),
      ]
          .column()!
          .colorFiltered(
              color: controller.index == 2 ? Colors.white : colorAccent)
          .click(() {
        controller.selectedItem(2);
        updateState();
      }),
    ];
  }

  WidgetList buildSegmentItem2(
    BuildContext content,
    TabLayoutController controller,
  ) {
    return [
      [
        "首页".text(),
      ]
          .column()!
          .center()
          .colorFiltered(
              color: controller.index == 0 ? Colors.white : colorAccent)
          .backgroundDecoration(controller.index == 0
              ? fillDecoration(
                  color: colorAccent,
                  onlyLeftRadius: kMaxBorderRadius,
                )
              : null)
          .click(() {
        controller.selectedItem(0);
        updateState();
      }),
      DecoratedBox(
              decoration: fillDecoration(
        color: Colors.green,
        radius: 0,
      )).size(width: 2, height: 20).tabItemData(
            itemType: TabItemType.gap,
            margin: const EdgeInsets.symmetric(vertical: 4),
            itemPaintType: TabItemPaintType.background,
            alignment: Alignment.bottomCenter,
          ),
      [
        "社区中心".text(),
      ]
          .column()!
          .center()
          .colorFiltered(
              color: controller.index == 1 ? Colors.white : colorAccent)
          .backgroundDecoration(controller.index == 1
              ? fillDecoration(color: colorAccent, radius: 0)
              : null)
          .click(() {
        controller.selectedItem(1);
        updateState();
      }).tabItemData(margin: const EdgeInsets.symmetric(horizontal: 4)),
      DecoratedBox(
              decoration: fillDecoration(
        color: Colors.green,
        radius: 0,
      )).size(width: 2, height: 20).tabItemData(
            itemType: TabItemType.gap,
            margin: const EdgeInsets.symmetric(vertical: 4),
            itemPaintType: TabItemPaintType.background,
            alignment: Alignment.topCenter,
          ),
      [
        "我".text(),
      ]
          .column()!
          .center()
          .colorFiltered(
              color: controller.index == 2 ? Colors.white : colorAccent)
          .backgroundDecoration(controller.index == 2
              ? fillDecoration(
                  color: colorAccent,
                  onlyRightRadius: kMaxBorderRadius,
                )
              : null)
          .click(() {
        controller.selectedItem(2);
        updateState();
      }),
    ];
  }
}
