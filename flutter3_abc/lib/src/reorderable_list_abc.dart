part of '../flutter3_abc.dart';

///
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2024/06/09
///
/// 排序列表
///
/// [SliverReorderableList].[SliverReorderableListState.build]
/// 通过[SliverChildBuilderDelegate]使用[SliverList].[SliverFixedExtentList].[SliverVariedExtentList].[SliverPrototypeExtentList]实现
///
/// [ReorderableList].[ReorderableListState.build] 手动控制拖拽排序
/// 通过[CustomScrollView]->[SliverReorderableList]实现
/// [ReorderableListState.startItemDragReorder]
///
/// [ReorderableListView].[_ReorderableListViewState.build] 长按自动开启拖拽排序
/// 通过[CustomScrollView]包裹[SliverReorderableList]实现
class ReorderableListAbc extends StatefulWidget {
  const ReorderableListAbc({super.key});

  @override
  State<ReorderableListAbc> createState() => _ReorderableListAbcState();
}

class _ReorderableListAbcState extends State<ReorderableListAbc>
    with BaseAbcStateMixin {
  final GlobalKey<SliverReorderableListState> _sliverReorderableListKey =
      GlobalKey();
  List items = List.generate(20, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  @override
  WidgetList buildBodyList(BuildContext context) {
    return [
      for (final item in items)
        ListTile(
          trailing: ReorderableDragStartListener(
            index: items.indexOf(item),
            child: const Icon(Icons.drag_handle_outlined),
          ),
          title: Text(item),
        ).material().rReorder(onReorder),
    ];
  }

  //---

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      //body: _buildReorderableListView(context),
      body: CustomScrollView(
        slivers: [_buildSliverReorderableList(context)],
      ),
    );
  }*/

  void onReorder(int oldIndex, int newIndex) {
    setState(() {
      l.d("oldIndex:$oldIndex newIndex:$newIndex");
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final item = items.removeAt(oldIndex);
      items.insert(newIndex, item);
    });
  }

  void onReorderStart(int index) {
    l.d("onReorderStart:$index");
  }

  void onReorderEnd(int index) {
    l.d("onReorderEnd:$index");
  }

  /// [SliverReorderableList]
  /// 调用[SliverReorderableListState.startItemDragReorder]开始拖拽排序
  /// 调用[SliverReorderableListState.cancelReorder]取消拖拽排序
  ///
  /// 使用[ReorderableDragStartListener]包裹实现按下拖拽
  /// 使用[ReorderableDelayedDragStartListener]包裹实现长按拖拽
  ///
  Widget _buildSliverReorderableList(BuildContext context) {
    return SliverReorderableList(
      key: _sliverReorderableListKey,
      onReorder: onReorder,
      onReorderStart: onReorderStart,
      onReorderEnd: onReorderEnd,
      itemBuilder: (BuildContext context, int index) {
        /*return ReorderableDragStartListener(
          key: ValueKey(index),
          index: index,
          child: ListTile(
            key: ValueKey(index),
            title: Text(items[index]),
          ),
        ).material(key: ValueKey(index));*/
        return ListTile(
          key: ValueKey(index),
          trailing: ReorderableDragStartListener(
            index: index,
            child: const Icon(Icons.drag_handle),
          ),
          title: Text(items[index]),
        ).material(key: ValueKey(index));
        /*return ListTile(
          key: ValueKey(index),
          trailing: ReorderableDelayedDragStartListener(
            index: index,
            child: const Icon(Icons.drag_handle),
          ),
          title: Text(items[index]),
        ).material(key: ValueKey(index));*/
      },
      itemCount: items.length,
    );
  }

  /// [ReorderableListView]
  /// 长按自动开启拖拽排序
  /// 未找到主动触发拖拽排序的方法
  /// 未找到拦截拖拽的方法
  Widget _buildReorderableListView(BuildContext context) {
    return ReorderableListView(
      buildDefaultDragHandles: true,
      onReorder: onReorder,
      onReorderStart: onReorderStart,
      onReorderEnd: onReorderEnd,
      children: [
        for (final item in items)
          ListTile(
            key: ValueKey(item),
            title: Text(item),
          ),
      ],
    );
  }
}
