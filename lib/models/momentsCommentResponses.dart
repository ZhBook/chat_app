import 'package:json_annotation/json_annotation.dart';

part 'momentsCommentResponses.g.dart';

@JsonSerializable()
class MomentsCommentResponses {
  MomentsCommentResponses();

  late num id;
  late num momentsId;
  late num userId;
  late String context;
  late num createTime;
  
  factory MomentsCommentResponses.fromJson(Map<String,dynamic> json) => _$MomentsCommentResponsesFromJson(json);
  Map<String, dynamic> toJson() => _$MomentsCommentResponsesToJson(this);
}
