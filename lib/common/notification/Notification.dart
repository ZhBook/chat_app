import 'package:chat_app/models/message.dart' as online;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
    await flutterLocalNotificationsPlugin.show(
        0, message.friendNickname, message.context, platformChannelSpecifics,
        payload: 'item x');
  }
}
