part of '../../flutter3_abc.dart';

///
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2024/08/12
///
/// [PageView]生命周期测试
class PageLifecycleAbc extends StatefulWidget {
  const PageLifecycleAbc({super.key});

  @override
  State<PageLifecycleAbc> createState() => _PageLifecycleAbcState();
}

class _PageLifecycleAbcState extends State<PageLifecycleAbc> {
  late final PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildPageView(context).scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.runtimeType.toString()),
      ),
    );
  }

  Widget buildPageView(BuildContext context) {
    return PageView(
      controller: controller,
      children: const [
        Page1Page2(
          pageIndex: 0,
          wantKeepAlive: true,
        ),
        Page2Page2(
          pageIndex: 1,
          wantKeepAlive: true,
        ),
      ],
    ).pageLifecycle();
  }

  Widget buildPageView2(BuildContext context) {
    return PageViewLifecycleWrapper(
      onLifecycleEvent: (event) {
        l.d('${widget.runtimeType}#${event.name}');
      },
      child: PageView(
        controller: controller,
        children: [
          ChildPageLifecycleWrapper(
            index: 0,
            child: const Page1Page(),
            onLifecycleEvent: (event) {
              l.d('Page1Page#${event.name}');
            },
          ),
          ChildPageLifecycleWrapper(
            index: 1,
            child: const Page2Page(),
            onLifecycleEvent: (event) {
              l.d('Page2Page#${event.name}');
            },
          ),
        ],
      ),
    );
  }
}

class Page1Page extends StatefulWidget {
  const Page1Page({super.key});

  @override
  State<Page1Page> createState() => _Page1PageState();
}

class _Page1PageState extends BaseLifecycleState<Page1Page> {
  @override
  void onLifecycleEvent(LifecycleEvent event) {
    super.onLifecycleEvent(event);
    l.v("[${classHash()}]->$event");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: "${widget.runtimeType}".text(),
    ).material().scaffold();
  }
}

class Page2Page extends StatefulWidget {
  const Page2Page({super.key});

  @override
  State<Page2Page> createState() => _Page2PageState();
}

class _Page2PageState extends BaseLifecycleState<Page2Page> {
  @override
  void onLifecycleEvent(LifecycleEvent event) {
    super.onLifecycleEvent(event);
    l.v("[${classHash()}]->$event");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: "${widget.runtimeType}".text(),
    ).material().scaffold();
  }
}

//--new

class Page1Page2 extends BasePageChildLifecycleWidget {
  const Page1Page2({
    super.key,
    required super.pageIndex,
    super.wantKeepAlive,
    super.onLifecycleEvent,
  });

  @override
  State<Page1Page2> createState() => _Page1Page2State();
}

class _Page1Page2State extends BasePageChildLifecycleState<Page1Page2> {
  @override
  void onLifecycleEvent(LifecycleEvent event) {
    super.onLifecycleEvent(event);
    l.v("[${classHash()}]->$event");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      alignment: Alignment.center,
      child: "${widget.runtimeType}".text(),
    ).material();
  }
}

class Page2Page2 extends BasePageChildLifecycleWidget {
  const Page2Page2({
    super.key,
    required super.pageIndex,
    super.wantKeepAlive,
    super.onLifecycleEvent,
  });

  @override
  State<Page2Page2> createState() => _Page2Page2State();
}

class _Page2Page2State extends BasePageChildLifecycleState<Page2Page2> {
  @override
  void onLifecycleEvent(LifecycleEvent event) {
    super.onLifecycleEvent(event);
    l.v("[${classHash()}]->$event");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      alignment: Alignment.center,
      child: "${widget.runtimeType}".text(),
    ).material();
  }
}
