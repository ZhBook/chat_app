import 'package:json_annotation/json_annotation.dart';

part 'friendInfo.g.dart';

@JsonSerializable()
class FriendInfo {
  FriendInfo();

  late num id;
  late String username;
  late String nickname;
  late String headImgUrl;
  late String mobile;
  late num sex;
  late String address;
  late String email;
  late String login;
  
  factory FriendInfo.fromJson(Map<String,dynamic> json) => _$FriendInfoFromJson(json);
  Map<String, dynamic> toJson() => _$FriendInfoToJson(this);
}
