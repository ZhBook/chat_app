// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fileInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileInfo _$FileInfoFromJson(Map<String, dynamic> json) => FileInfo()
  ..id = json['id'] as String
  ..name = json['name'] as String
  ..isImg = json['isImg'] as bool
  ..contentType = json['contentType'] as String
  ..size = json['size'] as num
  ..path = json['path'] as String
  ..url = json['url'] as String
  ..source = json['source'] as String
  ..createTime = json['createTime'] as num
  ..updateTime = json['updateTime'] as num;

Map<String, dynamic> _$FileInfoToJson(FileInfo instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isImg': instance.isImg,
      'contentType': instance.contentType,
      'size': instance.size,
      'path': instance.path,
      'url': instance.url,
      'source': instance.source,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
    };
