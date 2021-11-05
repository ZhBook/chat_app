// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Friend _$FriendFromJson(Map<String, dynamic> json) => Friend()
  ..id = json['id'] as num
  ..userId = json['userId'] as num
  ..friendId = json['friendId'] as num
  ..friendNickname = json['friendNickname'] as String
  ..friendHeadUrl = json['friendHeadUrl'] as String;

Map<String, dynamic> _$FriendToJson(Friend instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'friendId': instance.friendId,
      'friendNickname': instance.friendNickname,
      'friendHeadUrl': instance.friendHeadUrl,
    };
