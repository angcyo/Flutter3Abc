import 'dart:io';

import 'package:flutter3_basics/flutter3_basics.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/02
///
/// xzqh 行政区划
void main() {
  //testSzqhJson();
  testChinaJson();

  print("...end");
}

void testSzqhJson() {
  // 行政区划所有数据
  final xzqhJson = File("assets/json/xzqh.json").readAsStringSync().fromJson();
  final data = xzqhJson["data"];
  final children = data["children"];

  /*// 省份简称数据
  final provinceMetaJson = File(
    "assets/json/province_meta.json",
  ).readAsStringSync().fromJson();
  //所有城市邮政编码数据
  final cityMetaJson = File(
    "assets/json/city_meta.json",
  ).readAsStringSync().fromJson();
  // 补齐省份简称
  for (final json in children) {
    final code = json["code"];
    final shortName = provinceMetaJson[code]?["shortName"];
    if (shortName != null) {
      json["shortName"] = shortName;
    }
  }
  // 补齐城市邮政编码
  void patchZipCode(input) {
    if (input == null) {
      return;
    }
    for (final json in input) {
      final code = json["code"];
      final zipCode = cityMetaJson[code]?["zipCode"];
      if (zipCode != null) {
        json["zipCode"] = zipCode;
      }
      final subChildren = json["children"];
      patchZipCode(subChildren);
    }
  }

  patchZipCode(children);*/

  // 城市简称
  final cityJson = File("assets/json/city.json").readAsStringSync().fromJson();
  // 补齐城市简称
  void patchCityShortName(input) {
    if (input == null) {
      return;
    }
    for (final json in input) {
      final name = json["name"];

      final find = (cityJson as Iterable).findFirst((e) => e["city"] == name);
      if (find != null) {
        final cityShortName = find["cityShort"];
        final cityCode = find["code"];
        json["cityShortName"] = cityShortName;
        json["cityCode"] = cityCode;
      }

      final subChildren = json["children"];
      patchCityShortName(subChildren);
    }
  }

  patchCityShortName(children);

  // output
  File(
    "assets/json/output_xzqh.json",
  ).writeAsStringSync((xzqhJson as Object).toJsonString());

  //print(xzqhJson.runtimeType);
}

void testChinaJson() {
  //china geo json
  final chainJson = File(
    "assets/json/china.json",
  ).readAsStringSync().fromJson();
  final features = chainJson["features"];
  for (final feature in features) {
    final properties = feature["properties"];
    final name = properties["fullname"];
    final capital = capitalMap[name];
    if (capital != null) {
      properties["capital"] = capital;
    }
  }
  File(
    "assets/json/output_china.json",
  ).writeAsStringSync((chainJson as Object).toJsonString());
}

/// 省会映射表
final Map<String, String> capitalMap = {
  "河北省": "石家庄",
  "山西省": "太原",
  "辽宁省": "沈阳",
  "吉林省": "长春",
  "黑龙江": "哈尔滨",
  "江苏省": "南京",
  "浙江省": "杭州",
  "安徽省": "合肥",
  "福建省": "福州",
  "江西省": "南昌",
  "山东省": "济南",
  "河南省": "郑州",
  "湖北省": "武汉",
  "湖南省": "长沙",
  "广东省": "广州",
  "海南省": "海口",
  "四川省": "成都",
  "贵州省": "贵阳",
  "云南省": "昆明",
  "陕西省": "西安",
  "甘肃省": "兰州",
  "青海省": "西宁",
  "台湾省": "台北",
  "内蒙古自治区": "呼和浩特",
  "广西壮族自治区": "南宁",
  "西藏自治区": "拉萨",
  "宁夏回族自治区": "银川",
  "新疆维吾尔自治区": "乌鲁木齐",
};
