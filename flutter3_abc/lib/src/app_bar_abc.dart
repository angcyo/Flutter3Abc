part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/11/14
///

/// https://api.flutter.dev/flutter/material/AppBar-class.html
class AppBarAbc extends StatefulWidget {
  const AppBarAbc({super.key});

  @override
  State<AppBarAbc> createState() => _AppBarAbcState();
}

class _AppBarAbcState extends State<AppBarAbc>
    with BaseAbcStateMixin, SingleTickerProviderStateMixin {
  final WidgetList tabs = [
    const Tab(text: 'Tab1'),
    const Tab(text: 'Tab2'),
    const Tab(text: "Tab3"),
  ];
  late final TabController _tabController =
      TabController(initialIndex: 1, length: tabs.length, vsync: this);

  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      const Text(
        'AppBar↓',
        textAlign: TextAlign.center,
      ),
      AppBar(
        title: const Text('AppBar1'),
        automaticallyImplyLeading: false,
        actions: tabs,
      ),
      AppBar(
        leading: const Icon(Icons.accessible),
        title: const Text('AppBar2'),
        scrolledUnderElevation: 10,
        flexibleSpace: SizedBox(
          height: kToolbarHeight,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.blue],
              ),
            ),
          ),
        ),
      ),
      AppBar(
        title: const Text('AppBar3'),
        actions: [
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.construction_sharp),
          ),
        ],
      ),
      AppBar(
        title: const Text('AppBar4'),
        actions: [
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.construction_sharp),
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.ad_units),
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.abc),
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.access_time_rounded),
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.account_balance),
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.access_alarms_outlined),
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.add_box_rounded),
          ),
        ],
      ),
      /*AppBar(
        title: const Text('AppBar5'),
        bottom: PreferredSize(
          preferredSize: const Size(100, 48.0),
          child: TabBar(
            controller: _tabController,
            tabs: tabs,
          ),
        ),
      ),*/
      const Text(
        'BottomAppBar↓',
        textAlign: TextAlign.center,
      ),
      BottomAppBar(
        color: randomColor(),
        child: randomTextWidget(),
      ),
      BottomAppBar(
        color: randomColor(),
        elevation: 10,
        shape: const CircularNotchedRectangle(),
        child: const Row(
          children: [
            Icon(
              Icons.arrow_back_ios_new,
              color: Colors.purpleAccent,
            ),
            Spacer(),
            Icon(
              Icons.more_vert,
              color: Colors.yellowAccent,
            ),
          ],
        ),
      ),
      BottomAppBar(
        child: Row(
          children: [
            IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.construction_sharp),
            ),
            IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.ad_units),
            ),
            IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.abc),
            ),
            IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.access_time_rounded),
            ),
            IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.account_balance),
            ),
            IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.access_alarms_outlined),
            ),
            IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.add_box_rounded),
            ),
            TextButton(
              onPressed: onPressed,
              child: randomTextWidget(),
            ).expanded(),
          ],
        ),
      ),
    ];
  }
}
