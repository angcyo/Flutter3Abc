part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/12/27
///
/// https://github.com/flutterchina/nine_grid_view/blob/master/README-ZH.md

class NineGridAbc extends StatefulWidget {
  const NineGridAbc({super.key});

  @override
  State<NineGridAbc> createState() => _NineGridAbcState();
}

class _NineGridAbcState extends State<NineGridAbc> with BaseAbcStateMixin {
  @override
  List<Widget> buildBodyList(BuildContext context) {
    final width = nextInt(screenWidth.toInt(), 40);
    final height = nextInt(screenHeight.toInt(), 40);
    final count0 = nextInt(9, 1);
    final count1 = nextInt(9, 1);
    final count2 = nextInt(9, 1);
    final count3 = nextInt(9, 1);
    final count4 = nextInt(9, 1);
    final count5 = nextInt(9, 1);
    final count6 = nextInt(9, 1);
    final imageList = [
      DragBean(),
      DragBean(),
      DragBean(),
      DragBean(),
      DragBean(),
    ];
    return [
      "单图($width*$height)↓".text(textAlign: TextAlign.center),
      // bigImage参数 单张大图建议使用中等质量图片，因为原图太大加载耗时。
      NineGridView(
          margin: const EdgeInsets.symmetric(horizontal: kX),
          padding: const EdgeInsets.all(5),
          alignment: Alignment.centerLeft,
          bigImageWidth: width,
          bigImageHeight: height,
          space: 5,
          color: randomColor(),
          type: NineGridType.normal,
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return randomImageWidget(width: width, height: height);
          }),
      "normal 样式($count0)↓".text(textAlign: TextAlign.center),
      // bigImage参数 单张大图建议使用中等质量图片，因为原图太大加载耗时。
      NineGridView(
          margin: const EdgeInsets.symmetric(horizontal: kX),
          padding: const EdgeInsets.all(5),
          alignment: Alignment.centerLeft,
          space: 5,
          color: randomColor(),
          type: NineGridType.normal,
          itemCount: count0,
          itemBuilder: (BuildContext context, int index) {
            return randomImageWidget();
          }),
      "qqGp 样式($count1)↓".text(textAlign: TextAlign.center),
      // 头像需要设置宽、高参数。
      NineGridView(
        width: 120,
        height: 120,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5),
        space: 5,
        color: randomColor(),
        type: NineGridType.qqGp,
        //NineGridType.weChatGp, NineGridType.dingTalkGp
        itemCount: count1,
        itemBuilder: (BuildContext context, int index) {
          return randomImageWidget();
        },
      ),
      "weChat 样式($count2)↓".text(textAlign: TextAlign.center),
      NineGridView(
        width: 180,
        height: 180,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(5),
        space: 2,
        color: randomColor(),
        type: NineGridType.weChat,
        itemCount: count2,
        itemBuilder: (BuildContext context, int index) {
          return randomImageWidget();
        },
      ),
      "weChatGp 样式($count3)↓".text(textAlign: TextAlign.center),
      NineGridView(
        width: 180,
        height: 180,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(5),
        space: 2,
        color: randomColor(),
        type: NineGridType.weChatGp,
        itemCount: count3,
        itemBuilder: (BuildContext context, int index) {
          return randomImageWidget();
        },
      ),
      "weiBo 样式($count4)↓".text(textAlign: TextAlign.center),
      NineGridView(
        width: 100,
        height: 100,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(5),
        space: 2,
        color: randomColor(),
        type: NineGridType.weiBo,
        itemCount: count4,
        itemBuilder: (BuildContext context, int index) {
          return randomImageWidget();
        },
      ),
      "dingTalkGp 样式($count5)↓".text(textAlign: TextAlign.center),
      NineGridView(
        width: 100,
        height: 100,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(5),
        space: 2,
        color: randomColor(),
        type: NineGridType.dingTalkGp,
        itemCount: count5,
        itemBuilder: (BuildContext context, int index) {
          return randomImageWidget();
        },
      ),
      "可拖拽($count6)↓".text(textAlign: TextAlign.center),
      // 建议使用略微缩图，因为原图太大可能会引起重复加载导致闪动.
      DragSortView(
        imageList,
        space: 5,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(0),
        itemBuilder: (BuildContext context, int index) {
          return randomImageWidget();
        },
        initBuilder: (BuildContext context) {
          return InkWell(
            onTap: () {
              //_loadAssets(context);
            },
            child: Container(
              color: const Color(0XFFCCCCCC),
              child: const Center(
                child: Icon(
                  Icons.add,
                ),
              ),
            ),
          );
        },
        onDragListener: (event, itemWidth) {
          /// 判断拖动到指定位置删除
          /// return true;
          if ((event.globalY ?? 0) > 600) {
            return true;
          }
          return false;
        },
      ),
    ];
  }
}
