part of '../flutter3_abc.dart';


///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/11/14
///

/// https://api.flutter.dev/flutter/material/NavigationBar-class.html
/// https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html
class NavigationBarAbc extends StatefulWidget {
  const NavigationBarAbc({super.key});

  @override
  State<NavigationBarAbc> createState() => _NavigationBarAbcState();
}

class _NavigationBarAbcState extends State<NavigationBarAbc>
    with BaseAbcStateMixin {
  late WidgetList destinations = [
    FilledButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.home),
      label: const Text("Home"),
    ),
    FilledButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.business),
      label: const Text('Business'),
    ),
    FilledButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.school),
      label: const Text('School'),
    ),
    FilledButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.school),
      label: const Text('School2'),
    ),
  ];

  late WidgetList destinations2 = [
    const NavigationDestination(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    const NavigationDestination(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    const NavigationDestination(
      icon: Icon(Icons.school),
      label: 'School',
    ),
    const NavigationDestination(
      icon: Icon(Icons.school),
      label: 'School2',
    ),
  ];

  late List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.school),
      label: 'School',
    ),
  ];
  late List<BottomNavigationBarItem> items2 = [
    BottomNavigationBarItem(
      icon: const Icon(Icons.home),
      label: 'Home',
      backgroundColor: randomColor(),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.business),
      label: 'Business',
      backgroundColor: randomColor(),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.school),
      label: 'School',
      backgroundColor: randomColor(),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.school),
      label: 'School2',
      backgroundColor: randomColor(),
    ),
  ];

  @override
  List<Widget> buildBodyList(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return [
      const Text(
        'NavigationBar↓',
        textAlign: TextAlign.center,
      ),
      NavigationBar(
        destinations: destinations,
        selectedIndex: currentIndex,
        onDestinationSelected: onSelectedIndex,
      ),
      NavigationBar(
        destinations: destinations2,
        selectedIndex: currentIndex,
        elevation: 8,
        onDestinationSelected: onSelectedIndex,
      ),
      NavigationBar(
        destinations: destinations2,
        selectedIndex: currentIndex,
        elevation: 0,
        surfaceTintColor: Colors.deepOrangeAccent,
        indicatorColor: randomColor(),
        onDestinationSelected: onSelectedIndex,
      ),
      const Text(
        'BottomNavigationBar↓',
        textAlign: TextAlign.center,
      ),
      BottomNavigationBar(
        onTap: onSelectedIndex,
        items: items,
        currentIndex: currentIndex,
      ),
      BottomNavigationBar(
        onTap: onSelectedIndex,
        items: items2,
        elevation: 0,
        selectedItemColor: themeData.primaryColor,
        unselectedItemColor: themeData.unselectedWidgetColor,
        currentIndex: currentIndex,
      ),
      BottomNavigationBar(
        onTap: onSelectedIndex,
        items: items2,
        elevation: 1,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: themeData.primaryColor,
        unselectedItemColor: themeData.unselectedWidgetColor,
        currentIndex: currentIndex,
        landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
      ),
      const Text(
        'CupertinoNavigationBar↓',
        textAlign: TextAlign.center,
      ),
      const CupertinoNavigationBar(
        middle: Text('middle'),
      ),
      const CupertinoNavigationBar(
        leading: Text('leading'),
        middle: Text('middle'),
        trailing: Text('trailing'),
      ),
    ];
  }
}
