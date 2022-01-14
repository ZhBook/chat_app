import 'package:json_annotation/json_annotation.dart';

part 'momentsLikesResponses.g.dart';

@JsonSerializable()
class MomentsLikesResponses {
  MomentsLikesResponses();

  late num id;
  late num momentsId;
  late num userId;
  late num createTime;
  
  factory MomentsLikesResponses.fromJson(Map<String,dynamic> json) => _$MomentsLikesResponsesFromJson(json);
  Map<String, dynamic> toJson() => _$MomentsLikesResponsesToJson(this);
}
