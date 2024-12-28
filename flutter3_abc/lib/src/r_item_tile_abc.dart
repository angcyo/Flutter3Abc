part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/08/08
///
class RItemTileAbc extends StatefulWidget {
  const RItemTileAbc({super.key});

  @override
  State<RItemTileAbc> createState() => _RItemTileAbcState();
}

class _RItemTileAbcState extends State<RItemTileAbc> {
  @override
  Widget build(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return RScrollView(
      children: [
        SliverAppBar(
          title: widget.runtimeType.toString().text(),
        ),
        for (var i = 0; i < 100; i++)
          Builder(builder: (context) {
            l.v("build item->$i");
            return "item ~~ $i".text().container(
                  color: randomColor(),
                  height: 100,
                );
          }).rListTile(),
      ],
    ).scaffold(backgroundColor: globalTheme.themeWhiteColor);
  }
}
