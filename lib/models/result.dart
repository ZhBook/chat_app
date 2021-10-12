import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable()
class Result {
  Result();

  late Map<String,dynamic> data;
  late num code;
  late String msg;
  
  factory Result.fromJson(Map<String,dynamic> json) => _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
