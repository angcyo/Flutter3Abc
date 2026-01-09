part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/01/09
///
/// Api 接口测试界面
///
class ApiAbc extends StatefulWidget {
  const ApiAbc({super.key});

  @override
  State<ApiAbc> createState() => _ApiAbcState();
}

class _ApiAbcState extends State<ApiAbc>
    with
        BaseAbcStateMixin,
        LogMessageStateMixin,
        HookMixin,
        HookStateMixin,
        HttpApiLogStateMixin {
  @override
  Widget buildApiTest(BuildContext context, GlobalTheme globalTheme) =>
      super.buildAbc(context);

  @override
  WidgetList buildBodyList(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    return buildApiTestHeader(context, globalTheme);
  }
}
