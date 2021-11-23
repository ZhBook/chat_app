import 'package:json_annotation/json_annotation.dart';

part 'fileInfo.g.dart';

@JsonSerializable()
class FileInfo {
  FileInfo();

  late String id;
  late String name;
  late bool isImg;
  late String contentType;
  late num size;
  late String path;
  late String url;
  late String source;
  late num createTime;
  late num updateTime;
  
  factory FileInfo.fromJson(Map<String,dynamic> json) => _$FileInfoFromJson(json);
  Map<String, dynamic> toJson() => _$FileInfoToJson(this);
}
