import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User();

  late num id;
  late String username;
  late String password;
  late String headImgUrl;
  late String phone;
  late num sex;
  late String address;
  late String createTime;
  late num isDelete;
  late String email;
  late String login;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
