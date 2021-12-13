import 'package:chat_app/business/barItem/route/ChattingController.dart';
import 'package:chat_app/business/barItem/route/NewFriendController.dart';
import 'package:chat_app/common/database/DBManage.dart';
import 'package:chat_app/common/utils/UserInfoUtils.dart';
import 'package:chat_app/models/message.dart' as online;
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../main.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Notification {
  /// 提示信息
  static Future<void> showNotification(online.Message message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('709688', '消息通知',
            channelDescription: '用于消息通知',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    ///android ios配置
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
            onDidReceiveLocalNotification: (
              int id,
              String? title,
              String? body,
              String? payload,
            ) async {
              didReceiveLocalNotificationSubject.add(
                ReceivedNotification(
                  id: id,
                  title: title,
                  body: body,
                  payload: payload,
                ),
              );
            });

    ///加载平台初始化设置
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    ///初始化
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
      selectedNotificationPayload = payload;
      selectNotificationSubject.add(payload);

      ///跳转聊天界面
      var msg = await DBManage.getMessages(message.userId.toString(), 0, 20);
      var friend = await DBManage.getFriend(message.userId, message.friendId);
      var userInfo = await UserInfoUtils.getUserInfo();
      if (message.type == 5) {
        Get.to(NewFriend());
      } else {
        Get.to(ChatPage(), arguments: [msg, friend, userInfo]);
      }
    });

    await flutterLocalNotificationsPlugin.show(
        0, message.friendNickname, message.context, platformChannelSpecifics,
        payload: 'item x');
  }
}
