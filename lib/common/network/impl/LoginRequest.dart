import 'dart:io';

import 'package:chat_app/common/config/Global.dart';
import 'package:chat_app/common/network/Request.dart';
import 'package:chat_app/models/login.dart';
import 'package:chat_app/models/result.dart';
import 'package:chat_app/models/user.dart';
import 'package:dio/dio.dart';

import '../Http.dart';

class LoginRequest implements RequestAbstract {
  final Dio dio = Request.dio;

  @override
  Future<Login> login(String username, String pwd) async {
    Login login = new Login();
    try {
      var response = await dio.post(
        "oauth/token",
        queryParameters: {
          'grant_type': 'password',
          'username': username,
          'password': pwd,
        },
        options: Options(responseType: ResponseType.json),
      );
      print(response.data);
      //登录成功后更新公共头（authorization），此后的所有请求都会带上用户身份信息
      // Map<String, dynamic> responseData = jsonDecode(response.);
      login = Login.fromJson(response.data);
      print(login.code);
      // response.data.options.headers[HttpHeaders.authorizationHeader] = basic;
      if (login.code == 200) {
        //清空所有缓存
        Global.netCache.cache.clear();
        //更新profile中的token信息
        // Global.profile.token_type = login.data["token_type"];
        Global.profile.access_token = login.data["access_token"];
        Global.profile.expires_in = login.data["expires_in"];
        Global.profile.refresh_token = login.data["refresh_token"];
        Global.profile.scope = login.data["scope"];
        dio.options.headers.addAll({
          HttpHeaders.authorizationHeader:
              "Bearer " + login.data["access_token"],
        });

        // return User.fromJson(response.data);
        print("这是输出的内容：" + Global.profile.toString());
        return login;
      }
    } on DioError catch (e) {
      print(e.response);
    }

    return login;
  }

  @override
  Future<Result> register(User user) async {
    var response = await dio.post(
      "api-business/api/v1/users/register",
      data: {
        "nickname": user.nickname,
        "password": user.password,
        "phone": user.phone,
      },
      options: Options(responseType: ResponseType.json),
    );
    print(response.data);
    Result result = Result.fromJson(response.data);
    return result;
  }
}
