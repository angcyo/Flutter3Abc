part of '../flutter3_abc.dart';

///
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2024/04/20
///

class FlowLayoutAbc extends StatefulWidget {
  const FlowLayoutAbc({super.key});

  @override
  State<FlowLayoutAbc> createState() => _FlowLayoutAbcState();
}

class _FlowLayoutAbcState extends State<FlowLayoutAbc> with BaseAbcStateMixin {
  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      "正常布局↓".text(textAlign: TextAlign.center),
      [
        GradientButton.normal(() {}, child: ("button" * 1).text()),
        GradientButton.normal(() async {}, child: ("button" * 2).text()),
        GradientButton.normal(() async {}, child: ("button" * 3).text()),
        GradientButton.normal(() async {}, child: ("button" * 4).text()),
        GradientButton.normal(() async {}, child: ("button" * 5).text()),
      ].flowLayout(childGap: kH)!,
      "正常布局+等宽↓".text(textAlign: TextAlign.center),
      [
        GradientButton.normal(() {}, child: ("button" * 1).text()),
        GradientButton.normal(() async {}, child: ("button" * 2).text()),
        GradientButton.normal(() async {}, child: ("button" * 3).text()),
        GradientButton.normal(() async {}, child: ("button" * 4).text()),
        GradientButton.normal(() async {}, child: ("button" * 5).text()),
      ].flowLayout(childGap: kH, equalWidthRange: "")!,
      "正常布局+右对齐↓".text(textAlign: TextAlign.center),
      [
        GradientButton.normal(() {}, child: ("button\nbutton" * 1).text()),
        GradientButton.normal(() async {},
            child: ("button\nbutton" * 2).text()),
        GradientButton.normal(() async {},
            child: ("button\nbutton" * 1).text()),
        GradientButton.normal(() async {},
            child: ("button\nbutton" * 1).text()),
        GradientButton.normal(() async {},
            child: ("button\nbutton" * 1).text()),
      ].flowLayout(
        childGap: kH,
        mainAxisAlignment: MainAxisAlignment.end,
        lineMainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
      )!,
      "正常布局+padding↓".text(textAlign: TextAlign.center),
      [
        GradientButton.normal(() {}, child: ("button" * 1).text()),
        GradientButton.normal(() async {}, child: ("button" * 2).text()),
        GradientButton.normal(() async {}, child: ("button" * 3).text()),
        GradientButton.normal(() async {}, child: ("button" * 4).text()),
        GradientButton.normal(() async {}, child: ("button" * 5).text()),
      ].flowLayout(childGap: kH, padding: const EdgeInsets.all(kX))!,
      "正常布局+滚动body↓".text(textAlign: TextAlign.center),
      [
        GradientButton.normal(() {}, child: ("button" * 1).text()),
        GradientButton.normal(() async {}, child: ("button" * 2).text()),
        GradientButton.normal(() async {}, child: ("button" * 3).text()),
        GradientButton.normal(() async {}, child: ("button" * 4).text()),
        GradientButton.normal(() async {}, child: ("button" * 5).text()),
      ].flowLayout(childGap: kH)!.scroll(scrollDirection: Axis.horizontal),
      "正常布局+等宽+每行2个↓".text(textAlign: TextAlign.center),
      [
        GradientButton.normal(() {}, child: ("button\nbutton" * 1).text()),
        GradientButton.normal(() async {},
            child: ("button\nbutton" * 2).text()),
        GradientButton.normal(() async {},
            child: ("button\nbutton" * 3).text()),
        GradientButton.normal(() async {},
            child: ("button\nbutton" * 4).text()),
        GradientButton.normal(() async {},
            child: ("button\nbutton" * 5).text()),
      ].flowLayout(
        childGap: kH,
        equalWidthRange: "",
        padding: const EdgeInsets.all(kX),
        lineMaxChildCount: 2,
        mainAxisAlignment: MainAxisAlignment.end,
        lineMainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
      )!,
      "正常布局+等宽+行等高+每行2个↓".text(textAlign: TextAlign.center),
      [
        GradientButton.normal(() {}, child: ("button\nbutton" * 1).text()),
        GradientButton.normal(() async {},
            child: ("button\nbutton" * 2).text()),
        GradientButton.normal(() async {},
            child: ("button\nbutton" * 3).text()),
        GradientButton.normal(() async {},
            child: ("button\nbutton" * 4).text()),
        GradientButton.normal(() async {},
            child: ("button\nbutton" * 5).text()),
      ].flowLayout(
        childGap: kH,
        equalWidthRange: "",
        padding: const EdgeInsets.all(kX),
        lineMaxChildCount: 2,
        mainAxisAlignment: MainAxisAlignment.end,
        lineMainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        matchLineHeight: true,
      )!,
    ];
  }
}
