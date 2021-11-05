// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) => Login()
  ..data = json['data'] as Map<String, dynamic>
  ..code = json['code'] as num
  ..msg = json['msg'] as String;

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'data': instance.data,
      'code': instance.code,
      'msg': instance.msg,
    };
