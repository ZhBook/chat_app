import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User();

  late num id;
  String username = "username";
  String nickname = "nickname";
  late String password;
  String headImgUrl =
      "https://tensua-file.oss-cn-hangzhou.aliyuncs.com/images/a615ca110e1b47f0bbfc522f4bf3404f.webp";
  String mobile = "13800000000";
  num sex = 0;
  String address = "";
  String email = "";
  late bool login;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
