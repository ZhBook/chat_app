import 'dart:async';
import 'dart:convert';

import 'package:chat_app/common/event/EventBusUtil.dart';
import 'package:chat_app/common/network/Urls.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/models/messageType.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// WebSocket状态
enum SocketStatus {
  SocketStatusConnected, // 已连接
  SocketStatusFailed, // 失败
  SocketStatusClosed, // 连接关闭
}

/// WebSocket状态
enum MessageTypeEnum {
  PONG, //(0,"心跳测试"),
  TEXT, //(1,"文本消息"),
  VOICE, //(2,"语音"),
  PICTURE, //(3,"图片"),
  VIDEO, //(4,"视频");
}

class WebSocketUtility {
  static final log = SimpleLogger();

  static late IOWebSocketChannel _webSocket; // WebSocket
  static late SocketStatus _socketStatus; // socket状态
  static late Timer _heartBeat; // 心跳定时器
  static int _heartTimes = 3000; // 心跳间隔(毫秒)
  static num _reconnectCount = 60; // 重连次数，默认60次
  static num _reconnectTimes = 0; // 重连计数器
  static late Timer _reconnectTimer; // 重连定时器
  static String message = "";

  Message receiveMsg;

  WebSocketUtility(this.receiveMsg);

  /// 开启WebSocket连接
  static void openSocket() {
    _webSocket = IOWebSocketChannel.connect(Urls.webSocketUrl);
    print('WebSocket连接成功: $Urls.webSocketUrl');
    // 连接成功，返回WebSocket实例
    _socketStatus = SocketStatus.SocketStatusConnected;
    // 连接成功，重置重连计数器
    _reconnectTimes = 0;
    // 接收消息
    _webSocket.stream.listen((data) => webSocketOnMessage(data),
        onError: webSocketOnError, onDone: webSocketOnDone);
    initHeartBeat();
  }

  /// WebSocket接收消息回调
  static webSocketOnMessage(data) {
    MessageType messageType = MessageType.fromJson(json.decode(data));
    num type = messageType.type;
    switch (type) {
      case 0:
        log.info("服务器心跳测试：" + messageType.data.toString());
        break;
      case 1:
        //处理接收的消息
        Message receiveMsg = Message.fromJson(messageType.data);
        EventBusUtils.getInstance().fire(WebSocketUtility(receiveMsg));
        break;
      case 2:
        break;
      default:
        log.info("消息类型不存在");
        break;
    }
    if (data.toString().contains("PONG")) {
      log.info("服务器返回的数据：" + data);
      return;
    }
    log.info("服务器返回的消息：" + data.toString());
    //注册监听
    EventBusUtils.getInstance().fire(WebSocketUtility(data));
  }

  /// WebSocket关闭连接回调
  static webSocketOnDone() {
    print('closed');
    reconnect();
  }

  /// WebSocket连接错误回调
  static webSocketOnError(e) {
    WebSocketChannelException ex = e;
    _socketStatus = SocketStatus.SocketStatusFailed;
    log.warning(ex.message);
    closeSocket();
  }

  /// 初始化心跳
  static void initHeartBeat() {
    // destroyHeartBeat();
    _heartBeat =
        new Timer.periodic(Duration(milliseconds: _heartTimes), (timer) {
      //心跳
    });
  }

  /// 销毁心跳
  static void destroyHeartBeat() {
    if (_heartBeat != null) {
      _heartBeat.cancel();
      // _heartBeat = null;
    }
  }

  /// 关闭WebSocket
  static void closeSocket() {
    if (null != _webSocket) {
      print('WebSocket连接关闭');
      _webSocket.sink.close();
      destroyHeartBeat();
      _socketStatus = SocketStatus.SocketStatusClosed;
    }
  }

  /// 发送WebSocket消息
  static void sendMessage(dynamic msg) {
    message = json.encode(msg);
    if (_webSocket != null) {
      switch (_socketStatus) {
        case SocketStatus.SocketStatusConnected:
          print('发送中：' + message);
          _webSocket.sink.add(message);
          break;
        case SocketStatus.SocketStatusClosed:
          print('连接已关闭');
          break;
        case SocketStatus.SocketStatusFailed:
          print('发送失败');
          break;
        default:
          break;
      }
    }
  }

  /// 重连机制
  static void reconnect() {
    if (_reconnectTimes < _reconnectCount) {
      _reconnectTimes++;
      _reconnectTimer =
          new Timer.periodic(Duration(milliseconds: _heartTimes), (timer) {
        openSocket();
      });
    } else {
      if (_reconnectTimer != null) {
        print('重连次数超过最大次数');
        _reconnectTimer.cancel();
        // _reconnectTimer = null;
      }
      return;
    }
  }
}
