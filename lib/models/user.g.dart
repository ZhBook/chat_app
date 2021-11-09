// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..id = json['id'] as num
  ..username = json['username'] as String
  ..nickname = json['nickname'] as String
  ..password = json['password'] as String
  ..headImgUrl = json['headImgUrl'] as String
  ..mobile = json['mobile'] as String
  ..sex = json['sex'] as num
  ..address = json['address'] as String
  ..email = json['email'] as String
  ..login = json['login'] as bool;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'nickname': instance.nickname,
      'password': instance.password,
      'headImgUrl': instance.headImgUrl,
      'mobile': instance.mobile,
      'sex': instance.sex,
      'address': instance.address,
      'email': instance.email,
      'login': instance.login,
    };
