part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/11/02
///

class SilverGridAbc extends StatefulWidget {
  const SilverGridAbc({super.key});

  @override
  State<SilverGridAbc> createState() => _SilverGridAbcState();
}

class _SilverGridAbcState extends State<SilverGridAbc> with BaseAbcStateMixin {
  @override
  bool get useScroll => false;

  @override
  Widget buildBody(BuildContext context) {
    /*return GridView.count(
      crossAxisCount: 2,
      children: [
        Container(color: Colors.red),
        Container(color: Colors.green),
        Container(color: Colors.blue),
        Container(color: Colors.yellow),
      ],
    );*/
    return CustomScrollView(
      scrollBehavior: const MaterialScrollBehavior(),
      physics:
          const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      slivers: [
        SliverGrid.count(
          crossAxisCount: nextInt(10, 1),
          children: [
            for (var i = 0; i < nextInt(100); i++)
              randomLogWidget('SliverGrid:$i'),
          ],
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          fillOverscroll: AbcConfig.getAndIncrementClickCount() % 2 == 0,
          child: Container(
            color: Colors.grey,
            alignment: Alignment.center,
            child: const Text(
              'SliverFillRemaining',
              style: TextStyle(fontSize: 40),
            ),
          ),
        ),
      ],
    );
  }
}
