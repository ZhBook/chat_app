import 'dart:async';
import 'dart:convert';

import 'package:chat_app/common/event/EventBusUtil.dart';
import 'package:chat_app/common/network/Urls.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MessageUtils {
  // static _instance，_instance //会在编译期被初始化，保证了只被创建一次
  // static final MessageUtils _instance = MessageUtils._internal();
  static final log = SimpleLogger();
  // // //提供了一个工厂方法来获取该类的实例
  // factory MessageUtils() {
  //   return _instance;
  // }
  // MessageUtils();
  static Message message = new Message();
  // 通过私有方法_internal()隐藏了构造方法，防止被误创建
  // MessageUtils._internal() {
  //   // 初始化
  //   init();
  // }

  void init() {
    print("这里初始化");
  }

  static late final IOWebSocketChannel channel;

  // 开始进行链接
  static void connect() {
    channel = IOWebSocketChannel.connect(Urls.webSocketUrl);
    channel.stream.listen(onData, onError: onError, onDone: onDone);
    sendMessage(message);
  }

  // 发送消息
  static void sendMessage(dynamic msg) {
    channel.sink.add(msg);
  }

  // 断连，然后执行重连
  static onDone() {
    log.warning("重连中....");
    debugPrint("Socket is closed");
    channel.sink.close();
    new Timer.periodic(Duration(milliseconds: 5000), (timer) {
      channel = IOWebSocketChannel.connect(Urls.webSocketUrl);
      channel.stream.listen(onData, onError: onError, onDone: onDone);
      sendMessage(message);
    });
    // channel = IOWebSocketChannel.connect("ws://192.168.1.104:58080/webSocket");
    // channel.stream.listen(this.onData, onError: onError, onDone: onDone);
    // sendMessage(message);
  }

  // 错误日志
  static onError(err) {
    log.warning("websocket连接失败");
    debugPrint(err.runtimeType.toString());
    WebSocketChannelException ex = err;
    debugPrint(ex.message);
    channel.sink.close();
  }

  // 接受数据，数据json字符串，然后转成Map
  static onData(event) {
    print('收到消息:' + event);
    Map<String, dynamic> map = json.decode(event);
    message = Message.fromJson(map);
    eventBus.emit(MessageUtils.message);
  }

  static void dispose() {
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
