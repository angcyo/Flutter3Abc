part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/11/02
///

class SilverListAbc extends StatefulWidget {
  const SilverListAbc({super.key});

  @override
  State<SilverListAbc> createState() => _SilverListAbcState();
}

class _SilverListAbcState extends State<SilverListAbc> with BaseAbcStateMixin {
  @override
  bool get useScroll => false;

  @override
  Widget buildBody(BuildContext context) {
    return CustomScrollView(
      scrollBehavior: const MaterialScrollBehavior(),
      physics:
          const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      slivers: [
        SliverList.list(
          children: [
            for (var i = 0; i < nextInt(100, 10); i++)
              randomLogWidget('SliverList:$i'),
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
