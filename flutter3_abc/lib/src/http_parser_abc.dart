part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/12/19
///
class HttpParserAbc extends StatefulWidget {
  const HttpParserAbc({super.key});

  @override
  State<HttpParserAbc> createState() => _HttpParserAbcState();
}

class _HttpParserAbcState extends State<HttpParserAbc> with BaseAbcStateMixin {
  final _resultSignal = $signal<List<_HtmlNodeTextInfo>>(<_HtmlNodeTextInfo>[]);

  late final _fetchInfoList = [
    _HouseInfo(
      label: "鹏宸云筑\n3栋",
      id: "53455",
      presellId: "136776",
      developerEnterprise: "深圳华展置业有限公司",
      ratifyTime: "2024-12-06",
    ),
    _HouseInfo(
      label: "5栋",
      id: "53456",
      presellId: "136776",
      developerEnterprise: "深圳华展置业有限公司",
      ratifyTime: "2024-12-06",
    ),
    //--
    _HouseInfo(
      label: "颐樾府\n6栋未命名",
      id: "53374",
      presellId: "136711",
      branch: "未命名",
      developerEnterprise: "深圳市深业华居地产有限公司",
      ratifyTime: "2024-12-05",
    ),
    //--
    _HouseInfo(
      label: "上城学府\n1栋一单元",
      id: "52594",
      presellId: "135231",
      branch: "一单元",
      developerEnterprise: "深圳市深业龙瑞地产有限公司",
      ratifyTime: "2024-10-08",
    ),
    _HouseInfo(
      label: "1栋二单元",
      id: "52594",
      presellId: "135231",
      branch: "二单元",
      developerEnterprise: "深圳市深业龙瑞地产有限公司",
      ratifyTime: "2024-10-08",
    ),
    //--
    _HouseInfo(
      label: "颐樾府\n5栋未命名",
      id: "51594",
      presellId: "133270",
      branch: "未命名",
      developerEnterprise: "深圳市深业华居地产有限公司",
      ratifyTime: "2024-06-19",
    ),
    //--
    _HouseInfo(
      label: "迎玺花园\n2栋一单元",
      id: "51595",
      presellId: "133269",
      branch: "一单元",
      developerEnterprise: "深圳市黄金台项目开发有限公司",
      ratifyTime: "2024-06-19",
    ),
    _HouseInfo(
      label: "2栋二单元",
      id: "51595",
      presellId: "133269",
      branch: "二单元",
      developerEnterprise: "深圳市黄金台项目开发有限公司",
      ratifyTime: "2024-06-19",
    ),
    _HouseInfo(
      label: "2栋三单元",
      id: "51595",
      presellId: "133269",
      branch: "三单元",
      developerEnterprise: "深圳市黄金台项目开发有限公司",
      ratifyTime: "2024-06-19",
    ),
    _HouseInfo(
      label: "2栋四单元",
      id: "51595",
      presellId: "133269",
      branch: "四单元",
      developerEnterprise: "深圳市黄金台项目开发有限公司",
      ratifyTime: "2024-06-19",
    ),
    _HouseInfo(
      label: "2栋五单元",
      id: "51595",
      presellId: "133269",
      branch: "五单元",
      developerEnterprise: "深圳市黄金台项目开发有限公司",
      ratifyTime: "2024-06-19",
    ),
    //--
    _HouseInfo(
      label: "尚云花园\n2栋一单元",
      id: "50574",
      presellId: "131420",
      branch: "一单元",
      developerEnterprise: "深圳市鸿龙达投资有限公司",
      ratifyTime: "2024-03-01",
    ),
    _HouseInfo(
      label: "2栋二单元",
      id: "50574",
      presellId: "131420",
      branch: "二单元",
      developerEnterprise: "深圳市鸿龙达投资有限公司",
      ratifyTime: "2024-03-01",
    ),
    //--
    _HouseInfo(
      label: "迎玺花园\n1栋一单元",
      id: "49716",
      presellId: "130103",
      branch: "一单元",
      developerEnterprise: "深圳市黄金台项目开发有限公司",
      ratifyTime: "2023-11-29",
    ),
    _HouseInfo(
      label: "1栋二单元",
      id: "49716",
      presellId: "130103",
      branch: "二单元",
      developerEnterprise: "深圳市黄金台项目开发有限公司",
      ratifyTime: "2023-11-29",
    ),
    _HouseInfo(
      label: "1栋三单元",
      id: "49716",
      presellId: "130103",
      branch: "三单元",
      developerEnterprise: "深圳市黄金台项目开发有限公司",
      ratifyTime: "2023-11-29",
    ),
    _HouseInfo(
      label: "1栋四单元",
      id: "49716",
      presellId: "130103",
      branch: "四单元",
      developerEnterprise: "深圳市黄金台项目开发有限公司",
      ratifyTime: "2023-11-29",
    ),
    //--
    _HouseInfo(
      label: "天湖岛花园\n1栋未命名",
      id: "49735",
      presellId: "130086",
      branch: "未命名",
      developerEnterprise: "深圳市鹏宝东物业发展有限公司",
      ratifyTime: "2023-11-29",
    ),
    _HouseInfo(
      label: "2栋未命名",
      id: "49736",
      presellId: "130086",
      branch: "未命名",
      developerEnterprise: "深圳市鹏宝东物业发展有限公司",
      ratifyTime: "2023-11-29",
    ),
    //--
    _HouseInfo(
      label: "卓越柏奕府\n1栋",
      id: "49636",
      presellId: "129765",
      branch: "未命名",
      developerEnterprise: "深圳卓越锦诚城市更新有限公司",
      ratifyTime: "2023-11-03",
    ),
    _HouseInfo(
      label: "4栋",
      id: "49637",
      presellId: "129765",
      branch: "未命名",
      developerEnterprise: "深圳卓越锦诚城市更新有限公司",
      ratifyTime: "2023-11-03",
    ),
    //--
    _HouseInfo(
      label: "超核紫芸府\n1栋一单元",
      id: "49134",
      presellId: "129066",
      branch: "一单元",
      developerEnterprise: "深圳市润朝房地产有限公司",
      ratifyTime: "2023-09-14",
    ),
    _HouseInfo(
      label: "1栋二单元",
      id: "49134",
      presellId: "129066",
      branch: "二单元",
      developerEnterprise: "深圳市润朝房地产有限公司",
      ratifyTime: "2023-09-14",
    ),
    //--
    _HouseInfo(
      label: "珑悦理家园\n1栋一单元",
      id: "48351",
      presellId: "128638",
      branch: "一单元",
    ),
    _HouseInfo(
      label: "1栋未命名",
      id: "48351",
      presellId: "128638",
      branch: "未命名",
    ),
    _HouseInfo(
      label: "1栋二单元",
      id: "48351",
      presellId: "128638",
      branch: "二单元",
    ),
    //--
    _HouseInfo(
      label: "尚云花园\n3栋裙楼商业",
      id: "48671",
      presellId: "128449",
      branch: "裙楼商业",
      developerEnterprise: "深圳市鸿龙达投资有限公司",
      ratifyTime: "2023-07-21",
    ),
    _HouseInfo(
      label: "3栋一单元",
      id: "48671",
      presellId: "128449",
      branch: "一单元",
      developerEnterprise: "深圳市鸿龙达投资有限公司",
      ratifyTime: "2023-07-21",
    ),
    _HouseInfo(
      label: "3栋二单元",
      id: "48671",
      presellId: "128449",
      branch: "二单元",
      developerEnterprise: "深圳市鸿龙达投资有限公司",
      ratifyTime: "2023-07-21",
    ),
    _HouseInfo(
      label: "3栋三单元",
      id: "48671",
      presellId: "128449",
      branch: "三单元",
      developerEnterprise: "深圳市鸿龙达投资有限公司",
      ratifyTime: "2023-07-21",
    ),
    //--
    _HouseInfo(
      label: "颐樾府\n2栋未命名",
      id: "48370",
      presellId: "127941",
      branch: "未命名",
      developerEnterprise: "深圳市深业华居地产有限公司",
      ratifyTime: "2023-06-09",
    ),
    _HouseInfo(
      label: "3栋未命名",
      id: "48371",
      presellId: "127941",
      branch: "未命名",
      developerEnterprise: "深圳市深业华居地产有限公司",
      ratifyTime: "2023-06-09",
    ),
    //--
    _HouseInfo(
      label: "天曜府\n1栋一单元",
      id: "48290",
      presellId: "127940",
      branch: "一单元",
      developerEnterprise: "深圳市东园美地房地产开发有限公司",
      ratifyTime: "2023-06-09",
    ),
    _HouseInfo(
      label: "1栋二单元",
      id: "48290",
      presellId: "127940",
      branch: "二单元",
      developerEnterprise: "深圳市东园美地房地产开发有限公司",
      ratifyTime: "2023-06-09",
    ),
    _HouseInfo(
      label: "1栋三单元",
      id: "48290",
      presellId: "127940",
      branch: "三单元",
      developerEnterprise: "深圳市东园美地房地产开发有限公司",
      ratifyTime: "2023-06-09",
    ),
    _HouseInfo(
      label: "1栋四单元",
      id: "48290",
      presellId: "127940",
      branch: "四单元",
      developerEnterprise: "深圳市东园美地房地产开发有限公司",
      ratifyTime: "2023-06-09",
    ),
    //--
    _HouseInfo(
      label: "龙岸花园\n10栋",
      id: "48312",
      presellId: "127939",
      branch: "未命名",
      developerEnterprise: "深圳市金光华地产开发有限公司",
      ratifyTime: "2023-06-07",
    ),
    _HouseInfo(
      label: "7栋",
      id: "48313",
      presellId: "127939",
      branch: "未命名",
      developerEnterprise: "深圳市金光华地产开发有限公司",
      ratifyTime: "2023-06-07",
    ),
    _HouseInfo(
      label: "8栋",
      id: "48316",
      presellId: "127939",
      branch: "未命名",
      developerEnterprise: "深圳市金光华地产开发有限公司",
      ratifyTime: "2023-06-07",
    ),
    _HouseInfo(
      label: "9栋",
      id: "48320",
      presellId: "127939",
      branch: "未命名",
      developerEnterprise: "深圳市金光华地产开发有限公司",
      ratifyTime: "2023-06-07",
    ),
    //--
    _HouseInfo(
      label: "北站超核万象中心\n2栋",
      id: "47792",
      presellId: "127169",
      branch: "未命名",
      developerEnterprise: "深圳市润北房地产有限公司",
      ratifyTime: "2023-04-14",
    ),
    _HouseInfo(
      label: "3栋",
      id: "47793",
      presellId: "127169",
      branch: "未命名",
      developerEnterprise: "深圳市润北房地产有限公司",
      ratifyTime: "2023-04-14",
    ),
    _HouseInfo(
      label: "5栋",
      id: "47794",
      presellId: "127169",
      branch: "未命名",
      developerEnterprise: "深圳市润北房地产有限公司",
      ratifyTime: "2023-04-14",
    ),
    _HouseInfo(
      label: "1栋一单元",
      id: "47646",
      presellId: "126880",
      branch: "一单元",
      developerEnterprise: "深圳市润北房地产有限公司",
      ratifyTime: "2023-03-16",
    ),
    _HouseInfo(
      label: "1栋二单元",
      id: "47646",
      presellId: "126880",
      branch: "二单元",
      developerEnterprise: "深圳市润北房地产有限公司",
      ratifyTime: "2023-03-16",
    ),
    //--
    _HouseInfo(
      label: "卓越和奕府\n2栋二单元",
      id: "47064",
      presellId: "125275",
      branch: "二单元",
      developerEnterprise: "深圳市正基房地产开发有限公司",
      ratifyTime: "2022-12-30",
    ),
    _HouseInfo(
      label: "2栋三单元",
      id: "47064",
      presellId: "125275",
      branch: "三单元",
      developerEnterprise: "深圳市正基房地产开发有限公司",
      ratifyTime: "2022-12-30",
    ),
    //--
    _HouseInfo(
      label: "四海华亭\n1栋一单元",
      id: "46284",
      presellId: "119162",
      branch: "一单元",
      developerEnterprise: "深圳市协跃房地产开发有限公司",
      ratifyTime: "2022-11-03",
    ),
    _HouseInfo(
      label: "1栋二单元",
      id: "46284",
      presellId: "119162",
      branch: "二单元",
      developerEnterprise: "深圳市协跃房地产开发有限公司",
      ratifyTime: "2022-11-03",
    ),
    _HouseInfo(
      label: "1栋三单元",
      id: "46284",
      presellId: "119162",
      branch: "三单元",
      developerEnterprise: "深圳市协跃房地产开发有限公司",
      ratifyTime: "2022-11-03",
    ),
    _HouseInfo(
      label: "1栋四单元",
      id: "46284",
      presellId: "119162",
      branch: "四单元",
      developerEnterprise: "深圳市协跃房地产开发有限公司",
      ratifyTime: "2022-11-03",
    ),
    //--
    _HouseInfo(
      label: "卓越和奕府\n1栋一单元",
      id: "44363",
      presellId: "98613",
      branch: "一单元",
      developerEnterprise: "深圳市正基房地产开发有限公司",
      ratifyTime: "2022-05-06",
    ),
    _HouseInfo(
      label: "1栋二单元",
      id: "44363",
      presellId: "98613",
      branch: "二单元",
      developerEnterprise: "深圳市正基房地产开发有限公司",
      ratifyTime: "2022-05-06",
    ),
    _HouseInfo(
      label: "1栋三单元",
      id: "44363",
      presellId: "98613",
      branch: "三单元",
      developerEnterprise: "深圳市正基房地产开发有限公司",
      ratifyTime: "2022-05-06",
    ),
    //--
    _HouseInfo(
      label: "卓越柏奕府\n1栋",
      id: "43503",
      presellId: "90613",
      branch: "未命名",
      developerEnterprise: "深圳市正基房地产开发有限公司",
      ratifyTime: "2021-12-30",
    ),
    _HouseInfo(
      label: "2栋",
      id: "43504",
      presellId: "90613",
      branch: "未命名",
      developerEnterprise: "深圳市正基房地产开发有限公司",
      ratifyTime: "2021-12-30",
    ),
    _HouseInfo(
      label: "3栋",
      id: "43505",
      presellId: "90613",
      branch: "未命名",
      developerEnterprise: "深圳市正基房地产开发有限公司",
      ratifyTime: "2021-12-30",
    ),
    _HouseInfo(
      label: "4栋",
      id: "43506",
      presellId: "90613",
      branch: "未命名",
      developerEnterprise: "深圳市正基房地产开发有限公司",
      ratifyTime: "2021-12-30",
    ),
    //--
    _HouseInfo(
      label: "万福花园\n1栋A座",
      id: "43383",
      presellId: "88893",
      branch: "A座",
      developerEnterprise: "深圳市汕源新实业有限公司",
      ratifyTime: "2021-12-21",
    ),
    _HouseInfo(
      label: "1栋B座",
      id: "43383",
      presellId: "88893",
      branch: "B座",
      developerEnterprise: "深圳市汕源新实业有限公司",
      ratifyTime: "2021-12-21",
    ),
    _HouseInfo(
      label: "2栋A座",
      id: "43384",
      presellId: "88893",
      branch: "A座",
      developerEnterprise: "深圳市汕源新实业有限公司",
      ratifyTime: "2021-12-21",
    ),
    _HouseInfo(
      label: "2栋B座",
      id: "43384",
      presellId: "88893",
      branch: "B座",
      developerEnterprise: "深圳市汕源新实业有限公司",
      ratifyTime: "2021-12-21",
    ),
    _HouseInfo(
      label: "3栋",
      id: "43385",
      presellId: "88893",
      branch: "未命名",
      developerEnterprise: "深圳市汕源新实业有限公司",
      ratifyTime: "2021-12-21",
    ),
    _HouseInfo(
      label: "5栋A座",
      id: "43386",
      presellId: "88893",
      branch: "A座",
      developerEnterprise: "深圳市汕源新实业有限公司",
      ratifyTime: "2021-12-21",
    ),
    _HouseInfo(
      label: "5栋B座",
      id: "43386",
      presellId: "88893",
      branch: "B座",
      developerEnterprise: "深圳市汕源新实业有限公司",
      ratifyTime: "2021-12-21",
    ),
    _HouseInfo(
      label: "6栋",
      id: "43387",
      presellId: "88893",
      branch: "未命名",
      developerEnterprise: "深圳市汕源新实业有限公司",
      ratifyTime: "2021-12-21",
    ),
    _HouseInfo(
      label: "7A栋",
      id: "43388",
      presellId: "88893",
      branch: "未命名",
      developerEnterprise: "深圳市汕源新实业有限公司",
      ratifyTime: "2021-12-21",
    ),
    _HouseInfo(
      label: "7B栋",
      id: "43389",
      presellId: "88893",
      branch: "未命名",
      developerEnterprise: "深圳市汕源新实业有限公司",
      ratifyTime: "2021-12-21",
    ),
    //--
    _HouseInfo(
      label: "中海明德里\n1栋一单元",
      id: "41863",
      presellId: "71542",
      branch: "一单元",
      developerEnterprise: "中海深圳房地产开发有限公司",
      ratifyTime: "2021-09-24",
    ),
    _HouseInfo(
      label: "1栋未命名",
      id: "41863",
      presellId: "71542",
      branch: "未命名",
      developerEnterprise: "中海深圳房地产开发有限公司",
      ratifyTime: "2021-09-24",
    ),
    _HouseInfo(
      label: "1栋二单元",
      id: "41863",
      presellId: "71542",
      branch: "二单元",
      developerEnterprise: "中海深圳房地产开发有限公司",
      ratifyTime: "2021-09-24",
    ),
    _HouseInfo(
      label: "1栋三单元",
      id: "41863",
      presellId: "71542",
      branch: "三单元",
      developerEnterprise: "中海深圳房地产开发有限公司",
      ratifyTime: "2021-09-24",
    ),
    //--
    _HouseInfo(
      label: "恒壹四季华府\n1栋未命名",
      id: "40163",
      presellId: "54753",
      branch: "未命名",
      developerEnterprise: "深圳市新宏投资发展有限公司",
      ratifyTime: "2021-05-20",
    ),
    _HouseInfo(
      label: "1栋二单元",
      id: "40163",
      presellId: "54753",
      branch: "二单元",
      developerEnterprise: "深圳市新宏投资发展有限公司",
      ratifyTime: "2021-05-20",
    ),
    _HouseInfo(
      label: "1栋三单元",
      id: "40163",
      presellId: "54753",
      branch: "三单元",
      developerEnterprise: "深圳市新宏投资发展有限公司",
      ratifyTime: "2021-05-20",
    ),
    _HouseInfo(
      label: "2栋未命名",
      id: "40164",
      presellId: "54753",
      branch: "未命名",
      developerEnterprise: "深圳市新宏投资发展有限公司",
      ratifyTime: "2021-05-20",
    ),
  ];

  @override
  Widget buildAbc(BuildContext context) {
    return _resultSignal.buildFn(
        () => ProgressStateWidget(childBuilder: (ctx) => super.buildAbc(ctx)));
    // return super.buildAbc(context).progressStateWidget();
  }

  /// 是否展开
  bool _isExpand = false;

  @override
  WidgetList buildBodyList(BuildContext context) {
    final globalTheme = GlobalTheme.of(context);
    final firstInfo = _resultSignal.value?.firstOrNull?.info;
    return [
      [
        [
          GradientButton.min(
            child: "项目列表".text(textAlign: TextAlign.center),
            onTap: () {
              "https://zjj.sz.gov.cn/ris/bol/szfdc/index.aspx".openUrl();
            },
          ),
          GradientButton.min(
            child: "状态解释".text(textAlign: TextAlign.center),
            onTap: () {
              buildContext?.showWidgetDialog(MessageDialog(
                messageWidget: '''
“期房待售”，指房屋为期房，可以销售但尚未售出。
“已签认购书”， 指房屋已经签订认购书，但尚未签订正式的预售或现售合同。
“已录入合同”， 指房屋为期房，已录入预售合同。
“已签合同”，指房屋为期房，已售出并签订预售合同。
“已备案”，指签订的买卖合同已完成备案。
“首次登记”，指房屋已办理首次登记，该套房屋在预售房源库中状态不再更新。
“安居房”，指房屋为安居型商品房。
“自动锁定”，指开发商未及时办理合同备案，导致售房系统自动锁定，暂时无法使用。
“区局锁定”， 指房屋处于限制状态或开发商存在违规行为，导致售房系统被区局锁定。
“市局锁定”， 指房屋处于限制状态或开发商存在违规行为，导致售房系统被市局锁定。
“司法查封”，指房屋被司法机关锁定。
“在建抵押”，指房屋售出前开发商为贷款将房屋抵押给银行，根据其与银行的协议，在一定条件下可以销售。
“共有产权房”，指房屋为共有产权住房。'''
                    .text()
                    .paddingAll(kX)
                    .scroll()
                    .constrained(maxHeight: 300),
                messageTextAlign: TextAlign.left,
              ));
            },
          )
        ].column(gap: kL),
        for (final info in _fetchInfoList.subList(
            0, _isExpand ? _fetchInfoList.size() : 20))
          GradientButton.min(
            child:
                ("${info.label!}${isNil(info.totalDes) ? "" : "\n${info.totalDes}"}")
                    .text(textAlign: TextAlign.center),
            onTap: () {
              _fetchHtmlInfo(context, info);
            },
          ),
        if (!_isExpand)
          GradientButton.min(
            child: "展开...".text(textAlign: TextAlign.center),
            onTap: () {
              _isExpand = true;
              updateState();
            },
          ),
      ]
          .flowLayout(
              padding: edgeOnly(all: kX),
              childGap: kH,
              lineMainAxisAlignment: MainAxisAlignment.start)!
          .matchParentWidth(),
      //--
      firstInfo?.developerEnterprise?.text(
              style: globalTheme.textDesStyle, textAlign: TextAlign.center) ??
          empty,
      "${firstInfo?.showLabel.replaceAll("\n", "-") ?? nowTimeString()} (${firstInfo?.unsoldTotal ?? 0}/${firstInfo?.soldTotal ?? 0}/${firstInfo?.total ?? 0})"
          .text(style: globalTheme.textDesStyle, textAlign: TextAlign.center),
      for (final info in _resultSignal.value ?? <_HtmlNodeTextInfo>[])
        textSpanBuilder((builder) {
          builder
            ..addText(info.text1)
            ..newLineIfNotEmpty()
            ..addText(info.text2,
                style: globalTheme.textDesStyle.copyWith(
                    color: info.isRecord
                        ? globalTheme.warnColor
                        : info.isNotSale
                            ? globalTheme.errorColor
                            : info.isRecorded
                                ? globalTheme.successColor
                                : null));
        }, textAlign: TextAlign.center)
            .rGridTile(3, childAspectRatio: 3 / 1),
      /*ListTile(
          dense: true,
          title: info.text1?.text(),
          trailing: info.text2?.text(),
        ),*/
      //--
    ];
  }

  /// 只能以`/``//`查询开头
  /// [elementFunction] 元素的函数
  /// [_functionMatch] 匹配的函数
  Future<List<_HtmlNodeTextInfo>> _fetchHtmlInfo(
    BuildContext context,
    _HouseInfo info,
  ) async {
    context.dispatchProgressState();

    final List<_HtmlNodeTextInfo> list1 = [];
    final List<_HtmlNodeTextInfo> list2 = [];

    try {
      final html = await info.url.dioGetString();
      final xpath = HtmlXPath.html(html ?? "");
      //final result = xpath.query("//div[@id='divShowList']");
      final result = xpath.query("//tr");

      for (final trNode in result.nodes) {
        //final text = node.text;
        //final result2 = node.queryXPath("//div");
        for (final tdNode in trNode.children) {
          final divResult = tdNode.queryXPath("//div");
          final divNodes = divResult.nodes;

          _HtmlNodeTextInfo nodeTextInfo = _HtmlNodeTextInfo(info: info);
          for (final divNode in divNodes) {
            if (nodeTextInfo.text1 == null) {
              nodeTextInfo.text1 = divNode.text;
            } else {
              nodeTextInfo.text2 = divNode.text;
            }
          }
          if (!isNil(nodeTextInfo.text2)) {
            if (nodeTextInfo.isNotSale) {
              list1.add(nodeTextInfo);
            } else {
              list2.add(nodeTextInfo);
            }
          }
        }
      }

      context.buildContext?.dispatchProgressState(progress: 1);
    } catch (e) {
      print(e);
      context.buildContext?.dispatchProgressState(progress: 1, error: e);
    }

    /*final documentElement = HtmlParser.parseHTML(html ?? "");
    final list1 = documentElement.querySelectorAll("div[id='divShowList']");
    for (final element in list1) {
      element.children;
    }*/

    //l.d(list);
    final list = [...list1, ...list2];
    info.total = list.size();
    info.unsoldTotal = list1.size();
    info.soldTotal = list2.size();
    _resultSignal.value = list;
    return list;
  }
}

/// 待请求的房源信息
class _HouseInfo {
  /// 显示的标签
  String? label;

  /// 批准时间
  String? ratifyTime;

  /// 开发企业
  String? developerEnterprise;

  //--请求相关信息
  String? id;
  String? presellId;
  String? branch;
  // 预售:ys
  // 现售:xs
  String? isBlock;

  //--返回的信息
  int? total;
  int? unsoldTotal; //未销售总数
  int? soldTotal; //已销售总数

  _HouseInfo({
    this.label,
    this.ratifyTime,
    this.developerEnterprise,
    //--
    this.id,
    this.presellId,
    this.branch,
    this.isBlock,
    //--
    this.total,
    this.unsoldTotal,
    this.soldTotal,
  });

  /// 请求的地址
  String get url => stringBuilder((builder) {
        builder.addText("https://zjj.sz.gov.cn/ris/bol/szfdc/building.aspx?");
        builder.addText("id=$id&presellid=$presellId");
        if (!isNil(branch)) {
          builder.addText("&Branch=$branch");
        }
      });

  /// 详情链接
  String get detailUrl => stringBuilder((builder) {
        builder
            .addText("https://zjj.sz.gov.cn/ris/bol/szfdc/projectdetail.aspx?");
        builder.addText("id=$id");
      });

  String get showLabel => stringBuilder((builder) {
        builder.addText(label ?? "");
        if (!isNil(ratifyTime)) {
          builder.addText("($ratifyTime)");
        }
      });

  String get totalDes => stringBuilder((builder) {
        if (total != null) {
          builder.addText("$unsoldTotal/$soldTotal/$total");
        }
      });
}

/// 获取到的节点信息
///
/// 项目列表: https://zjj.sz.gov.cn/ris/bol/szfdc/index.aspx
/// 项目详情: https://zjj.sz.gov.cn/ris/bol/szfdc/projectdetail.aspx?id=136776
///
class _HtmlNodeTextInfo {
  _HouseInfo? info;

  //--
  String? text1;
  String? text2;

  /// 未售
  bool get isNotSale =>
      text2?.contains("期房待售") == true || text2?.contains("首次登记") == true;

  /// 是否是现房
  bool get isRecord => text2?.contains("首次登记") == true;

  /// 已备案
  bool get isRecorded => text2?.contains("已备案") == true;

  _HtmlNodeTextInfo({
    this.info,
    this.text1,
    this.text2,
  });

  @override
  String toString() {
    return 'HtmlNodeTextInfo{text1: $text1, text2: $text2}';
  }
}
