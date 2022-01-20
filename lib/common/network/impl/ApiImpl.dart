import 'dart:io';
import 'dart:math';

import 'package:chat_app/common/config/Global.dart';
import 'package:chat_app/common/database/DBManage.dart';
import 'package:chat_app/common/network/Request.dart';
import 'package:chat_app/common/network/Urls.dart';
import 'package:chat_app/models/friend.dart';
import 'package:chat_app/models/index.dart';
import 'package:chat_app/models/login.dart';
import 'package:chat_app/models/result.dart';
import 'package:chat_app/models/user.dart';
import 'package:dio/dio.dart';
import 'package:simple_logger/simple_logger.dart';

import '../Api.dart';

class ApiImpl implements Api {
  static final log = SimpleLogger();
  final Dio dio = Request.dio;

  //登陆验证，获取token
  @override
  Future<Login> login(String username, String pwd) async {
    Login login = new Login();
    try {
      var response = await dio.post(Urls.login,
          queryParameters: {
            'grant_type': 'password',
            'username': username,
            'password': pwd,
          },
          options: Options(responseType: ResponseType.json),
          onSendProgress: (int sent, int total) {
        print('$sent $total');
        print("开始请求");
      });
      //登录成功后更新公共头（authorization），此后的所有请求都会带上用户身份信息
      // Map<String, dynamic> responseData = jsonDecode(response.);
      login = Login.fromJson(response.data);
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
        log.info("这是输出的内容：" + Global.profile.toString());
        return login;
      }
    } on DioError catch (e) {
      log.info(e.response);
    }
    return login;
  }

  //账户注册
  @override
  Future<Result> register(User user) async {
    var response = await dio.post(
      Urls.register,
      data: {
        "nickname": user.nickname,
        "password": user.password,
        "mobile": user.mobile,
        "headImgUrl": user.headImgUrl
      },
      options: Options(responseType: ResponseType.json),
    );
    log.info(response.data);
    Result result = Result.fromJson(response.data);
    return result;
  }

  //获取用户信息
  @override
  Future<User> getLoginUserInfo() async {
    var response = await dio.get(Urls.loginInfo);

    User user = User.fromJson(response.data);
    return user;
  }

  //获取好友列表
  @override
  Future<List<Friend>> getFriends() async {
    List<Friend> list = [];
    var response = await dio.get(Urls.friends);
    log.info(response.data);

    PageResult result = PageResult.fromJson(response.data);
    if (result.code == 200) {
      List data = result.data;
      if (result.total == 0) {
        return Future.error(e);
      }
      // var jsonArray = data["data"];
      // var dataList = jsonDecode(jsonArray);
      List<Map<String, dynamic>> listMap =
          new List<Map<String, dynamic>>.from(data);
      listMap.forEach((element) {
        DBManage.createFriendsMessageTable(element["friendId"].toString());
        list.add(Friend.fromJson(element));
      });
      /*list = (jsonArray as List<dynamic>)
          .map((e) => Friend.fromJson((e as Map<String, dynamic>)))
          .toList();*/
      log.info(list);
      DBManage.addFriends(list);
      return list;
    }
    return Future.error("没有好友");
  }

  @override
  Future<void> sendMessage(String friendId, Message message) async {
    var response = await dio.post(
      Urls.sendMessage,
      data: message.toJson(),
      queryParameters: {"receiveId": friendId},
    );
    PageResult result = PageResult.fromJson(response.data);
    if (result.code == 200) {
      log.info("发送成功");
    }
  }

  @override
  Future<List<FriendInfo>> searchFriends(
      String column, int start, int limit) async {
    var response = await dio.post(Urls.searchFriend,
        queryParameters: {"column": column},
        data: {"pageIndex": start, "pageSize": limit});
    PageResult result = PageResult.fromJson(response.data);
    List<FriendInfo> list = [];
    if (result.code == 200) {
      list = result.data.map((element) {
        return FriendInfo.fromJson(element);
      }).toList();
    }
    return list;
  }

  @override
  Future<bool> addFriend(String friendId, String message) async {
    var response = await dio
        .post(Urls.addFriend, data: {"friendId": friendId, "message": message});
    Result result = Result.fromJson(response.data);
    if (result.code == 200) {
      return true;
    }
    return false;
  }

  /**
   * 获取好友请求列表
   */
  @override
  Future<List<FriendRequest>> getRequest() async {
    var response = await dio.get(Urls.getRequest);
    PageResult result = PageResult.fromJson(response.data);
    List<FriendRequest> list = [];
    if (result.code == 200) {
      list = result.data.map((element) {
        return FriendRequest.fromJson(element);
      }).toList();
    }
    return list;
  }

  @override
  Future<bool> handleRequest(num requestId, num isAgree) async {
    var response = await dio.post(Urls.handleRequest,
        data: {"requestId": requestId, "isAgree": isAgree});
    Result result = Result.fromJson(response.data);
    if (result.code == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<FileInfo> uploadImg(String path) async {
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(path),
    });
    var response = await dio.post(Urls.upload, data: formData);
    Result result = Result.fromJson(response.data);
    return FileInfo.fromJson(result.data);
  }

  @override
  Future<bool> commentMoments(String momentsId, String context) {
    // TODO: implement commentMoments
    throw UnimplementedError();
  }

  @override
  Future<PageResult> getMoments(num pageIndex, int pageSize) async {
    var response = await dio.post(Urls.moments_all,
        data: {"pageIndex": pageIndex, "pageSize": pageSize});
    PageResult result = PageResult.fromJson(response.data);

    return result;
  }

  @override
  Future<bool> likesMoments(String momentsId) {
    // TODO: implement likesMoments
    throw UnimplementedError();
  }

  @override
  Future<bool> publishMoments(String context, String images, String video) {
    // TODO: implement publishMoments
    throw UnimplementedError();
  }

  /**
   *接收消息反馈
   */
  @override
  Future<bool> receiveConfirm(String msgId) async {
    var response = await dio.post(Urls.receive_confirm + msgId);
    Result result = Result.fromJson(response.data);
    if (result.code == 200 && result.data == true) {
      return true;
    }
    return false;
  }
}
