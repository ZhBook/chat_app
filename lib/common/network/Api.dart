import 'package:chat_app/models/friend.dart';
import 'package:chat_app/models/login.dart';
import 'package:chat_app/models/result.dart';
import 'package:chat_app/models/user.dart';

abstract class Api {
  Future<Login> login(String username, String pwd);

  Future<Result> register(User user);

  Future<User> getLoginUserInfo();

  Future<List<Friend>> getFriends();
}
