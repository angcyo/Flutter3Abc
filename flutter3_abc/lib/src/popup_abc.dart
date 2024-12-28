part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/05/15
///

class PopupAbc extends StatefulWidget {
  const PopupAbc({super.key});

  @override
  State<PopupAbc> createState() => _PopupAbcState();
}

class _PopupAbcState extends State<PopupAbc>
    with BaseAbcStateMixin, OverlayManageMixin {
  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      "ArrowLayout↓".text(
        textAlign: TextAlign.center,
      ),
      [
        ArrowLayout(
          arrowDirection: AxisDirection.left,
          arrowDirectionOffset: 35,
          child: "left->text\nangcyo".text(),
        ),
        ArrowLayout(
          arrowDirection: AxisDirection.up,
          arrowDirectionOffset: 35,
          child: "up->text\nangcyo".text(),
        ),
        ArrowLayout(
          arrowDirection: AxisDirection.right,
          arrowDirectionOffset: 35,
          child: "right->text\nangcyo".text(),
        ),
        ArrowLayout(
          arrowDirection: AxisDirection.down,
          arrowDirectionOffset: 35,
          child: "down->text\nangcyo".text(),
        ),
      ].flowLayout()!,
      "PopupRoute↓".text(
        textAlign: TextAlign.center,
      ),
      _buildPopupRouteButtonList().flowLayout(childGap: kX)!,
      "PopupOverlay↓".text(
        textAlign: TextAlign.center,
      ),
      _buildPopupOverlayButtonList().flowLayout(childGap: kX)!,
      [
        "PopupRoute↓".text(
          textAlign: TextAlign.center,
        ),
        _buildPopupRouteButtonList().flowLayout(childGap: kX)!,
        "PopupOverlay↓".text(
          textAlign: TextAlign.center,
        ),
        _buildPopupOverlayButtonList().flowLayout(childGap: kX)!,
      ]
          .column()!
          .wh(double.infinity, 220)
          .align(Alignment.bottomCenter)
          .rFill(),
    ];
  }

  WidgetList _buildPopupRouteButtonList() {
    return [
      GradientButton.normal(() {}, onContextTap: (context) {
        context.showArrowPopupRoute(
          "auto->text\nangcyo".text(),
          anchorChild: context,
        );
      }, child: "showPopup".text()),
      GradientButton.normal(() {}, onContextTap: (context) {
        context.showArrowPopupRoute(
          "left->text\nangcyo".text(),
          arrowDirection: AxisDirection.left,
          anchorChild: context,
        );
      }, child: "left->showPopup".text()),
      GradientButton.normal(() {}, onContextTap: (context) {
        context.showArrowPopupRoute(
          "right->text\nangcyo".text(),
          arrowDirection: AxisDirection.right,
          anchorChild: context,
        );
      }, child: "right->showPopup".text()),
      GradientButton.normal(() {}, onContextTap: (context) {
        context.showArrowPopupRoute(
          "up->text\nangcyo".text(),
          arrowDirection: AxisDirection.up,
          anchorChild: context,
        );
      }, child: "up->showPopup".text()),
      GradientButton.normal(() {}, onContextTap: (context) {
        context.showArrowPopupRoute(
          "down->text\nangcyo".text(),
          arrowDirection: AxisDirection.down,
          anchorChild: context,
        );
      }, child: "down->showPopup".text())
    ];
  }

  WidgetList _buildPopupOverlayButtonList() {
    return [
      GradientButton.normal(() {}, onContextTap: (context) {
        hookOverlayEntry(context.showArrowPopupOverlay(
          "auto->text\nangcyo".text(),
          anchorChild: context,
        ));
      }, child: "showPopup".text()),
      GradientButton.normal(() {}, onContextTap: (context) {
        hookOverlayEntry(context.showArrowPopupOverlay(
          "left->text\nangcyo".text(),
          arrowDirection: AxisDirection.left,
          anchorChild: context,
        ));
      }, child: "left->showPopup".text()),
      GradientButton.normal(() {}, onContextTap: (context) {
        hookOverlayEntry(context.showArrowPopupOverlay(
          "right->text\nangcyo".text(),
          arrowDirection: AxisDirection.right,
          anchorChild: context,
        ));
      }, child: "right->showPopup".text()),
      GradientButton.normal(() {}, onContextTap: (context) {
        hookOverlayEntry(context.showArrowPopupOverlay(
          "up->text\nangcyo".text(),
          arrowDirection: AxisDirection.up,
          anchorChild: context,
        ));
      }, child: "up->showPopup".text()),
      GradientButton.normal(() {}, onContextTap: (context) {
        hookOverlayEntry(context.showArrowPopupOverlay(
          "down->text\nangcyo".text(),
          arrowDirection: AxisDirection.down,
          anchorChild: context,
        ));
      }, child: "down->showPopup".text())
    ];
  }
}
