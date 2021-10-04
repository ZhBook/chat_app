import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class Login {
  Login();

  late Map<String,dynamic> datas;
  late num resp_code;
  late String resp_msg;
  
  factory Login.fromJson(Map<String,dynamic> json) => _$LoginFromJson(json);
  Map<String, dynamic> toJson() => _$LoginToJson(this);
}
