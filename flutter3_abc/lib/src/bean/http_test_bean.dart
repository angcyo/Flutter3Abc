import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'http_test_bean.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class HttpTestBean {
  String errMsg;
  num code;
  DataBean data;

  HttpTestBean({required this.errMsg, required this.code, required this.data});

  factory HttpTestBean.fromJson(Map<String, dynamic> json) =>
      _$HttpTestBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HttpTestBeanToJson(this);

  @override
  String toString() => jsonEncode(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class DataBean {
  num? id;
  String? nickname;
  dynamic say;
  String? avatar;
  dynamic mobile;
  String? email;
  num? sex;
  dynamic countryCodeName;
  dynamic region;
  String? province;
  String? city;
  String? token;
  dynamic like;
  dynamic download;
  dynamic follow;
  dynamic attention;
  dynamic isFriend;
  String? deviceSecurityCode;
  num? isOldUser;

  DataBean(
      {this.id,
      this.nickname,
      this.say,
      this.avatar,
      this.mobile,
      this.email,
      this.sex,
      this.countryCodeName,
      this.region,
      this.province,
      this.city,
      this.token,
      this.like,
      this.download,
      this.follow,
      this.attention,
      this.isFriend,
      this.deviceSecurityCode,
      this.isOldUser});

  factory DataBean.fromJson(Map<String, dynamic> json) =>
      _$DataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DataBeanToJson(this);
}
