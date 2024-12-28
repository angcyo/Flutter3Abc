part of '../flutter3_abc.dart';

///
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2023/12/14
///

class SliverAbc extends StatefulWidget {
  const SliverAbc({super.key});

  @override
  State<SliverAbc> createState() => _SliverAbcState();
}

class _SliverAbcState extends State<SliverAbc> with BaseAbcStateMixin {
  WidgetList _buildSection({required String title}) => [
        SliverAppBar(
          title: Text(title),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.redAccent,
          elevation: 0,
          scrolledUnderElevation: 0,
          floating: true,
          pinned: true,
          primary: false,
        ),
        SliverList.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: index.isEven ? Colors.amber[300] : Colors.blue[300],
              height: 100.0,
              child: Center(
                child: Text(
                  'Item $index',
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            );
          },
          itemCount: 5,
        ),
      ];

  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      SliverMainAxisGroup(
        slivers: <Widget>[
          ..._buildSection(title: "Section title 1"),
          ..._buildSection(title: "Section title 1-1"),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.cyan,
              height: 100,
              child: const Center(
                child: Text('Another sliver child',
                    style: TextStyle(fontSize: 24)),
              ),
            ),
          )
        ],
      ),
      SliverMainAxisGroup(
        slivers: <Widget>[
          ..._buildSection(title: "Section title 2"),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.cyan,
              height: 100,
              child: const Center(
                child: Text('Another sliver child',
                    style: TextStyle(fontSize: 24)),
              ),
            ),
          )
        ],
      ),
      SliverToBoxAdapter(
        child: Container(
          height: 1000,
          decoration: const BoxDecoration(color: Colors.greenAccent),
          child: const Center(
            child: Text('Hello World!', style: TextStyle(fontSize: 24)),
          ),
        ),
      ),
    ];
  }
}
