import 'package:json_annotation/json_annotation.dart';

part 'pageResult.g.dart';

@JsonSerializable()
class PageResult {
  PageResult();

  late List data;
  late num code;
  late String msg;
  late num pageIndex;
  late num pageSize;
  late num total;
  
  factory PageResult.fromJson(Map<String,dynamic> json) => _$PageResultFromJson(json);
  Map<String, dynamic> toJson() => _$PageResultToJson(this);
}
