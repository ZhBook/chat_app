import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class Login {
  Login();

  late Map<String,dynamic> data;
  late num code;
  late String msg;
  
  factory Login.fromJson(Map<String,dynamic> json) => _$LoginFromJson(json);
  Map<String, dynamic> toJson() => _$LoginToJson(this);
}
