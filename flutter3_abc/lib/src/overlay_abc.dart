part of '../../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/11/09
///

class OverlayAbc extends StatefulWidget {
  const OverlayAbc({super.key});

  @override
  State<OverlayAbc> createState() => _OverlayAbcState();
}

class _OverlayAbcState extends State<OverlayAbc> with BaseAbcStateMixin {
  List<ButtonSegment<OverlayAnimate>> animateList = [
    const ButtonSegment(
        value: OverlayAnimate.topSlide, label: Text('topSlide')),
    const ButtonSegment(
        value: OverlayAnimate.bottomSlide, label: Text('bottomSlide')),
    const ButtonSegment(value: OverlayAnimate.opacity, label: Text('opacity')),
    const ButtonSegment(value: OverlayAnimate.scale, label: Text('scale')),
    const ButtonSegment(value: OverlayAnimate.none, label: Text('none')),
  ];
  Set<OverlayAnimate> animateSet = {OverlayAnimate.topSlide};

  @override
  List<Widget> buildBodyList(BuildContext context) {
    Widget textSpan = textSpanBuilder((builder) {
      builder.addWidget(const Icon(Icons.add));
      builder.addText(randomString(10));
      builder.addWidget(const Icon(Icons.ac_unit));
    });

    WidgetList buttonList = [
      GradientButton.normal(
        () {
          showLoading(context: context);
          delayCallback(
            () => hideLoading(),
            const Duration(seconds: 2),
          );
        },
        child: const Text('显示加载'),
      ),
      GradientButton.normal(
        () {
          hideLoading();
        },
        child: const Text('关闭加载'),
      ),
      GradientButton.normal(
        () {
          wrapLoading(Future.delayed(2.seconds));
        },
        child: const Text('wrapLoading'),
      ),
      GradientButton.normal(
        () {
          wrapLoading(Future.delayed(5.seconds), timeout: 2.seconds);
        },
        child: const Text('wrapLoadingTimeout'),
      ),
      GradientButton.normal(
        () {
          //wrapLoading(Future.delayed(2.seconds));
          showStrokeLoading(context: context);
          delayCallback(
            () => hideLoading(),
            const Duration(seconds: 2),
          );
        },
        child: const Text('strokeLoading'),
      ),
      GradientButton.normal(
        () {
          showOverlay((entry, state, context, progress) => randomTextWidget());
        },
        child: const Text('显示一个Overlay'),
      ),
      GradientButton.normal(
        () {
          showNotification((context) => randomTextWidget(),
              position: OverlayPosition.top);
        },
        child: const Text('显示一个Overlay(顶部)'),
      ),
      GradientButton.normal(
        () {
          showNotification((context) => randomTextWidget(),
              position: OverlayPosition.bottom);
        },
        child: const Text('显示一个Overlay(底部)'),
      ),
      GradientButton.normal(
        () {
          showNotification((context) => randomTextWidget(),
              position: OverlayPosition.center);
        },
        child: const Text('显示一个Overlay(居中)'),
      ),
      SegmentedButton<OverlayAnimate>(
        segments: animateList,
        selected: animateSet,
        onSelectionChanged: (value) {
          setState(() {
            animateSet = value;
          });
        },
        emptySelectionAllowed: false,
      ),
      GradientButton.normal(
        () {
          showSimpleNotification(
            randomTextWidget(),
            animate: animateSet.first,
          );
        },
        child: const Text('显示一个简单通知(文本)'),
      ),
      GradientButton.normal(
        () {
          showSimpleNotification(
            randomTextWidget(),
            leading: const Icon(Icons.ac_unit),
            animate: animateSet.first,
          );
        },
        child: const Text('显示一个简单通知(文本+Ico)'),
      ),
      GradientButton.normal(
        () {
          showSimpleNotification(
            textSpan,
            animate: animateSet.first,
          );
        },
        child: const Text('显示一个简单通知(文本+SpanIco)'),
      ),
      GradientButton.normal(
        () {
          toast(
            randomTextWidget(length: 50),
            position: OverlayPosition.top,
            animate: animateSet.first,
          );
        },
        child: const Text('显示一个toast(top)'),
      ),
      GradientButton.normal(
        () {
          toast(
            randomTextWidget(length: 50),
            animate: animateSet.first,
          );
        },
        child: const Text('显示一个toast(bottom)'),
      ),
      GradientButton.normal(
        () {
          toast(
            randomTextWidget(length: 50),
            position: OverlayPosition.center,
            animate: animateSet.first,
          );
        },
        child: const Text('显示一个toast(center)'),
      ),
      GradientButton.normal(
        () {
          toast(
            textSpan,
            position: OverlayPosition.center,
            animate: animateSet.first,
          );
        },
        child: const Text('显示一个toast(center+span)'),
      ),
      GradientButton.normal(
        () {
          toastMessage(
            textSpan,
            position: OverlayPosition.top,
            animate: animateSet.first,
          );
        },
        child: const Text('toastMessage(textSpan)'),
      ),
      GradientButton.normal(
        () {
          toastMessage(
            randomTextWidget(length: 50),
            position: OverlayPosition.top,
            animate: animateSet.first,
          );
        },
        child: const Text('toastMessage(text)'),
      ),
      GradientButton.normal(
        () {
          toastInfo(randomText(50));
        },
        child: const Text('toastInfo'),
      ),
      GradientButton.normal(
        () {
          //Loader.show(context);
        },
        child: const Text('Test1'),
      ),
      GradientButton.normal(
        () {
          //Loader.hide();
        },
        child: const Text('Test2'),
      ),
    ];

    return [
      buttonList.wrap()!.paddingAll(8),
    ];
  }
}
