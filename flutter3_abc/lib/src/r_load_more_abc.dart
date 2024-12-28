part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/12/08
///

class RLoadMoreAbc extends StatefulWidget {
  const RLoadMoreAbc({super.key});

  @override
  State<RLoadMoreAbc> createState() => _RLoadMoreAbcState();
}

class _RLoadMoreAbcState extends State<RLoadMoreAbc> {
  late final RScrollController scrollController = RScrollController()
    ..onLoadDataCallback = onLoadData;

  var dataList = [];

  void onLoadData() async {
    //debugger();
    l.i('加载数据:${scrollController.requestPage}');
    /*scrollController.updateWidgetState(this, WidgetBuildState.loading);*/
    await Future.delayed(const Duration(seconds: 2));
    var page = scrollController.requestPage;
    if (page.isFirstPage) {
      dataList.clear();
    }
    var newDataList = List.generate(
        page.requestPageIndex > 3 ? 10 : page.requestPageSize,
        (index) => "Data:${page.currentStartIndex + index}");
    dataList.addAll(newDataList);
    scrollController.finishRefresh(newDataList);
  }

  @override
  void initState() {
    super.initState();
    scrollController.updateAdapterState(WidgetBuildState.loading);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var globalConfig = GlobalConfig.of(context);
    var buttonMinWidth = 0.0;
    var buttonMinHeight = 30.0;
    var padding = const EdgeInsets.all(kM);
    return Scaffold(
      appBar: globalConfig.appBarBuilder(
        context,
        this,
        title: Text('${widget.runtimeType}'),
      ),
      persistentFooterButtons: [
        [
          dataList.length.toString().text(),
          GradientButton(
            minWidth: buttonMinWidth,
            minHeight: buttonMinHeight,
            padding: padding,
            onTap: () {
              scrollController.startRefresh();
            },
            child: '刷新'.text(),
          ),
          GradientButton(
            minWidth: buttonMinWidth,
            minHeight: buttonMinHeight,
            padding: padding,
            onTap: () {
              scrollController.updateAdapterState(WidgetBuildState.loading);
            },
            child: '加载中...'.text(),
          ),
          GradientButton(
            minWidth: buttonMinWidth,
            minHeight: buttonMinHeight,
            padding: padding,
            onTap: () {
              scrollController.updateAdapterState(
                WidgetBuildState.empty,
                LibRes.of(context).libAdapterNoData,
              );
            },
            child: '空数据'.text(),
          ),
          GradientButton(
            minWidth: buttonMinWidth,
            minHeight: buttonMinHeight,
            padding: padding,
            onTap: () {
              scrollController.updateAdapterState(
                  WidgetBuildState.error, '错误测试');
            },
            child: '错误'.text(),
          ),
          GradientButton(
            minWidth: buttonMinWidth,
            minHeight: buttonMinHeight,
            padding: padding,
            onTap: () {
              scrollController.updateLoadMoreState(WidgetBuildState.loading);
            },
            child: 'loadMore'.text(),
          ),
          GradientButton(
            minWidth: buttonMinWidth,
            minHeight: buttonMinHeight,
            padding: padding,
            onTap: () {
              scrollController.updateLoadMoreState(WidgetBuildState.empty);
            },
            child: 'noMore'.text(),
          ),
          GradientButton(
            minWidth: buttonMinWidth,
            minHeight: buttonMinHeight,
            padding: padding,
            onTap: () {
              scrollController.updateLoadMoreState(
                  WidgetBuildState.error, "错误测试");
            },
            child: 'loadError'.text(),
          ),
        ].wrap()!,
      ],
      body: RScrollView(
        controller: scrollController,
        enableRefresh: true,
        enableLoadMore: true,
        children: [
          for (var i = 0; i < dataList.length; i++)
            RItemTile(
              child: randomLogWidget("[${dataList[i]}]item $i"),
            ),
        ],
      ),
    );
  }
}
