// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'momentsCommentResponses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MomentsCommentResponses _$MomentsCommentResponsesFromJson(
        Map<String, dynamic> json) =>
    MomentsCommentResponses()
      ..id = json['id'] as num
      ..momentsId = json['momentsId'] as num
      ..userId = json['userId'] as num
      ..context = json['context'] as String
      ..createTime = json['createTime'] as num;

Map<String, dynamic> _$MomentsCommentResponsesToJson(
        MomentsCommentResponses instance) =>
    <String, dynamic>{
      'id': instance.id,
      'momentsId': instance.momentsId,
      'userId': instance.userId,
      'context': instance.context,
      'createTime': instance.createTime,
    };
