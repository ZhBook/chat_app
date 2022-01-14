import 'package:json_annotation/json_annotation.dart';

part 'moments.g.dart';

@JsonSerializable()
class Moments {
  Moments();

  late num id;
  late num userId;
  late String context;
  late String images;
  late String video;
  late num createTime;
  late List momentsCommentResponses;
  late List momentsLikesResponses;
  
  factory Moments.fromJson(Map<String,dynamic> json) => _$MomentsFromJson(json);
  Map<String, dynamic> toJson() => _$MomentsToJson(this);
}
