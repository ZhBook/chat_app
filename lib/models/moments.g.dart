// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Moments _$MomentsFromJson(Map<String, dynamic> json) => Moments()
  ..id = json['id'] as num
  ..userId = json['userId'] as num
  ..context = json['context'] as String
  ..images = json['images'] as String
  ..video = json['video'] as String
  ..createTime = json['createTime'] as num
  ..momentsCommentResponses = json['momentsCommentResponses'] as List<dynamic>
  ..momentsLikesResponses = json['momentsLikesResponses'] as List<dynamic>;

Map<String, dynamic> _$MomentsToJson(Moments instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'context': instance.context,
      'images': instance.images,
      'video': instance.video,
      'createTime': instance.createTime,
      'momentsCommentResponses': instance.momentsCommentResponses,
      'momentsLikesResponses': instance.momentsLikesResponses,
    };
