// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendRequest _$FriendRequestFromJson(Map<String, dynamic> json) =>
    FriendRequest()
      ..id = json['id'] as num
      ..sendUserId = json['sendUserId'] as num
      ..sendUserUsername = json['sendUserUsername'] as String
      ..sendHeadImgUrl = json['sendHeadImgUrl'] as String
      ..sendUserNickname = json['sendUserNickname'] as String
      ..message = json['message'] as String
      ..infoState = json['infoState'] as num
      ..isAgree = json['isAgree'] as num;

Map<String, dynamic> _$FriendRequestToJson(FriendRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sendUserId': instance.sendUserId,
      'sendUserUsername': instance.sendUserUsername,
      'sendHeadImgUrl': instance.sendHeadImgUrl,
      'sendUserNickname': instance.sendUserNickname,
      'message': instance.message,
      'infoState': instance.infoState,
      'isAgree': instance.isAgree,
    };
