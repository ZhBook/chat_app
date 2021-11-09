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
      "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fitem%2F202006%2F07%2F20200607135202_cxfne.jpg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1639021611&t=316906d968c5d8336765debc9ad24fdb";
  String mobile = "13800000000";
  num sex = 0;
  String address = "";
  String email = "";
  late bool login;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
