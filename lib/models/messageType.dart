import 'package:json_annotation/json_annotation.dart';

part 'messageType.g.dart';

@JsonSerializable()
class MessageType {
  MessageType();

  late Map<String,dynamic> data;
  late num code;
  late num type;
  
  factory MessageType.fromJson(Map<String,dynamic> json) => _$MessageTypeFromJson(json);
  Map<String, dynamic> toJson() => _$MessageTypeToJson(this);
}
