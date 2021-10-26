// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chatting _$ChattingFromJson(Map<String, dynamic> json) => Chatting()
  ..id = json['id'] as num
  ..userId = json['userId'] as num
  ..friendId = json['friendId'] as num
  ..context = json['context'] as String
  ..headImgUrl = json['headImgUrl'] as String
  ..url = json['url'] as String
  ..type = json['type'] as num
  ..updateTime = json['updateTime'] as String
  ..haveRead = json['haveRead'] as num
  ..state = json['state'] as num;

Map<String, dynamic> _$ChattingToJson(Chatting instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'friendId': instance.friendId,
      'context': instance.context,
      'headImgUrl': instance.headImgUrl,
      'url': instance.url,
      'type': instance.type,
      'updateTime': instance.updateTime,
      'haveRead': instance.haveRead,
      'state': instance.state,
    };
