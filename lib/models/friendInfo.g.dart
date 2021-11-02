// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendInfo _$FriendInfoFromJson(Map<String, dynamic> json) => FriendInfo()
  ..id = json['id'] as num
  ..username = json['username'] as String
  ..nickname = json['nickname'] as String
  ..headImgUrl = json['headImgUrl'] as String
  ..mobile = json['mobile'] as String
  ..sex = json['sex'] as num
  ..address = json['address'] as String
  ..email = json['email'] as String
  ..login = json['login'] as String;

Map<String, dynamic> _$FriendInfoToJson(FriendInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'nickname': instance.nickname,
      'headImgUrl': instance.headImgUrl,
      'mobile': instance.mobile,
      'sex': instance.sex,
      'address': instance.address,
      'email': instance.email,
      'login': instance.login,
    };
