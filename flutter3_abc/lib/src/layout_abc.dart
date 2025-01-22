part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/10/22
///

class LayoutAbc extends StatefulWidget {
  const LayoutAbc({super.key});

  @override
  State<LayoutAbc> createState() => _LayoutAbcState();
}

class _LayoutAbcState extends State<LayoutAbc> with BaseAbcStateMixin {
  @override
  WidgetList buildBodyList(BuildContext context) {
    return [
      $any(
          child: Text("angcyo"),
          onPaint: (render, canvas, size, offset) {
            canvas.drawCircle(
              size.center(offset),
              20,
              Paint()..color = Colors.red,
            );
          }).size(height: 200),
      /*DynamicLayoutBuilder(
        builder: (context, constraints, condition) {
          if (condition is String) {
            return Text(condition);
          }
          return Row(
            children: [Text("$condition")],
          );
        },
        initCondition: "--init--",
      ).size(height: 200),*/
      DynamicContainerLayoutBuilder(
        builder: (context, constraints, condition) {
          //debugger();
          if (condition is String) {
            return Text(condition);
          }
          return Row(
            children: [
              Text("$condition"),
              GradientButton.normal(() {
                toastBlur(text: "click");
              }, child: "Button".text()),
            ],
          ).center(
            widthFactor: nextDouble(0.5),
            heightFactor: nextDouble(0.5),
          );
        },
        initCondition: "--init--",
        children: [
          paintWidget(
            (canvas, size) {
              //debugger();
              canvas.drawCircle(
                  size.center(Offset.zero), 20, Paint()..color = Colors.red);
            },
          ),
          /*GradientButton.normal(() {
            toastBlur(text: "click");
          }, child: "Button".text()),
          Text("${nextInt()}"),*/
        ],
      ).size(height: 200),
      GridOptionWidget().ratio(1 / 1),
    ];
  }
}
