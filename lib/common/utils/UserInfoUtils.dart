import 'dart:convert';

import 'package:chat_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoUtils {
  //获取当前用户信息
  static Future<User> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userStr = prefs.get("loginUserInfo").toString();
    return User.fromJson(json.decode(userStr));
  }
}
