part of '../../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/11/07
///

/// [PageView]
/// [Swiper]
/// [TransformerPageView]
class PageAbc extends StatefulWidget {
  const PageAbc({super.key});

  @override
  State<PageAbc> createState() => _PageAbcState();
}

class _PageAbcState extends State<PageAbc> with BaseAbcStateMixin {
  @override
  bool get enableFrameLoad => true;

  final PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
    viewportFraction: 1,
  );

  final PageController pageController2 = PageController(
    initialPage: 0,
    keepPage: true,
    viewportFraction: 0.8,
  );

  final SwiperController swiperController = SwiperController();

  late List<Widget> pages;
  late final TransformerPageController transformerPageController;
  late final TransformerPageController transformerPageController2;

  final List<Color> backgroundColors = [
    const Color(0xffF67904),
    const Color(0xffD12D2E),
    const Color(0xff7A1EA1),
    const Color(0xff1773CF),
    const Color(0xffF67904),
    const Color(0xffD12D2E),
    const Color(0xff7A1EA1),
    const Color(0xff1773CF),
    const Color(0xffF67904),
    const Color(0xffD12D2E),
    const Color(0xff7A1EA1),
    const Color(0xff1773CF),
  ];

  @override
  void initState() {
    super.initState();
    pages = _buildPage();
    transformerPageController = TransformerPageController(
      initialPage: 0,
      keepPage: true,
      viewportFraction: 1,
      loop: true,
      itemCount: pages.length,
    );
    transformerPageController2 = TransformerPageController(
      initialPage: 0,
      keepPage: true,
      viewportFraction: 0.5,
      loop: true,
      itemCount: pages.length,
    );
    swiperController.startAutoplay();
  }

  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      const Text(
        "PageView↓",
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 100,
        child: Stack(
          children: [
            PageView(
              controller: pageController,
              physics: const AlwaysScrollableScrollPhysics(),
              /*physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),*/
              //开启后, 只能1页1页滑动. 否则可以直接滑到底
              pageSnapping: true,
              children: pages,
              onPageChanged: (index) {
                l.w("onPageChanged:$index");
              },
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: PageIndicator(
                    controller: pageController,
                    count: pages.length,
                  ),
                )),
          ],
        ),
      ),
      const Text(
        "PageView viewportFraction↓",
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 100,
        child: PageView(
          controller: pageController2,
          physics: const AlwaysScrollableScrollPhysics(),
          /*physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),*/
          //开启后, 只能1页1页滑动. 否则可以直接滑到底
          pageSnapping: true,
          children: pages,
          onPageChanged: (index) {
            l.w("onPageChanged:$index");
          },
        ),
      ),
      const Text(
        "PageView pageSnapping↓",
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 100,
        child: PageView(
          controller: pageController2,
          physics: const AlwaysScrollableScrollPhysics(),
          /*physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),*/
          //开启后, 只能1页1页滑动. 否则可以直接滑到底
          pageSnapping: false,
          children: pages,
          onPageChanged: (index) {
            l.w("onPageChanged:$index");
          },
        ),
      ),
      const Text(
        "PageView vertical↓",
        textAlign: TextAlign.center,
      ),
      UnconstrainedBox(
        child: SizedBox(
          width: 300,
          height: 200,
          child: PageView(
            scrollDirection: Axis.vertical,
            controller: pageController2,
            //开启后, 只能1页1页滑动. 否则可以直接滑到底
            pageSnapping: true,
            children: pages,
            onPageChanged: (index) {
              l.w("onPageChanged:$index");
            },
          ),
        ),
      ),
      const Text(
        "Swiper↓",
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 100,
        child: Swiper(
          itemCount: pages.length,
          itemBuilder: (context, index) {
            return pages[index];
          },
          loop: true,
          physics: const AlwaysScrollableScrollPhysics(),
          controller: swiperController,
          //control: const SwiperControl(),
          autoplay: true,
          pagination: const SwiperPagination(),
        ),
      ),
      const Text(
        "TransformerPageView↓",
        textAlign: TextAlign.center,
      ),
      SizedBox(
          height: 100,
          child: Stack(
            children: [
              TransformerPageView(
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return pages[index];
                },
                loop: true,
                physics: const AlwaysScrollableScrollPhysics(),
                pageSnapping: true,
                pageController: transformerPageController,
                onPageChanged: (index) {
                  l.w("onPageChanged:$index");
                },
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: PageIndicator(
                      controller: transformerPageController,
                      count: pages.length,
                    ),
                  )),
            ],
          )),
      const Text(
        "TransformerPageView ZoomInPageTransformer↓",
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 100,
        child: TransformerPageView(
          itemCount: pages.length,
          itemBuilder: (context, index) {
            return pages[index];
          },
          loop: true,
          transformer: ZoomInPageTransformer(),
          physics: const AlwaysScrollableScrollPhysics(),
          pageSnapping: true,
          pageController: transformerPageController2,
          onPageChanged: (index) {
            l.w("onPageChanged:$index");
          },
        ),
      ),
      const Text(
        "TransformerPageView ZoomOutPageTransformer↓",
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 100,
        child: TransformerPageView(
          itemCount: pages.length,
          itemBuilder: (context, index) {
            return pages[index];
          },
          loop: true,
          pageController: transformerPageController2,
          transformer: ZoomOutPageTransformer(),
          physics: const AlwaysScrollableScrollPhysics(),
          pageSnapping: true,
          onPageChanged: (index) {
            l.w("onPageChanged:$index");
          },
        ),
      ),
      const Text(
        "TransformerPageView DepthPageTransformer↓",
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 100,
        child: TransformerPageView(
          itemCount: pages.length,
          itemBuilder: (context, index) {
            return pages[index];
          },
          loop: true,
          transformer: DepthPageTransformer(),
          physics: const AlwaysScrollableScrollPhysics(),
          pageSnapping: true,
          onPageChanged: (index) {
            l.w("onPageChanged:$index");
          },
        ),
      ),
      const Text(
        "TransformerPageView AccordionTransformer↓",
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 100,
        child: TransformerPageView(
          itemCount: pages.length,
          itemBuilder: (context, index) {
            return pages[index];
          },
          loop: true,
          transformer: AccordionTransformer(),
          physics: const AlwaysScrollableScrollPhysics(),
          pageSnapping: true,
          onPageChanged: (index) {
            l.w("onPageChanged:$index");
          },
        ),
      ),
      const Text(
        "TransformerPageView ThreeDTransformer↓",
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 100,
        child: TransformerPageView(
          itemCount: pages.length,
          itemBuilder: (context, index) {
            return pages[index];
          },
          loop: true,
          transformer: ThreeDTransformer(),
          physics: const AlwaysScrollableScrollPhysics(),
          pageSnapping: true,
          onPageChanged: (index) {
            l.w("onPageChanged:$index");
          },
        ),
      ),
      const Text(
        "TransformerPageView ScaleAndFadeTransformer↓",
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 100,
        child: TransformerPageView(
          itemCount: pages.length,
          itemBuilder: (context, index) {
            return pages[index];
          },
          loop: true,
          transformer: ScaleAndFadeTransformer(),
          physics: const AlwaysScrollableScrollPhysics(),
          pageSnapping: true,
          onPageChanged: (index) {
            l.w("onPageChanged:$index");
          },
        ),
      ),
      const Text(
        "TransformerPageView PageTransformerBuilder↓",
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 100,
        child: TransformerPageView(
          itemCount: pages.length,
          itemBuilder: (context, index) {
            return pages[index];
          },
          loop: false,
          transformer: PageTransformerBuilder(builder: (child, info) {
            l.w('transformer->${child.classHash()}:${info.fromIndex},${info.index},${info.position}');
            return ParallaxColor(
              colors: backgroundColors,
              info: info,
              child: ParallaxContainer(
                  position: info.position ?? 0,
                  opacityFactor: 1.0,
                  translationFactor: 400.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "from:${info.fromIndex} to:${info.index} position:${info.position}",
                      textAlign: TextAlign.center,
                    ),
                  )),
            );
          }),
          physics: const AlwaysScrollableScrollPhysics(),
          pageSnapping: true,
          onPageChanged: (index) {
            l.w("onPageChanged:$index");
          },
        ),
      ),
    ];
  }

  List<Widget> _buildPage() {
    return [
      randomLogWidget("Page1"),
      randomLogWidget("Page2"),
      randomLogWidget("Page3"),
      randomImageWidget(),
      randomImagePlaceholderWidget(),
      randomImagePlaceholderWidget(),
      randomImageWidget(),
      randomImageWidget(),
      randomLogWidget("Page9"),
      randomLogWidget("Page10"),
    ];
  }
}
