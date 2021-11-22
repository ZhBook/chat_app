import 'package:json_annotation/json_annotation.dart';

part 'friendRequest.g.dart';

@JsonSerializable()
class FriendRequest {
  FriendRequest();

  late num id;
  late num sendUserId;
  late String sendUserUsername;
  late String sendHeadImgUrl;
  late String sendUserNickname;
  late String message;
  late num infoState;
  late num isAgree;

  factory FriendRequest.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FriendRequestToJson(this);
}
