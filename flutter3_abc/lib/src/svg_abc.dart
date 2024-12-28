part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/11/20
///

class SvgAbc extends StatefulWidget {
  const SvgAbc({super.key});

  @override
  State<SvgAbc> createState() => _SvgAbcState();
}

class _SvgAbcState extends State<SvgAbc> with BaseAbcStateMixin {
  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      loadAssetSvgWidget(
        "flutter_dash.svg",
        prefix: null,
        width: 100,
        height: 100,
      ),
      loadAssetSvgWidget(
        "flutter_dash.svg",
        prefix: "packages/flutter3_app/assets/svg/",
        width: 100,
        height: 100,
      ),
      loadAssetSvgWidget(
        "flutter_dash.svg",
        width: 100,
        height: 100,
      ),
      loadAssetSvgWidget(
        "flutter_dash.svg",
        width: 100,
        height: 100,
        colorFilter: Colors.red.toColorFilter(BlendMode.srcIn),
      ),
      loadHttpSvgWidget(
        "https://raw.githubusercontent.com/LaserPeckerIst/vue-fabric-editor-static/main/svg/477.svg",
        width: 100,
        height: 100,
      ),
      loadHttpSvgWidget(
        "https://gitee.com/angcyo/vue-fabric-editor-static/raw/main/svg/477.svg",
        width: 100,
        height: 100,
      ),
      loadHttpSvgWidget(
        "https://gitee.com/angcyo/vue-fabric-editor-static/raw/main/svg/477.svg",
        width: 100,
        height: 100,
        colorFilter: Colors.red.toColorFilter(),
      ),
    ].wrap()!.ofList();
  }
}
