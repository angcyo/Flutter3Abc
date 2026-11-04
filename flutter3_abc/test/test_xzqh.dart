import 'dart:io';

import 'package:flutter3_basics/flutter3_basics.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/02
///
/// xzqh 行政区划
void main() {
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
  print("...end");
}
