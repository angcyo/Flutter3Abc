part of '../flutter3_abc.dart';

///
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2024/06/10
///
class DraggableAbc extends StatefulWidget {
  const DraggableAbc({super.key});

  @override
  State<DraggableAbc> createState() => _DraggableAbcState();
}

class _DraggableAbcState extends State<DraggableAbc> with BaseAbcStateMixin {
  @override
  WidgetList buildBodyList(BuildContext context) {
    return [
      Draggable(
        data: "data1",
        feedback: "feedback1".text().min().material(),
        childWhenDragging: "childWhenDragging1".text().min(),
        child: "Draggable1".text().min(),
      ),
      horizontalLine(context),
      Empty.height(30),
      Draggable(
        data: "data2",
        feedback: "feedback2".text().min().material(),
        childWhenDragging: "childWhenDragging2".text().min(),
        child: "Draggable2".text().min(),
      ),
      horizontalLine(context),
      Empty.height(30),
      Draggable(
        data: "data3",
        feedback: "feedback3".text().min().material(),
        childWhenDragging: "childWhenDragging3".text().min(),
        child: "Draggable3".text().min(),
      ),
      horizontalLine(context),
      Empty.height(30),
      Draggable(
        data: "data4",
        feedback: "feedback4".text().min().material(),
        childWhenDragging: "childWhenDragging4".text().min(),
        child: "Draggable4".text().min(),
      ),
      horizontalLine(context),
      Empty.height(50),
      DragTarget(
        builder: (context, candidateData, rejectedData) {
          //candidateData:感兴趣的数据
          //rejectedData:不感兴趣的数据
          l.d("1: candidateData:$candidateData rejectedData:$rejectedData");
          return "$candidateData\n$rejectedData".text().min().material();
        },
        onWillAcceptWithDetails: (details) {
          //拖拽的数据进入时, 是否感兴趣?
          //拖拽的数据是否感兴趣
          l.d("1: onWillAcceptWithDetails:$details");
          return true;
        },
        onAcceptWithDetails: (details) {
          l.d("1: onAcceptWithDetails:$details");
        },
        onLeave: (data) {
          //拖拽的数据离开时, 就会触发回调
          l.d("1: onLeave:$data");
        },
        onMove: (details) {
          //在目标上移动时, 就会触发回调
          //l.d("1: onMove:$details");
        },
      ),
      horizontalLine(context),
      Empty.height(50),
      DragTarget(
        builder: (context, candidateData, rejectedData) {
          l.d("2: candidateData:$candidateData rejectedData:$rejectedData");
          return "$candidateData\n$rejectedData".text().min().material();
        },
        onWillAcceptWithDetails: (details) {
          l.d("2: onWillAcceptWithDetails:$details");
          return false;
        },
        onAcceptWithDetails: (details) {
          l.d("2: onAcceptWithDetails:$details");
        },
        onLeave: (data) {
          l.d("2: onLeave:$data");
        },
        onMove: (details) {
          //l.d("2: onMove:$details");
        },
      ),
    ];
  }
}
