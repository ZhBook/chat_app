// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message()
  ..id = json['id'] as num
  ..friendId = json['friendId'] as num
  ..receiveId = json['receiveId'] as num
  ..context = json['context'] as String
  ..url = json['url'] as String
  ..headImgUrl = json['headImgUrl'] as String
  ..type = json['type'] as num
  ..createTime = json['createTime'] as String
  ..haveRead = json['haveRead'] as num
  ..state = json['state'] as String;

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'friendId': instance.friendId,
      'receiveId': instance.receiveId,
      'context': instance.context,
      'url': instance.url,
      'headImgUrl': instance.headImgUrl,
      'type': instance.type,
      'createTime': instance.createTime,
      'haveRead': instance.haveRead,
      'state': instance.state,
    };
