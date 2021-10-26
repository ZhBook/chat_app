import 'package:json_annotation/json_annotation.dart';

part 'chatting.g.dart';

@JsonSerializable()
class Chatting {
  Chatting();

  late num id;
  late num userId;
  late num friendId;
  late String context;
  late String headImgUrl;
  late String url;
  late num type;
  late String updateTime;
  late num haveRead;
  late num state;
  
  factory Chatting.fromJson(Map<String,dynamic> json) => _$ChattingFromJson(json);
  Map<String, dynamic> toJson() => _$ChattingToJson(this);
}
