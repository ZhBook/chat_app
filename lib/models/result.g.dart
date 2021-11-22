// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result()
  ..data = json['data'] as dynamic
  ..code = json['code'] as num
  ..msg = json['msg'] as String;

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'data': instance.data,
      'code': instance.code,
      'msg': instance.msg,
    };
