part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/12/22
///

class SlideAbc extends StatefulWidget {
  const SlideAbc({super.key});

  @override
  State<SlideAbc> createState() => _SlideAbcState();
}

class _SlideAbcState extends State<SlideAbc> with BaseAbcStateMixin {
  List<SlidableAction> get startActions1 => [
        slideAction(label: "Action1", backgroundColor: Colors.blue),
      ];

  List<SlidableAction> get endActions1 => [
        slideAction(label: "Text1", backgroundColor: Colors.purple),
      ];

  List<SlidableAction> get startActions2 => [
        slideAction(label: "Action1", backgroundColor: Colors.blue),
        slideAction(label: "Action2", backgroundColor: Colors.green),
      ];

  List<SlidableAction> get endActions2 => [
        slideAction(
            label: "Text1",
            icon: Icons.construction,
            backgroundColor: Colors.purple),
        slideAction(
            label: "Text2",
            icon: Icons.account_circle_rounded,
            backgroundColor: Colors.orange),
      ];

  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      "无滑动菜单".text().paddingAll(kX).slideActions(),
      Empty.height(kX),
      "左边1个滑动菜单"
          .text()
          .paddingAll(kX)
          .container(color: randomColor())
          .matchParent(matchHeight: false)
          .slideActions(startActions: startActions1, startExtentRatio: 0.3),
      Empty.height(kX),
      "右边1个滑动菜单"
          .text()
          .paddingAll(kX)
          .container(color: randomColor())
          .matchParent(matchHeight: false)
          .slideActions(endActions: endActions1, endExtentRatio: 0.3),
      Empty.height(kX),
      "左边2个滑动菜单"
          .text()
          .paddingAll(kX)
          .container(color: randomColor())
          .matchParent(matchHeight: false)
          .slideActions(startActions: startActions2),
      Empty.height(kX),
      "右边2个滑动菜单"
          .text()
          .paddingAll(kX)
          .container(color: randomColor())
          .matchParent(matchHeight: false)
          .slideActions(endActions: endActions2),
      Empty.height(kX),
      "左右各1个菜单"
          .text()
          .paddingAll(kX)
          .container(color: Colors.redAccent)
          .matchParent(matchHeight: false)
          .slideActions(
            startActions: startActions1,
            endActions: endActions1,
          ),
      Empty.height(kX),
      "左右各2个菜单"
          .text()
          .paddingAll(kX)
          .container(color: Colors.redAccent)
          .matchParent(matchHeight: false)
          .slideActions(
            startActions: startActions2,
            endActions: endActions2,
          ),
      Empty.height(kX),
      "左右各2个菜单~Dismissible"
          .text()
          .paddingAll(kX)
          .container(color: Colors.redAccent)
          .matchParent(matchHeight: false)
          .slideActions(
            key: const ValueKey("左右各2个菜单~Dismissible"),
            onStartDismissed: () {
              l.i("onStartDismissed");
            },
            onEndDismissed: () {
              l.i("onEndDismissed");
            },
            startActions: startActions2,
            endActions: endActions2,
          ),
      Empty.height(kX),
      "上下各2个菜单~Dismissible"
          .text()
          .paddingAll(kX)
          .container(color: Colors.redAccent, height: 300)
          .matchParent(matchHeight: false)
          .slideActions(
            key: const ValueKey("上下各2个菜单~Dismissible"),
            direction: Axis.vertical,
            onStartDismissed: () {
              l.i("onStartDismissed");
            },
            onEndDismissed: () {
              l.i("onEndDismissed");
            },
            startActions: startActions2,
            endActions: endActions2,
          ),
      Empty.height(kX),
      "~~~".text().paddingAll(kX).container(color: Colors.redAccent),
    ];
  }
}
