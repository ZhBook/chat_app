import 'dart:convert';
import 'dart:io';

import 'package:chat_app/models/login.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import 'Global.dart';

class Request {
  String basic = 'Basic d2ViQXBwOndlYkFwcA==';

  // 在网络请求过程中可能会需要使用当前的context信息，比如在请求失败时
  // 打开一个新路由，而打开新路由需要context信息。
  Request(this.context) {
    _options =
        Options(extra: {"context": context}, headers: {"Authorization": basic});
  }

  BuildContext context;
  Options _options = new Options();

  static var dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.1.104:9900/api-auth/',
    connectTimeout: 5000,
    receiveTimeout: 100000,
    // 5s
    headers: {
      HttpHeaders.userAgentHeader: 'dio',
      HttpHeaders.authorizationHeader: 'Basic d2ViQXBwOndlYkFwcA==',
      'api': '1.0.0',
      'access_token': '',
    },
    contentType: Headers.jsonContentType,
    // Transform the response data to a String encoded with UTF8.
    // The default value is [ResponseType.JSON].
    responseType: ResponseType.plain,
  ));

  static void init() {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.findProxy = (uri) {
        return "PROXY 192.168.1.104:8888";
      };
    };
    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    /*if (!Global.isRelease) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY 192.168.1.104:8888";
        };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }*/
    // 添加缓存插件
    dio.interceptors.add(Global.netCache);
    // 设置用户token（可能为null，代表未登录）
    dio.options.headers.addAll({
      "access_token": Global.profile.access_token,
    });
  }

  // 登录接口，登录成功后返回用户信息
  Future<Login> login(String username, String pwd) async {
    Login login = new Login();
    var response = await dio.post("oauth/token", queryParameters: {
      'grant_type': 'password',
      'username': username,
      'password': pwd,
    });
    print(response.data);
    //登录成功后更新公共头（authorization），此后的所有请求都会带上用户身份信息
    Map<String, dynamic> responseData = jsonDecode(response.data);
    login = Login.fromJson(responseData);

    print(login.resp_code);
    // response.data.options.headers[HttpHeaders.authorizationHeader] = basic;
    if (login.resp_code == 0) {
      //清空所有缓存
      Global.netCache.cache.clear();
      //更新profile中的token信息
      Global.profile.token_type = login.datas["token_type"];
      Global.profile.access_token = login.datas["access_token"];
      Global.profile.expires_in = login.datas["expires_in"];
      Global.profile.refresh_token = login.datas["refresh_token"];
      Global.profile.scope = login.datas["scope"];
      dio.options.headers.addAll({
        "access_token": login.datas["token_type"],
      });

      // return User.fromJson(response.data);
      print("这是输出的内容：" + Global.profile.toString());
      return login;
    }
    return login;
  }

/*  //获取用户项目列表
  Future<List<Repo>> getRepos(
      {Map<String, dynamic> queryParameters, //query参数，用于接收分页信息
      refresh = false}) async {
    if (refresh) {
      // 列表下拉刷新，需要删除缓存（拦截器中会读取这些信息）
      _options.extra.addAll({"refresh": true, "list": true});
    }
    var r = await dio.get<List>(
      "user/repos",
      queryParameters: queryParameters,
      options: _options,
    );
    return r.data.map((e) => Repo.fromJson(e)).toList();
  }*/
}
