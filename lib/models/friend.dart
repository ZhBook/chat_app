import 'package:json_annotation/json_annotation.dart';

part 'friend.g.dart';

@JsonSerializable()
class Friend {
  Friend();

  late num id;
  late num userId;
  late num friendId;
  late String friendName;
  late String friendHeadUrl;
  
  factory Friend.fromJson(Map<String,dynamic> json) => _$FriendFromJson(json);
  Map<String, dynamic> toJson() => _$FriendToJson(this);
}
