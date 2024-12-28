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
      if (instance.id case final value?) 'id': value,
      if (instance.nickname case final value?) 'nickname': value,
      if (instance.say case final value?) 'say': value,
      if (instance.avatar case final value?) 'avatar': value,
      if (instance.mobile case final value?) 'mobile': value,
      if (instance.email case final value?) 'email': value,
      if (instance.sex case final value?) 'sex': value,
      if (instance.countryCodeName case final value?) 'countryCodeName': value,
      if (instance.region case final value?) 'region': value,
      if (instance.province case final value?) 'province': value,
      if (instance.city case final value?) 'city': value,
      if (instance.token case final value?) 'token': value,
      if (instance.like case final value?) 'like': value,
      if (instance.download case final value?) 'download': value,
      if (instance.follow case final value?) 'follow': value,
      if (instance.attention case final value?) 'attention': value,
      if (instance.isFriend case final value?) 'isFriend': value,
      if (instance.deviceSecurityCode case final value?)
        'deviceSecurityCode': value,
      if (instance.isOldUser case final value?) 'isOldUser': value,
    };
