part of '../flutter3_abc.dart';

///
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2023/11/05
///

class SegmentedAbc extends StatefulWidget {
  const SegmentedAbc({super.key});

  @override
  State<SegmentedAbc> createState() => _SegmentedAbcState();
}

class _SegmentedAbcState extends State<SegmentedAbc> with BaseAbcStateMixin {
  var segments = [
    const ButtonSegment(value: "Value1", label: Text("Label1")),
    const ButtonSegment(value: "Value2", label: Text("Label2 Label2 Label2")),
    const ButtonSegment(value: "Value3", label: Text("Label3 Label3 Label3")),
    const ButtonSegment(
        value: "Value4", label: Text("Label4 Label4 Label4 Label4")),
  ];
  var segmentsSingle = [
    const ButtonSegment(value: "Value1", label: Text("Label1")),
    const ButtonSegment(value: "Value2", label: Text("Label2")),
    const ButtonSegment(value: "Value3", label: Text("Label3")),
    const ButtonSegment(value: "Value4", label: Text("Label4")),
  ];
  var selectedSingle = {
    "Value1",
  };
  var selectedSingleEmpty = {
    "Value1",
  };
  var selectedMulti = {
    "Value1",
    "Value2",
  };
  var selectedMultiEmpty = {
    "Value1",
    "Value2",
  };

  var segmentMap = {
    "Value1": const Text("Value1"),
    "Value2": const Text("Value2"),
    "Value3": const Text("Value3"),
    "Value4": const Text("Value4"),
  };

  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      const Text(
        "单选-不可为空↓",
        textAlign: TextAlign.center,
      ),
      SegmentedButton<String>(
        segments: segmentsSingle,
        selected: selectedSingle,
        style: const ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap, //收紧大小
          visualDensity: VisualDensity(horizontal: -4, vertical: -4), //最小视觉密度
        ),
        onSelectionChanged: (value) {
          setState(() {
            selectedSingle = value;
          });
        },
        selectedIcon: const Icon(Icons.ac_unit),
        multiSelectionEnabled: false,
        emptySelectionAllowed: false,
      ),
      const Text(
        "单选-可为空↓",
        textAlign: TextAlign.center,
      ),
      SegmentedButton<String>(
        segments: segments,
        selected: selectedSingleEmpty,
        onSelectionChanged: (value) {
          setState(() {
            selectedSingleEmpty = value;
          });
        },
        multiSelectionEnabled: false,
        emptySelectionAllowed: true,
        selectedIcon: const Icon(Icons.access_alarm),
      ),
      const Text(
        "多选-不可为空↓",
        textAlign: TextAlign.center,
      ),
      SegmentedButton<String>(
        segments: segments,
        selected: selectedMulti,
        onSelectionChanged: (value) {
          setState(() {
            selectedMulti = value;
          });
        },
        multiSelectionEnabled: true,
        emptySelectionAllowed: false,
      ),
      const Text(
        "多选-可为空↓",
        textAlign: TextAlign.center,
      ),
      ConstrainedBox(
        constraints: const BoxConstraints.tightFor(),
        child: SegmentedButton<String>(
          segments: segmentsSingle,
          selected: selectedMultiEmpty,
          style: const ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap, //收紧大小
            visualDensity: VisualDensity(horizontal: -4, vertical: -4), //最小视觉密度
            //minimumSize: MaterialStateProperty.all(const Size(0, 0)),
            //maximumSize: MaterialStateProperty.all(const Size(0, 0)),
          ),
          onSelectionChanged: (value) {
            setState(() {
              selectedMultiEmpty = value;
            });
          },
          multiSelectionEnabled: true,
          emptySelectionAllowed: true,
          selectedIcon: const Icon(Icons.accessibility),
        ),
      ),
      const Text(
        "CupertinoSegmentedControl↓",
        textAlign: TextAlign.center,
      ),
      CupertinoSegmentedControl(
        children: segmentMap,
        groupValue: currentValue,
        onValueChanged: onValueChanged,
      ),
      const Text(
        "CupertinoSlidingSegmentedControl↓",
        textAlign: TextAlign.center,
      ),
      CupertinoSlidingSegmentedControl(
        children: segmentMap,
        groupValue: currentValue,
        onValueChanged: onValueChanged,
      )
    ];
  }
}
