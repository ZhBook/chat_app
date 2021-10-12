// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..id = json['id'] as num
  ..username = json['username'] as String
  ..password = json['password'] as String
  ..headImgUrl = json['headImgUrl'] as String
  ..phone = json['phone'] as String
  ..sex = json['sex'] as num
  ..address = json['address'] as String
  ..createTime = json['createTime'] as String
  ..isDelete = json['isDelete'] as num
  ..email = json['email'] as String
  ..login = json['login'] as String;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'password': instance.password,
      'headImgUrl': instance.headImgUrl,
      'phone': instance.phone,
      'sex': instance.sex,
      'address': instance.address,
      'createTime': instance.createTime,
      'isDelete': instance.isDelete,
      'email': instance.email,
      'login': instance.login,
    };
