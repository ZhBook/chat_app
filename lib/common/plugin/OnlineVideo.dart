import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// 定义 App ID 和 Token
const APP_ID = '9e939e9e0eec456ca07d84a2c8b6e0d1';
const Token =
    '0069e939e9e0eec456ca07d84a2c8b6e0d1IAA4fnde9PsqL2pHS9WmhM9aCHdkVxsJGNq3psoSiITOz9JjSIgAAAAAEADfTJIXNkPBYQEAAQA2Q8Fh';
const channelId =
    'https://console.agora.io/invite?sign=a8d680d0b55538c4ebbb34867827c62a%253A1eb40079dabcdf319f58eda97ab83299aab4e5fdf1a5a786345f0750252c1166&step=1';

// 应用类
class OnlineVideo extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

// 应用状态类
class _MyAppState extends State<OnlineVideo> {
  bool _joined = false;
  int _remoteUid = 0;
  bool _switch = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // 初始化应用
  Future<void> initPlatformState() async {
    await [Permission.camera, Permission.microphone].request();

    // 创建 RTC 客户端实例
    RtcEngineContext context = RtcEngineContext(APP_ID);
    var engine = await RtcEngine.createWithContext(context);
    // 定义事件处理逻辑
    engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
      print('加入channel成功 ${channel} ${uid}');
      setState(() {
        _joined = true;
      });
    }, userJoined: (int uid, int elapsed) {
      print('userJoined ${uid}');
      setState(() {
        _remoteUid = uid;
      });
    }, userOffline: (int uid, UserOfflineReason reason) {
      print('用户在线 ${uid}');
      setState(() {
        _remoteUid = 0;
      });
    }));
    // 开启视频
    await engine.enableVideo();
    // 加入频道,频道名为 123，频道场景默认为通信场景。
    await engine.joinChannel(Token, '123', null, 0);
  }

  // 构建 UI，显示本地视图和远端视图
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Flutter example app'),
        // ),
        body: Stack(
          children: [
            Center(
              child: _switch ? _renderRemoteVideo() : _renderLocalPreview(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _switch = !_switch;
                    });
                  },
                  child: Center(
                    child:
                        _switch ? _renderLocalPreview() : _renderRemoteVideo(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 生成本地预览
  Widget _renderLocalPreview() {
    // if (_joined) {
    return RtcLocalView.SurfaceView();
    // } else {
    //   return Text(
    //     '本地加入',
    //     textAlign: TextAlign.center,
    //   );
    // }
  }

  // 生成远端预览
  Widget _renderRemoteVideo() {
    if (_remoteUid != 0) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid,
        channelId: channelId,
      );
    } else {
      return Text(
        '请等待远端加入',
        textAlign: TextAlign.center,
      );
    }
  }
}
