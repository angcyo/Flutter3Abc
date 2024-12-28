part of '../flutter3_abc.dart';

///
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2023/11/14
///

class TabBarAbc extends StatefulWidget {
  const TabBarAbc({super.key});

  @override
  State<TabBarAbc> createState() => _TabBarAbcState();
}

class _TabBarAbcState extends State<TabBarAbc>
    with BaseAbcStateMixin, SingleTickerProviderStateMixin {
  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: const Icon(Icons.ac_unit_outlined),
      label: randomText(5),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.add_location_alt_rounded),
      label: randomText(6),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.adb_outlined),
      label: randomText(7),
    ),
  ];
  final List<Widget> tabs = [
    randomTextWidget(),
    randomTextWidget(),
    randomTextWidget(),
    randomTextWidget(),
    randomTextWidget(),
    randomTextWidget(),
    randomTextWidget(),
    randomTextWidget(),
  ];
  final WidgetList pages = [
    randomWidget(text: randomText()),
    randomWidget(text: randomText()),
    randomWidget(text: randomText()),
    randomWidget(text: randomText()),
    randomWidget(text: randomText()),
    randomWidget(text: randomText()),
    randomWidget(text: randomText()),
    randomWidget(text: randomText()),
  ];
  late final TabController controller =
      TabController(length: tabs.length, vsync: this);

  final List<BottomNavigationBarItem> items2 = [
    BottomNavigationBarItem(
      icon: const Icon(Icons.ac_unit_outlined),
      label: randomText(5),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.adb_outlined),
      label: randomText(6),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.add_location_alt_rounded),
      label: randomText(7),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.backpack),
      label: randomText(8),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.cable_sharp),
      label: randomText(9),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.dark_mode_outlined),
      label: randomText(10),
    ),
  ];

  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      const Text(
        "CupertinoTabBar↓",
        textAlign: TextAlign.center,
      ),
      CupertinoTabBar(
        items: items,
        currentIndex: currentIndex,
        onTap: onSelectedIndex,
      ),
      CupertinoTabBar(
        items: items2,
        currentIndex: currentIndex,
        onTap: onSelectedIndex,
      ),
      const Text(
        "TabBar↓",
        textAlign: TextAlign.center,
      ),
      TabBar(
        tabs: tabs,
        controller: controller,
      ),
      TabBar(
        tabs: tabs,
        isScrollable: true,
        controller: controller,
      ),
      TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: Colors.redAccent,
        indicatorPadding: const EdgeInsets.all(8),
        controller: controller,
      ),
      const Text(
        "TabBarView↓",
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 150,
        child: TabBarView(
          controller: controller,
          children: pages,
        ),
      ),
    ];
  }
}
