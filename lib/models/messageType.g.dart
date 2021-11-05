// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messageType.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageType _$MessageTypeFromJson(Map<String, dynamic> json) => MessageType()
  ..data = json['data'] as Map<String, dynamic>
  ..code = json['code'] as num
  ..type = json['type'] as num;

Map<String, dynamic> _$MessageTypeToJson(MessageType instance) =>
    <String, dynamic>{
      'data': instance.data,
      'code': instance.code,
      'type': instance.type,
    };
