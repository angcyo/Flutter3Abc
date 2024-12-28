part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/12/25
///

class WheelAbc extends StatefulWidget {
  const WheelAbc({super.key});

  @override
  State<WheelAbc> createState() => _WheelAbcState();
}

class _WheelAbcState extends State<WheelAbc> with BaseAbcStateMixin {
  WidgetList buildItems() {
    return [
      for (var i = 0; i < 10; i++)
        Text('$i', textAlign: TextAlign.center).align(Alignment.center),
    ];
  }

  final _itemExtent = 40.0;
  int _selectedFruit = 3;

  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      "WheelPicker↓".text(textAlign: TextAlign.center),
      Wheel(
        itemExtent: _itemExtent,
        children: buildItems(),
      ).container(color: randomColor()),
      Wheel(
        looping: true,
        size: 300,
        itemExtent: _itemExtent,
        children: buildItems(),
      ).container(color: randomColor()),
      "ListWheelScrollView↓".text(textAlign: TextAlign.center),
      ListWheelScrollView(
        itemExtent: _itemExtent,
        overAndUnderCenterOpacity: 0.5,
        diameterRatio: 0.8,
        physics: const FixedExtentScrollPhysics(),
        controller: FixedExtentScrollController(),
        children: buildItems(),
      ).size(height: 200).container(color: randomColor()),
      "ListWheelScrollViewX↓".text(textAlign: TextAlign.center),
      ListWheelScrollViewX(
        itemExtent: _itemExtent,
        overAndUnderCenterOpacity: 0.5,
        diameterRatio: 0.8,
        scrollDirection: Axis.horizontal,
        children: buildItems(),
      ).size(height: 200).container(color: randomColor()),
      ListWheelScrollViewX(
        itemExtent: _itemExtent,
        overAndUnderCenterOpacity: 0.5,
        diameterRatio: 0.8,
        scrollDirection: Axis.vertical,
        children: buildItems(),
      ).size(height: 200).container(color: randomColor()),
      "CupertinoPicker↓".text(textAlign: TextAlign.center),
      CupertinoPicker(
        magnification: 1.22,
        squeeze: 1.2,
        useMagnifier: true,
        itemExtent: _itemExtent,
        // This sets the initial item.
        scrollController: FixedExtentScrollController(
          initialItem: _selectedFruit,
        ),
        // This is called when selected item is changed.
        onSelectedItemChanged: (int selectedItem) {
          /*setState(() {
            _selectedFruit = selectedItem;
          });*/
        },
        children: buildItems(),
      ).size(height: 200),
    ];
  }
}
