// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_test_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpTestBean _$HttpTestBeanFromJson(Map<String, dynamic> json) => HttpTestBean(
  errMsg: json['errMsg'] as String,
  code: json['code'] as num,
  data: DataBean.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HttpTestBeanToJson(HttpTestBean instance) =>
    <String, dynamic>{
      'errMsg': instance.errMsg,
      'code': instance.code,
      'data': instance.data.toJson(),
    };

DataBean _$DataBeanFromJson(Map<String, dynamic> json) => DataBean(
  id: json['id'] as num?,
  nickname: json['nickname'] as String?,
  say: json['say'],
  avatar: json['avatar'] as String?,
  mobile: json['mobile'],
  email: json['email'] as String?,
  sex: json['sex'] as num?,
  countryCodeName: json['countryCodeName'],
  region: json['region'],
  province: json['province'] as String?,
  city: json['city'] as String?,
  token: json['token'] as String?,
  like: json['like'],
  download: json['download'],
  follow: json['follow'],
  attention: json['attention'],
  isFriend: json['isFriend'],
  deviceSecurityCode: json['deviceSecurityCode'] as String?,
  isOldUser: json['isOldUser'] as num?,
);

Map<String, dynamic> _$DataBeanToJson(DataBean instance) => <String, dynamic>{
  'id': ?instance.id,
  'nickname': ?instance.nickname,
  'say': ?instance.say,
  'avatar': ?instance.avatar,
  'mobile': ?instance.mobile,
  'email': ?instance.email,
  'sex': ?instance.sex,
  'countryCodeName': ?instance.countryCodeName,
  'region': ?instance.region,
  'province': ?instance.province,
  'city': ?instance.city,
  'token': ?instance.token,
  'like': ?instance.like,
  'download': ?instance.download,
  'follow': ?instance.follow,
  'attention': ?instance.attention,
  'isFriend': ?instance.isFriend,
  'deviceSecurityCode': ?instance.deviceSecurityCode,
  'isOldUser': ?instance.isOldUser,
};
