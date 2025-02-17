import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  Message();

  late num id;
  late num friendId;
  late String friendNickname;
  late num userId;
  late String context;
  late String url;
  late String headImgUrl;
  late num type;
  late String createTime;
  late num haveRead;
  late num state;
  
  factory Message.fromJson(Map<String,dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
