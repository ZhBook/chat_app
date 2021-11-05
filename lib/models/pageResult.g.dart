// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pageResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageResult _$PageResultFromJson(Map<String, dynamic> json) => PageResult()
  ..data = json['data'] as List<dynamic>
  ..code = json['code'] as num
  ..msg = json['msg'] as String
  ..pageIndex = json['pageIndex'] as num
  ..pageSize = json['pageSize'] as num
  ..total = json['total'] as num;

Map<String, dynamic> _$PageResultToJson(PageResult instance) =>
    <String, dynamic>{
      'data': instance.data,
      'code': instance.code,
      'msg': instance.msg,
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'total': instance.total,
    };
