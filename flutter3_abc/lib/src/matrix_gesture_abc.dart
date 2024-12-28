part of '../flutter3_abc.dart';

///
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2024/04/04
///
class MatrixGestureAbc extends StatefulWidget {
  const MatrixGestureAbc({super.key});

  @override
  State<MatrixGestureAbc> createState() => _MatrixGestureAbcState();
}

class _MatrixGestureAbcState extends State<MatrixGestureAbc>
    with BaseAbcStateMixin, SingleTickerProviderStateMixin, AbcWidgetMixin {
  Matrix4 transform1 = Matrix4.identity();
  Matrix4 transform2 = Matrix4.identity();

  ScrollController get _scrollController => listViewController;

  @override
  bool get useScroll => false;

  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      "MatrixGestureDetector↓".text(),
      MatrixGestureDetector(
        onMatrixUpdate: (
          matrix,
          translationDeltaMatrix,
          scaleDeltaMatrix,
          rotationDeltaMatrix,
        ) {
          transform1 = matrix;
          //l.d(matrix);
          updateState();
        },
        child: Container(
          color: Colors.blue,
          height: 300,
        ).matrix(transform1),
      ),
      "GestureDetector↓".text(),
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onVerticalDragUpdate: (details) {
          _handleDragUpdate(details.delta.dy);
        },
        onVerticalDragEnd: (details) {
          _handleDragEnd(details.primaryVelocity ?? 0);
        },
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            //l.d(notification);
            _handleScrollUpdate(notification);
            return false;
          },
          child: Container(
            color: Colors.green,
            height: 300,
            child: buildListView(),
          ).matrix(transform2),
        ),
      ).childKeyed(_childKey),
    ];
  }

  bool isDragging = true;
  bool _dismissUnderway = false;

  final GlobalKey _childKey = GlobalKey(debugLabel: 'BottomSheet child');

  late final AnimationController animationController =
      AnimationController(vsync: this);

  double? get _childHeight {
    final childContext = _childKey.currentContext;
    final renderBox = childContext?.findRenderObject() as RenderBox;
    return renderBox.size.height;
  }

  /// [primaryDelta] 手势每次移动的距离
  void _handleDragUpdate(double primaryDelta) async {
    if (_dismissUnderway) return;
    isDragging = true;

    final progress = primaryDelta / (_childHeight ?? primaryDelta);
    l.d('progress:$progress [$primaryDelta/$_childHeight]');

    transform2.translate(0.0, primaryDelta, 0.0);
    animationController.value -= progress;

    updateState();
  }

  final double minFlingVelocity = 500.0;
  final double closeProgressThreshold = 0.6;

  bool get hasReachedCloseThreshold =>
      animationController.value < closeProgressThreshold;

  void _handleDragEnd(double velocity) async {
    if (_dismissUnderway || !isDragging) return;
    isDragging = false;

    // If speed is bigger than _minFlingVelocity try to close it
    if (velocity > minFlingVelocity) {
      toastInfo('close:${velocity}');
      //tryClose();
    } else if (hasReachedCloseThreshold) {
      if (animationController.value > 0.0) {
        animationController.fling(velocity: -1.0);
      }
      toastInfo('close2:${velocity}');
    } else {
      toastInfo('cancel close:${velocity}');
    }
  }

  // As we cannot access the dragGesture detector of the scroll view
  // we can not know the DragDownDetails and therefore the end velocity.
  // VelocityTracker it is used to calculate the end velocity  of the scroll
  // when user is trying to close the modal by dragging
  VelocityTracker? _velocityTracker;
  DateTime? _startTime;

  void _handleScrollUpdate(ScrollNotification notification) {
    //debugger();
    assert(notification.context != null);
    //Check if scrollController is used
    if (!_scrollController.hasClients) return;

    ScrollPosition scrollPosition;

    if (_scrollController.positions.length > 1) {
      scrollPosition = _scrollController.positions.firstWhere(
          (p) => p.isScrollingNotifier.value,
          orElse: () => _scrollController.positions.first);
    } else {
      scrollPosition = _scrollController.position;
    }

    if (scrollPosition.axis == Axis.horizontal) return;

    final isScrollReversed = scrollPosition.axisDirection == AxisDirection.down;
    final offset = isScrollReversed
        ? scrollPosition.pixels
        : scrollPosition.maxScrollExtent - scrollPosition.pixels;

    DragUpdateDetails? dragDetails;
    if (notification is ScrollUpdateNotification) {
      dragDetails = notification.dragDetails;
    }
    if (notification is OverscrollNotification) {
      dragDetails = notification.dragDetails;
    }

    l.d('offset:$offset ${dragDetails?.delta.dy} ${_scrollController.offset}');
    if (offset <= 0) {
      // Clamping Scroll Physics end with a ScrollEndNotification with a DragEndDetail class
      // while Bouncing Scroll Physics or other physics that Overflow don't return a drag end info

      // We use the velocity from DragEndDetail in case it is available
      if (notification is ScrollEndNotification) {
        final dragDetails = notification.dragDetails;
        if (dragDetails != null) {
          _handleDragEnd(dragDetails.primaryVelocity ?? 0);
          _velocityTracker = null;
          _startTime = null;
          return;
        }
      }

      // Otherwise the calculate the velocity with a VelocityTracker
      if (_velocityTracker == null) {
        final pointerKind = defaultPointerDeviceKind(context);
        _velocityTracker = VelocityTracker.withKind(pointerKind);
        _startTime = DateTime.now();
      }

      assert(_velocityTracker != null);
      assert(_startTime != null);
      final startTime = _startTime!;
      final velocityTracker = _velocityTracker!;
      //debugger();
      if (dragDetails != null) {
        final duration = startTime.difference(DateTime.now());
        velocityTracker.addPosition(duration, Offset(0, offset));
        _handleDragUpdate(dragDetails.delta.dy);
      } else if (isDragging) {
        final velocity = velocityTracker.getVelocity().pixelsPerSecond.dy;
        _velocityTracker = null;
        _startTime = null;
        _handleDragEnd(velocity);
      }
    } else {
      //debugger();
      postCallback(() {
        //_scrollController.jumpTo(100);
      });
    }
  }
}

// Checks the device input type as per the OS installed in it
// Mobile platforms will be default to `touch` while desktop will do to `mouse`
// Used with VelocityTracker
// https://github.com/flutter/flutter/pull/64267#issuecomment-694196304
PointerDeviceKind defaultPointerDeviceKind(BuildContext context) {
  final platform = Theme.of(context).platform; // ?? defaultTargetPlatform;
  switch (platform) {
    case TargetPlatform.iOS:
    case TargetPlatform.android:
      return PointerDeviceKind.touch;
    case TargetPlatform.linux:
    case TargetPlatform.macOS:
    case TargetPlatform.windows:
      return PointerDeviceKind.mouse;
    case TargetPlatform.fuchsia:
      return PointerDeviceKind.unknown;
  }
}
