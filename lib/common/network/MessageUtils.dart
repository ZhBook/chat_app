import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MessageUtils {
  // 工厂模式
  factory MessageUtils() => _getInstance();
  static MessageUtils get instance => _getInstance();
  static late MessageUtils _instance;
  MessageUtils._internal() {
    // 初始化
    print("1234");
  }
  static MessageUtils _getInstance() {
    if (_instance == null) {
      _instance = new MessageUtils._internal();
    }
    return _instance;
  }

  static IOWebSocketChannel channel =
      IOWebSocketChannel.connect("ws://192.168.1.104:58080/webSocket");

  // 开始进行链接
  void connect(BuildContext context) {
    channel = IOWebSocketChannel.connect("ws://192.168.1.104:58080/webSocket");
    channel.stream.listen(this.onData, onError: onError, onDone: onDone);
    sendMessage("初始化");
  }

  // 发送消息
  void sendMessage(dynamic msg) {
    channel.sink.add(msg);
  }

  // 断连，然后执行重连
  onDone() {
    debugPrint("Socket is closed");
    channel = IOWebSocketChannel.connect("ws://192.168.1.104:58080/webSocket");
    channel.stream.listen(this.onData, onError: onError, onDone: onDone);
  }

  // 错误日志
  onError(err) {
    debugPrint(err.runtimeType.toString());
    WebSocketChannelException ex = err;
    debugPrint(ex.message);
  }

  // 接受数据，数据json字符串，然后转成Map
  onData(event) {
    print('收到消息:' + event);
    Map<String, dynamic> map = json.decode(event);
  }

  void dispose() {
    channel.sink.close();
  }

  // // 手机状态栏弹出推送的消息
  // static void _createNotification(String title, String content) async {
  //   await LocalNotifications.createNotification(
  //     id: _id,
  //     title: title,
  //     content: content,
  //     onNotificationClick: NotificationAction(
  //         actionText: "some action",
  //         callback: _onNotificationClick,
  //         payload: "接收成功！"),
  //   );
  // }
  //
  // static _onNotificationClick(String payload) {
  //   LocalNotifications.removeNotification(_id);
  //   _sendMessage("消息已被阅读");
  // }
}
