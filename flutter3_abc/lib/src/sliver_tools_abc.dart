part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/12/08
///

class SliverToolsAbc extends StatefulWidget {
  const SliverToolsAbc({super.key});

  @override
  State<SliverToolsAbc> createState() => _SliverToolsAbcState();
}

class _SliverToolsAbcState extends State<SliverToolsAbc>
    with BaseAbcStateMixin {
  late var evenNumber = AbcConfig.getAndIncrementClickCount() % 2 == 0;

  var items = [];
  var loading = false;

  /// 刷新
  Future refresh() async {
    await Future.delayed(const Duration(seconds: 2), () {
      loading = false;
      if (mounted) {
        setState(() {
          items.clear();
          items = List.generate(10, (index) => index);
        });
      }
    });
  }

  /// 下一页
  void nextPage() {
    loading = true;
    setState(() {});
    Future.delayed(const Duration(seconds: 2), () {
      loading = false;
      setState(() {
        items.addAll(List.generate(10, (index) => items.length + index));
      });
    });
  }

  /// Section 内部的 item 列表
  Widget buildListItem(BuildContext context) {
    Widget list = SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return "item $index"
              .text()
              .container(alignment: Alignment.centerLeft, height: 25);
        },
        childCount: items.length,
      ),
    );
    list = SliverAnimatedPaintExtent(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: list,
    );
    return list;
  }

  /// 一段
  Widget buildSection(BuildContext context) {
    Widget result = SliverStack(
      insetOnOverlap: true,
      children: [
        SliverPositioned.fill(
          top: 20,
          child: _CardBackground(),
        ),
        MultiSliver(
          children: <Widget>[
            SliverPinnedHeader(
              child: "悬浮头".text().container(
                    alignment: Alignment.centerLeft,
                    height: kMinInteractiveDimension,
                  ),
            ),
            SliverClip(
              child: MultiSliver(
                children: <Widget>[
                  buildListItem(context),
                  Container(
                    height: 64,
                    alignment: Alignment.center,
                    child: _NextPageButton(
                      loading: loading,
                      nextPage: nextPage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
    result = SliverCrossAxisPadded(
      paddingStart: kXh,
      paddingEnd: kXh,
      child: result,
    );
    result = MultiSliver(
      pushPinnedChildren: true,
      children: [result],
    );
    return result;
  }

  /// body
  Widget buildBodyTest1(BuildContext context) {
    return MultiSliver(
      children: [
        if (evenNumber)
          CupertinoSliverRefreshControl(
            onRefresh: refresh,
          ),
        /*if (!evenNumber)
          RefreshIndicator(
            onRefresh: refresh,
          ),*/
        buildSection(context),
        buildSection(context),
        SizedBox(height: platformMediaQueryData.systemGestureInsets.bottom),
      ],
    );
  }

  @override
  Widget buildAbc(BuildContext context) {
    if (evenNumber) {
      return super.buildAbc(context);
    }
    return Scrollbar(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [buildBodyTest1(context)],
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return buildBodyTest1(context).rItemTile(isSliverItem: true);
  }
}

class _CardBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 8,
            color: Colors.black26,
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class _NextPageButton extends StatelessWidget {
  final bool loading;
  final VoidCallback nextPage;

  const _NextPageButton({
    required this.loading,
    required this.nextPage,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: loading
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: nextPage,
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue),
              ),
              child: const Text(
                "下一页",
                style: TextStyle(),
              ),
            ),
    );
  }
}
