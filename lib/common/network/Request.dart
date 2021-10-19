import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class Request {
  static String basic = 'Basic d2ViQXBwOndlYkFwcA==';

  // 在网络请求过程中可能会需要使用当前的context信息，比如在请求失败时
  // 打开一个新路由，而打开新路由需要context信息。
  Request(this.context) {
    _options =
        Options(extra: {"context": context}, headers: {"Authorization": basic});
  }

  BuildContext context;
  Options _options = new Options();

  static var dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.3.135:8008/',
    connectTimeout: 5000,
    receiveTimeout: 100000,
    // 5s
    headers: {
      HttpHeaders.userAgentHeader: 'dio',
      HttpHeaders.authorizationHeader: 'Basic d2ViQXBwOndlYkFwcA==',
      'api': '1.0.0',
    },
    contentType: Headers.jsonContentType,
    responseType: ResponseType.plain,
  ));

  static void init() {
    /*(dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.findProxy = (uri) {
        return "PROXY 192.168.3.135:8888";
      };
    };*/
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
    // dio.interceptors.add(Global.netCache);
    // 设置用户token（可能为null，代表未登录）
    /*dio.options.headers.addAll({
      "access_token": Global.profile.access_token,
    });*/
  }
}
