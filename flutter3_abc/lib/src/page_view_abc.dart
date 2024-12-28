part of '../../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/07/08
///
class PageViewAbc extends StatefulWidget {
  const PageViewAbc({super.key});

  @override
  State<PageViewAbc> createState() => _PageViewAbcState();
}

class _PageViewAbcState extends State<PageViewAbc>
    with BaseAbcStateMixin, TickerProviderStateMixin {
  late PageController _pageViewController;
  late PageController _pageViewController2;
  late TabController _tabController;
  int _currentPageIndex = 0;
  late TabLayoutController tabLayoutController =
      TabLayoutController(vsync: this);

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _pageViewController2 = PageController(viewportFraction: 0.8);
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _pageViewController2.dispose();
    _tabController.dispose();
    tabLayoutController.dispose();
  }

  @override
  WidgetList buildBodyList(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return [
      PageView(
        /// [PageView.scrollDirection] defaults to [Axis.horizontal].
        /// Use [Axis.vertical] to scroll vertically.
        controller: _pageViewController,
        onPageChanged: _handlePageViewChanged,
        children: <Widget>[
          const _Page1Widget().keepAlive(),
          const _Page2Widget().keepAlive(),
          const _Page3Widget().keepAlive(),
        ],
      ).size(height: 100),
      PageView(
        controller: _pageViewController2,
        pageSnapping: true,
        padEnds: false,
        onPageChanged: _handlePageViewChanged,
        children: const <Widget>[
          _Page1Widget(),
          _Page2Widget(),
          _Page3Widget(),
        ],
      ).size(height: 100),
      PageView(
        controller: _pageViewController2,
        pageSnapping: true,
        padEnds: true,
        onPageChanged: _handlePageViewChanged,
        children: const <Widget>[
          _Page1Widget(),
          _Page2Widget(),
          _Page3Widget(),
        ],
      ).size(height: 100),
      TabPageSelector(controller: _tabController).center(),
      TabLayout(
        tabLayoutController: tabLayoutController,
        selfConstraints: const LayoutBoxConstraints(
          widthType: ConstraintsType.wrapContent,
        ),
        bgDecoration: fillDecoration(
          color: globalTheme.whiteSubBgColor,
        ),
        contentBgDecoration: fillDecoration(
          color: Colors.black26,
        ),
        padding: const EdgeInsets.all(kM),
        children: [
          "First Page"
              .text()
              .rowOf(tabLayoutController.index == 0
                  ? const Icon(Icons.check)
                  : null)
              .min()
              .ink(() {
            //debugger();
            tabLayoutController.selectedItem(
              0,
              pageController: _pageViewController,
            );
            updateState();
          }),
          "Second Page\nSecond Page"
              .text()
              .rowOf(tabLayoutController.index == 1
                  ? const Icon(Icons.check)
                  : null)
              .min()
              .ink(() {
            //debugger();
            tabLayoutController.selectedItem(
              1,
              pageController: _pageViewController,
            );
            updateState();
          }),
          "Third Page"
              .text()
              .rowOf(tabLayoutController.index == 2
                  ? const Icon(Icons.check)
                  : null)
              .min()
              .ink(() {
            //debugger();
            tabLayoutController.selectedItem(
              2,
              pageController: _pageViewController,
            );
            updateState();
          }),
          DecoratedBox(
              decoration: fillDecoration(
            color: globalTheme.accentColor,
            gradient: linearGradient([Colors.purple, globalTheme.accentColor]),
          )).tabItemData(
            itemType: TabItemType.indicator,
            enableIndicatorFlow: true,
            /*padding: const EdgeInsets.all(kH),*/
          )
        ],
      ),
    ];
  }

  void _handlePageViewChanged(int currentPageIndex) {
    l.d('currentPageIndex:$currentPageIndex');
    if (!_isOnDesktopAndWeb) {
      return;
    }
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  bool get _isOnDesktopAndWeb {
    if (kIsWeb) {
      return true;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return true;
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        return false;
    }
  }
}

class _Page1Widget extends StatefulWidget {
  const _Page1Widget({super.key});

  @override
  State<_Page1Widget> createState() => _Page1WidgetState();
}

class _Page1WidgetState extends State<_Page1Widget> {
  @override
  void initState() {
    l.d('page 1:initState');
    super.initState();
  }

  @override
  void activate() {
    l.d('page 1:activate');
    super.activate();
  }

  @override
  void deactivate() {
    l.d('page 1:deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    l.d('page 1:dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    l.d('build page 1');
    return const Center(
      child: Text('First Page'),
    ).backgroundDecoration(null, fillColor: Colors.redAccent);
  }
}

class _Page2Widget extends StatefulWidget {
  const _Page2Widget({super.key});

  @override
  State<_Page2Widget> createState() => _Page2WidgetState();
}

class _Page2WidgetState extends State<_Page2Widget> {
  @override
  void initState() {
    l.d('page 2:initState');
    super.initState();
  }

  @override
  void activate() {
    l.d('page 2:activate');
    super.activate();
  }

  @override
  void deactivate() {
    l.d('page 2:deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    l.d('page 2:dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    l.d('build page 2');
    return const Center(
      child: Text('Second Page'),
    ).backgroundDecoration(null, fillColor: Colors.greenAccent);
  }
}

class _Page3Widget extends StatefulWidget {
  const _Page3Widget({super.key});

  @override
  State<_Page3Widget> createState() => _Page3WidgetState();
}

class _Page3WidgetState extends State<_Page3Widget> {
  @override
  void initState() {
    l.d('page 3:initState');
    super.initState();
  }

  @override
  void activate() {
    l.d('page 3:activate');
    super.activate();
  }

  @override
  void deactivate() {
    l.d('page 3:deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    l.d('page 3:dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    l.d('build page 3');
    return const Center(
      child: Text('Third Page'),
    ).backgroundDecoration(null, fillColor: Colors.blueAccent);
  }
}
