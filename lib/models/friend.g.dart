// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Friend _$FriendFromJson(Map<String, dynamic> json) => Friend()
  ..id = json['id'] as num
  ..userId = json['userId'] as num
  ..friendId = json['friendId'] as num
  ..nickname = json['nickname'] as String
  ..headImgUrl = json['headImgUrl'] as String;

Map<String, dynamic> _$FriendToJson(Friend instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'friendId': instance.friendId,
      'nickname': instance.nickname,
      'headImgUrl': instance.headImgUrl,
    };
