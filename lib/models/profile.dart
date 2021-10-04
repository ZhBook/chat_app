import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "cacheConfig.dart";
part 'profile.g.dart';

@JsonSerializable()
class Profile {
  Profile();

  late User user;
  late String access_token;
  late String token_type;
  late String refresh_token;
  late num expires_in;
  late String scope;
  late CacheConfig cache;
  late num theme;
  late String lastLogin;
  late String locale;
  
  factory Profile.fromJson(Map<String,dynamic> json) => _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
