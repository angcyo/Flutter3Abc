part of '../flutter3_abc.dart';

///
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2024/05/19
///

class AnimatedAbc extends StatefulWidget {
  const AnimatedAbc({super.key});

  @override
  State<AnimatedAbc> createState() => _AnimatedAbcState();
}

class _AnimatedAbcState extends State<AnimatedAbc> with BaseAbcStateMixin {
  final duration = const Duration(seconds: 1);
  double height1 = 100;
  double height2 = 100;
  Color color1 = Colors.redAccent;
  Color color2 = Colors.blueAccent;
  CrossFadeState crossFadeState = CrossFadeState.showFirst;

  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      "AnimatedContainer↓".text(textAlign: TextAlign.center),
      AnimatedContainer(
          duration: duration,
          /*width: width,*/
          height: height1,
          child: _buildAnimatedChild(height1, color1).click(() {
            setState(() {
              height1 = height1 == 100 ? 200 : 100;
            });
          })),
      "AnimatedSize↓".text(textAlign: TextAlign.center),
      Container(
        alignment: Alignment.bottomCenter,
        color: Colors.black26,
        child: AnimatedSize(
            duration: duration,
            child: _buildAnimatedChild(height2, color2).click(() {
              setState(() {
                height2 = height2 == 100 ? 200 : 100;
              });
            })),
      ),
      //内部使用[AnimatedSize]实现
      "AnimatedCrossFade↓".text(textAlign: TextAlign.center),
      AnimatedCrossFade(
              firstChild: _buildAnimatedChild(height1, color1),
              secondChild: _buildAnimatedChild(height2, color2),
              crossFadeState: crossFadeState,
              duration: duration)
          .click(() {
        setState(() {
          crossFadeState = crossFadeState == CrossFadeState.showFirst
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst;
        });
      }),
      //内部使用[FadeTransition]实现
      "AnimatedSwitcher↓".text(textAlign: TextAlign.center),
      AnimatedSwitcher(
        duration: duration,
        child: _buildAnimatedChild(
          nextInt(200, 100).toDouble(),
          randomColor(),
        ),
      ).click(() {
        updateState();
      }),
      //AnimatedModalBarrier(color: color)
      "↑".text(textAlign: TextAlign.center),
    ];
  }

  Widget _buildAnimatedChild(double height, Color color) {
    return Container(
      color: color,
      height: height,
      child: "高度:$height".text(textAlign: TextAlign.center).center(),
    );
  }
}
