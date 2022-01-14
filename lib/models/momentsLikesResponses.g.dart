// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'momentsLikesResponses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MomentsLikesResponses _$MomentsLikesResponsesFromJson(
        Map<String, dynamic> json) =>
    MomentsLikesResponses()
      ..id = json['id'] as num
      ..momentsId = json['momentsId'] as num
      ..userId = json['userId'] as num
      ..createTime = json['createTime'] as num;

Map<String, dynamic> _$MomentsLikesResponsesToJson(
        MomentsLikesResponses instance) =>
    <String, dynamic>{
      'id': instance.id,
      'momentsId': instance.momentsId,
      'userId': instance.userId,
      'createTime': instance.createTime,
    };
