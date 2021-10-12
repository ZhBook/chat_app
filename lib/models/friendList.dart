import 'package:json_annotation/json_annotation.dart';

part 'friendList.g.dart';

@JsonSerializable()
class FriendList {
  FriendList();

  
  factory FriendList.fromJson(Map<String,dynamic> json) => _$FriendListFromJson(json);
  Map<String, dynamic> toJson() => _$FriendListToJson(this);
}
