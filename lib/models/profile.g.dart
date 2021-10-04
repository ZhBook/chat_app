// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile()
  ..user = User.fromJson(json['user'] as Map<String, dynamic>)
  ..access_token = json['access_token'] as String
  ..token_type = json['token_type'] as String
  ..refresh_token = json['refresh_token'] as String
  ..expires_in = json['expires_in'] as num
  ..scope = json['scope'] as String
  ..cache = CacheConfig.fromJson(json['cache'] as Map<String, dynamic>)
  ..theme = json['theme'] as num
  ..lastLogin = json['lastLogin'] as String
  ..locale = json['locale'] as String;

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'user': instance.user,
      'access_token': instance.access_token,
      'token_type': instance.token_type,
      'refresh_token': instance.refresh_token,
      'expires_in': instance.expires_in,
      'scope': instance.scope,
      'cache': instance.cache,
      'theme': instance.theme,
      'lastLogin': instance.lastLogin,
      'locale': instance.locale,
    };
