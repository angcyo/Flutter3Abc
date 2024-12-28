part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/12/11
///

class StickHeaderAbc extends StatefulWidget {
  const StickHeaderAbc({super.key});

  @override
  State<StickHeaderAbc> createState() => _StickHeaderAbcState();
}

class _StickHeaderAbcState extends State<StickHeaderAbc>
    with BaseAbcStateMixin {
  @override
  List<Widget> buildBodyList(BuildContext context) {
    WidgetList list = [];
    for (var i = 0; i < 20; i++) {
      list.add("Header:$i"
          .text()
          .container(
            padding: const EdgeInsets.all(kXh),
            color: Colors.redAccent,
          )
          .rFloated());
      for (var j = 0; j < nextInt(5); j++) {
        list.add("Data:$i".text().container(
              padding: const EdgeInsets.all(kXh),
              color: Colors.blue,
            ));
      }
    }
    return list;
  }
}
