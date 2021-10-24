import 'dart:async';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

enum StatusEnum { connect, connecting, close, closing }

class WebsocketManager {
  static late WebsocketManager _singleton;

  late WebSocketChannel channel;
  factory WebsocketManager() {
    return _singleton;
  }
  StreamController<StatusEnum> socketStatusController =
      StreamController<StatusEnum>();
  WebsocketManager._();
  static void init() {
    if (_singleton == null) {
      _singleton = WebsocketManager._();
    }
  }

  StatusEnum isConnect = StatusEnum.close; //默认为未连接
  String _url = "ws://192.168.1.104:58080/webSocket";

  Future connect() async {
    if (isConnect == StatusEnum.close) {
      isConnect = StatusEnum.connecting;
      socketStatusController.add(StatusEnum.connecting);
      // channel = await IOWebSocketChannel.connect(Uri.parse(_url));
      channel = await IOWebSocketChannel.connect(Uri.parse(_url));

      isConnect = StatusEnum.connect;
      socketStatusController.add(StatusEnum.connect);
      print("socket连接成功");
      return true;
    }
  }

  Future disconnect() async {
    if (isConnect == StatusEnum.connect) {
      isConnect = StatusEnum.closing;
      socketStatusController.add(StatusEnum.closing);
      await channel.sink.close(3000, "主动关闭");
      isConnect = StatusEnum.close;
      socketStatusController.add(StatusEnum.close);
    }
  }

  bool send(String text) {
    if (isConnect == StatusEnum.connect) {
      channel.sink.add(text);
      return true;
    }
    return false;
  }

  void printStatus() {
    if (isConnect == StatusEnum.connect) {
      print("websocket 已连接");
    } else if (isConnect == StatusEnum.connecting) {
      print("websocket 连接中");
    } else if (isConnect == StatusEnum.close) {
      print("websocket 已关闭");
    } else if (isConnect == StatusEnum.closing) {
      print("websocket 关闭中");
    }
  }

  void dispose() {
    socketStatusController.close();
    socketStatusController = StreamController<StatusEnum>();
  }
}
