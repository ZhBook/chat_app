// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) => Login()
  ..datas = json['datas'] as Map<String, dynamic>
  ..resp_code = json['resp_code'] as num
  ..resp_msg = json['resp_msg'] as String;

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'datas': instance.datas,
      'resp_code': instance.resp_code,
      'resp_msg': instance.resp_msg,
    };
